package  {
	//双人版
	import flash.events.Event;
	import flash.events.MouseEvent;
	import rcm.RecordManager;
	import flash.display.MovieClip;
	
	
	public class Achievement_Board extends MovieClip_Alpha_Animation {
		protected var info:Array;
		protected var name0:String;
		protected var name1:String;
		protected var winner:int;
		
		protected var returnButton:ReturnButton;	//返回MainWin按钮
		
		
		
		public function Achievement_Board(ary:Array,n0:String,n1:String,w:int) {
			// constructor code
			info = ary;
			name0 = n0;
			name1 = n1;
			winner = w;
			
			DisplayText();
			ShowWinner();
			//return button
			
			returnButton = new ReturnButton();
			returnButton.x = 0;
			returnButton.y = 200;
			addChild(returnButton);
			returnButton.addEventListener(MouseEvent.CLICK, ReturnToMain);
			
			////
			
		}
		
		protected function ReturnToMain(e:MouseEvent)
		{
			dispatchEvent(new Event("ReturnToMain", true));
			//MovieClip(parent).state.ReturnToMain();
		}
		
		protected function ShowWinner():void
		{
			
			if (winner >= 0)
			{
				var mc:MovieClip = new Winner_Sign();
				addChild(mc);
				if (winner == 0)
				{
					mc.x = -130;
					mc.y = -190;
				}
				else if (winner == 1)
				{
					mc.x = 75;
					mc.y = -190;
				}
			}
			
		
			
		}
		
		
		protected function DisplayText():void
		{
			property.text = "\nVS\n\n开火\n命中\n命中率\n受到伤害\n输出伤害\n出入伤害比";
			
			var i:int;
			var rate0:Number, rate1:Number;
			
			i = 0;
			
			rate0 = Number(info[i][RecordManager.index_ach_hit]) / Number(info[i][RecordManager.index_ach_fire]);
			rate1 = Number(info[i][RecordManager.index_ach_output]) / Number(info[i][RecordManager.index_ach_damage]);
			
			var temp:String = rate0.toFixed(4);
			var temp2:String = rate1.toFixed(4);
			
			data0.text = "\n"+name0
							+"\n\n"+info[i][RecordManager.index_ach_fire]
							+"\n" + info[i][RecordManager.index_ach_hit]
							//+"\n" + rate0.toFixed(4);
							+"\n" + temp
							+"\n" + info[i][RecordManager.index_ach_damage]
							+"\n" + info[i][RecordManager.index_ach_output]
							//+"\n" + rate1.toFixed(4);
							+"\n" + temp2;
							
							
							
			i = 1;
			
			
			
			rate0 = Number(info[i][RecordManager.index_ach_hit]) / Number(info[i][RecordManager.index_ach_fire]);
			rate1 = Number(info[i][RecordManager.index_ach_output]) / Number(info[i][RecordManager.index_ach_damage]);
			
			temp = rate0.toFixed(4);
			temp2 = rate1.toFixed(4);
			
			data1.text = "\n" + name1 
							+"\n\n"+info[i][RecordManager.index_ach_fire]
							+"\n" + info[i][RecordManager.index_ach_hit]
							//+"\n" + rate0.toFixed(4)
							+"\n"+temp
							+"\n" + info[i][RecordManager.index_ach_damage]
							+"\n" + info[i][RecordManager.index_ach_output]
							//+"\n" + rate1.toFixed(4);
							+"\n" + temp2;
							
		}
	}
	
}
