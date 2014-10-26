package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	//information board  里的柱状器
	
	public class PointMeter2 extends MovieClip {
		private var value:int;
		private var target:int;
		private var max:int
		
		private static const speed:Number = 0.5;
		
		public function PointMeter2() {
			// constructor code
			value = 0;
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function onAddToStage(event:Event):void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function Update(current:int,cmax:int):void
		{
			target = current;
			max = cmax;
			//txtValue.text = String(current);
			
		}
		
		public function onEnterFrame(event:Event):void
		{
			var d:Number = target-value;
			if (Math.abs(d) <= 1)
			{
				value = target;
			}
			else
			{
				value = int(Number(value+d * speed));
			}
			
			
			/*
			if (target > value)
			{
				value += 5;
				if (value > target)
				{
					value = target;
				}
			}
			else if (target < value)
			{
				value-= 5;
				if (value < target)
				{
					value = target;
				}
			}
			*/
			
			txtValue.text = String(value);
			meter.scaleX = Number(value / max);
		}
		
		
		
		
	}
	
}
