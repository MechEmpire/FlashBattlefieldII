package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class Armor3DDisplay extends MovieClip {
		
		
		public function Armor3DDisplay() {
			// constructor code
		}
		
		public function Init(wpn:int,egn:int,wr:int,wg:int,wb:int,er:int,eg:int,eb:int):void
		{
			visible = true;
			weapon.gotoAndStop(uint(wpn) + 1);
			weapon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, wr, wg, wb);
			engine.gotoAndStop(uint(egn) + 1);
			engine.transform.colorTransform = new ColorTransform(1, 1, 1, 1,er,eg,eb);
		}
		
		public function Disappear():void
		{
			weapon.gotoAndStop("null");
			engine.gotoAndStop("null");
			
			visible = false;
		}
		
	}
	
}
