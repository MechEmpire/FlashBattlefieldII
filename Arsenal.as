package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	
	public class Arsenal extends MovieClip {
		
		protected var time:int;
		protected var up:Boolean;
		
		protected var is_flashing:Boolean;
		
		public function Arsenal() {
			// constructor code
			time = 1;
			up = true;
			
			is_flashing = false;
			
			
		}
		
		public function f(t:int):int
		{
			//Flash对时间的函数
			return t*5;
		}
		
		
		public function Flashing(e:Event):void
		{
			if (time >= 50)
			{
				up = false;
			}
			else if (time <= 1)
			{
				up = true;
			}
			
			if (up)
			{
				time++;
			}
			else
			{
				time--;
			}
			
			transform.colorTransform = new ColorTransform(1, 1, 1, 1, f(time), f(time), f(time), 0);
		}
		
		
		
		
		public function Update(respawning_time:int):void
		{
			alpha = 1-Number(respawning_time/1000);
			
			
			if (respawning_time <= 0 && is_flashing==false)
			{
				is_flashing = true;
				addEventListener(Event.ENTER_FRAME, Flashing);
			}
			else if(is_flashing==true && respawning_time>0)
			{
				is_flashing = false;
				removeEventListener(Event.ENTER_FRAME, Flashing);
				transform.colorTransform = new ColorTransform();
			}
			
		}
		
		
	}
	
}
