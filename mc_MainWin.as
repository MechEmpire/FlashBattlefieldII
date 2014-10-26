package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.system.fscommand;
	
	
	
	public class mc_MainWin extends MovieClip_Alpha_Animation {
		
		//主菜单MovieClip
		//默认returnbutton的位置
		public static const returnbutton_x:Number = 82;
		public static const returnbutton_y:Number = 556;
		
		protected var state:MainWin;		//所属状态的引用
		protected var bar_list:BarList;
		
		
		
		public function mc_MainWin(s:MainWin) {
			// constructor code
			state = s;
			bar_list = new BarList(2);
			
			
			
			
			bar_list.AddBar(new Bar(0, "播放战斗", "Play Battle Record"));
			bar_list.AddBar(new Bar(1, "机甲介绍", "Armor Introduction"));
			bar_list.AddBar(new Bar(2, "参数预览", "Parameter Preview"));
			bar_list.AddBar(new Bar(3, "离开战场", "Exit Battlefield"));
			bar_list.AddBar(new Bar(4, "联赛排行", "Tournament Ranking"));
			bar_list.AddBar(new Bar(5, "关于赛事", "About"));
			
			
			bar_list.Init();
			addChild(bar_list);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage2);
			
			//temp
			
		}
		
		public function onAddToStage2(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage2);
			
			
			bar_list.bar[0].addEventListener(MouseEvent.CLICK, PlayBattleRecord);
			bar_list.bar[1].addEventListener(MouseEvent.CLICK, ArmorIntroduction);
			bar_list.bar[2].addEventListener(MouseEvent.CLICK, ParameterPreview);
			bar_list.bar[3].addEventListener(MouseEvent.CLICK, Exit);
			bar_list.bar[4].addEventListener(MouseEvent.CLICK, TournamentRanking);
			bar_list.bar[5].addEventListener(MouseEvent.CLICK, About);
		}
		
		public function PlayBattleRecord(e:MouseEvent):void
		{
			state.ChangeState_Battle();
			//todo:停止声音
			//bgm_channel.stop();
		}
		
		public function ArmorIntroduction(e:MouseEvent):void
		{
			state.ChangeState_Introduction();
		}
		
		public function ParameterPreview(e:MouseEvent):void
		{
			state.ChangeState_Preview();
		}
		
		public function TournamentRanking(e:MouseEvent):void
		{
			state.ChangeState_TournamentRanking();
		}
		
		
		
		public function About(e:MouseEvent):void
		{
			state.ChangeState_About();
		}
		
		public function Exit(e:MouseEvent):void
		{
			//stage.nativeWindow.close();
			fscommand("quit");
		}
		
	}
	
}
