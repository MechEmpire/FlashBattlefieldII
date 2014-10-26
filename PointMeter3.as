package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	//information board  里的柱状器
	
	public class PointMeter3 extends MovieClip {
		private var value:int;
		private var target:int;
		private var max:int
		
		private static const speed:Number = 0.5;
		
		public function PointMeter3(rank:int,color:uint=1) {
			// constructor code
			value = 0;
			
			txtName.text = "胜场";
			txtRank.text = String(rank);
			
			meter.gotoAndStop(color);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function onAddToStage(event:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function SetText(armor_name:String,author_name:String):void
		{
			txtArmorInfo.text = armor_name + "   " + author_name;
		}
		
		
		
		public function Update(current:int,cmax:int):void
		{
			target = current;
			max = cmax;
			//txtValue.text = String(current);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event:Event):void
		{
			/*
			//相同时间填充
			var d:Number = target-value;
			if (Math.abs(d) <= 1)
			{
				value = target;
				
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			else
			{
				value = int(Number(value+d * speed));
			}
			*/
			
			
			//速度相同
			if (target > value)
			{
				value += 1;
				if (value > target)
				{
					value = target;
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
			else if (target < value)
			{
				value-= 1;
				if (value < target)
				{
					value = target;
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
			
			
			txtValue.text = String(value)+"/"+String(max);
			meter.scaleX = Number(value / max);
		}
		
		
		
		
	}
	
}
