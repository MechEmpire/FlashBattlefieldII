package  
{
	
	/**
	 * ...
	 * @author ShrekShao
	 */
	
	 import flash.display.*
	 import flash.geom.ColorTransform;
	 import flash.net.*;
	 import flash.events.*;
	 
	public class mc_TournamentRankingWin extends MovieClip_Alpha_Animation 
	{
		protected var fileRef:FileReference;
		
		
		protected var state:TournamentRankingWin;		//所属状态的引用
		
		protected var returnButton:ReturnButton;	//返回MainWin按钮
		
		
		protected var num_ai:int;
		
		//ranking bar
		protected static const num_rank:int = 5;
		
		
		protected static const start_x:Number = 285;
		protected static const start_y:Number = 232;
		
		protected static const gap_x:Number = 40;
		protected static const gap_y:Number = 70;
		////////////////////////////
		
		protected var rank_bar_vec:Vector.<PointMeter3>;	//胜率条的引用
		
		protected var cur_rank:int;		//当前显示信息的
		
		//load_info
		protected var text_load:String;
		
		protected var rank_data:Array;
		
		protected var tournament_name:String;
		
		
		protected static const index_robot:int = 0;
		protected static const index_robot_name:int = 0;
		protected static const index_robot_author:int = 1;
		protected static const index_robot_weapon:int = 2;
		protected static const index_robot_engine:int = 3;
		
		protected static const index_robot_wred:int = 4;
		protected static const index_robot_wgreen:int = 5;
		protected static const index_robot_wblue:int = 6;
		
		protected static const index_robot_ered:int = 7;
		protected static const index_robot_egreen:int = 8;
		protected static const index_robot_eblue:int = 9;
		
		
		
		protected static const index_tournamentinfo:int = 1;
		protected static const index_tournamentinfo_battles:int = 0;
		protected static const index_tournamentinfo_win:int = 1;
		protected static const index_tournamentinfo_lose:int = 2;
		protected static const index_tournamentinfo_winrate:int = 3;
		protected static const index_tournamentinfo_hitrate:int = 4;
		
		
		protected static const index_global:int = 2;
		
		protected static const index_average:int = 3;
		
		protected static const index_best:int = 4;
		
		
		//battle_achievement_struct
		protected static const index_battle_fire:int = 0;
		protected static const index_battle_hit:int = 1;
		protected static const index_battle_damage:int = 2;
		protected static const index_battle_output:int = 3;
		
		///////////////////////////
		
		
		public function mc_TournamentRankingWin(s:TournamentRankingWin) 
		{
			cur_rank = 1;
			state = s;
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			rank_bar_vec = new Vector.<PointMeter3>;
			
			
			weapon.gotoAndStop(10);
			engine.gotoAndStop(5);
		}
		
		protected function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			//return button
			returnButton = new ReturnButton();
			returnButton.x = mc_MainWin.returnbutton_x-x;
			returnButton.y = mc_MainWin.returnbutton_y-y;
			addChild(returnButton);
			returnButton.addEventListener(MouseEvent.CLICK, ReturnToMain);
			///////////
			
			
			LoadTournamentInfo();
			//Init();
			
		}
		
		protected function LoadTournamentInfo():void
		{
			fileRef = new FileReference();
			fileRef.browse([new FileFilter("联赛信息", "*.txt"),
				new FileFilter("所有文件", "*")]);
			fileRef.addEventListener(Event.SELECT, onLoadSelect, false, 0, true);
			fileRef.addEventListener(Event.CANCEL, onCancel, false, 0, true);
		}
		
		public function onLoadSelect(event:Event):void
		{
			fileRef.load();
			fileRef.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		public function onLoadComplete(event:Event):void
		{
			text_load = fileRef.data.readMultiByte(fileRef.data.length, "cn-gb");
			//trace(text_load);
			//载入界面事件派发？
			HandleInfo();
			Init();
			
			btn_left.addEventListener(MouseEvent.CLICK, onLeftButton);
			btn_right.addEventListener(MouseEvent.CLICK, onRightButton);
		}
		
		public function onLeftButton(e:MouseEvent):void
		{
			if (cur_rank > 1)
			{
				cur_rank--;
				Init_Armor(cur_rank);
				Init_Statistics(cur_rank);
			}
			
		}
		
		public function onRightButton(e:MouseEvent):void
		{
			if (cur_rank < num_ai)
			{
				cur_rank++;
				Init_Armor(cur_rank);
				Init_Statistics(cur_rank);
			}
		}
		
		
		
		public function HandleInfo():void
		{
			rank_data = text_load.split('\r\n');
			
			//trace(rank_data[0]);
			//trace(rank_data[1]);
			rank_data[0] = rank_data[0].split('|');
			
			tournament_name = rank_data[0][0];
			//trace(tournament_name);
			
			var tmp:int = rank_data.length-1;
			var i:int;
			for (i = 1; i < tmp; i++)
			{
				rank_data[i] = rank_data[i].split('|');
				rank_data[i][index_robot] = rank_data[i][index_robot].split(',');
				rank_data[i][index_tournamentinfo] = rank_data[i][index_tournamentinfo].split(',');
				rank_data[i][index_global] = rank_data[i][index_global].split(',');
				rank_data[i][index_average] = rank_data[i][index_average].split(',');
				rank_data[i][index_best] = rank_data[i][index_best].split(',');
				
				//trace(rank_data[i][index_robot][index_robot_author]);
				//trace(rank_data[i][index_best][0]);
			}
			num_ai = i - 1;
			
		}
		
		
		
		public function onCancel(event:Event):void
		{
			//dispatchEvent(new Event("cancel"));
		}
		
		
		
		
		
		
		
		
		protected function Init():void
		{
			//初始化各信息
			
			//排名list
			Init_Rank();
			
			//联赛名称
			txtTournamentName.text = "联赛  " + tournament_name;
			
			//右侧冠军信息
			Init_Armor(1);
			
			//冠军数据
			Init_Statistics(cur_rank);
		}
		
		public function Init_Rank():void
		{
			var i:int;
			
			var tmp:int=num_rank;
			if (num_ai < num_rank)
			{
				tmp = num_ai;
			}
			
			for (i = 0; i < tmp; i++)
			{
				rank_bar_vec.push(new PointMeter3(i+1,i+1));
				rank_bar_vec[i].SetText(rank_data[i + 1][index_robot][index_robot_name], rank_data[i + 1][index_robot][index_robot_author]);
				rank_bar_vec[i].Update(rank_data[i + 1][index_tournamentinfo][index_tournamentinfo_win], rank_data[i + 1][index_tournamentinfo][index_tournamentinfo_battles]);
				
				rank_bar_vec[i].x = start_x + i * gap_x;
				rank_bar_vec[i].y = start_y + i * gap_y;
				addChild(rank_bar_vec[i]);
			}
		}
		
		public function Init_Armor(rank:int):void
		{
			var i:int = rank;
			
			
			weapon.gotoAndStop(uint(rank_data[i][index_robot][index_robot_weapon]) + 1);
			
			
			weapon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, rank_data[i][index_robot][index_robot_wred], rank_data[i][index_robot][index_robot_wgreen], rank_data[i][index_robot][index_robot_wblue]);
			
			engine.gotoAndStop(uint(rank_data[i][index_robot][index_robot_engine]) + 1);
			engine.transform.colorTransform = new ColorTransform(1, 1, 1, 1,rank_data[i][index_robot][index_robot_ered],rank_data[i][index_robot][index_robot_egreen],rank_data[i][index_robot][index_robot_eblue]);
		}
		
		public function Init_Statistics(rank:int):void
		{
			var i:int = rank;
			
			var t:String;
			t = rank_data[i][index_robot][index_robot_name] + "\n            By " + rank_data[i][index_robot][index_robot_author];
			t += "\n 胜场：" + rank_data[i][index_tournamentinfo][index_tournamentinfo_win] + "/" + rank_data[i][index_tournamentinfo][index_tournamentinfo_battles];
			t += "\n   胜率：" + (Number(rank_data[i][index_tournamentinfo][index_tournamentinfo_winrate]) * 100).toFixed(2) + " %";
			t += "\n     命中率：" + (Number(rank_data[i][index_tournamentinfo][index_tournamentinfo_hitrate])* 100).toFixed(2)  + " %";
			t += "\n       场均开火：" + rank_data[i][index_average][index_battle_fire];
			t += "\n         场均命中：" + rank_data[i][index_average][index_battle_hit];
			t += "\n           场均损坏：" + rank_data[i][index_average][index_battle_damage];
			t += "\n             场均输出：" + rank_data[i][index_average][index_battle_output];
			txtStatistics.text = t;
			txtRankNum.text = "Rank " + String(cur_rank);
		}
		
		
		
		
		protected function onRemoveFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		
		protected function ReturnToMain(e:MouseEvent):void
		{
			state.ReturnToMain();
		}
		
		
	}

}