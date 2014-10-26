package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class PointMeter extends MovieClip {
		private var value:int;
		private var target:int;
		private var max:int;
		
		private var value2:int;
		private var target2:int;
		private var max2:int;
		
		private static const speed:Number = 0.5;
		
		public function PointMeter( direction:int = 1,v:int = 0, m:int = 100, v2:int = 0, m2:int = 100 ) {
			// constructor code
			gotoAndStop(direction);
			
			txt_name.text = "HP";
			value = v;
			target = value;
			max = m;
			
			txt_name2.text = "Ammo";
			value2 = v2;
			target2 = value2;
			max2 = m2;
			
			
			meter.gotoAndStop(1);
			meter2.gotoAndStop(2);
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function onAddToStage(event:Event):void
		{
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		
		public function Set_Max(cmax:int,cmax2:int):void
		{
			max = cmax;
			max2 = cmax2;
		}
		
		/*
		public function Update2(current:int):void
		{
			target = current;
		}
		*/
		
		
		public function Update(current:int,current2:int):void
		{
			target = current;
			
			target2 = current2;
			//txtValue.text = String(current);
			if (target < 0)
			{
				target = 0;
			}
			if (target2 < 0)
			{
				target2 = 0;
			}
			
			//temp
			value = target;
			value2 = target2;
			txt_value.text = String(value);
			meter.scaleX = Number(value / max);
			txt_value2.text = String(value2);
			meter2.scaleX = Number(value2 / max2);
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
			
			
			txt_value.text = String(value);
			meter.scaleX = Number(value / max);
			
			
			//2
			
			d = target2-value2;
			if (Math.abs(d) <= 1)
			{
				value2 = target2;
			}
			else
			{
				value2 = int(Number(value2+d * speed));
			}
			
			
			txt_value2.text = String(value2);
			meter2.scaleX = Number(value2 / max2);
		}
		
		
		
		
	}
	
}
