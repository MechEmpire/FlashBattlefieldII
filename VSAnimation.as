package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class VSAnimation extends MovieClip {
		
		
		public function VSAnimation() {
			// constructor code
			addEventListener(MouseEvent.CLICK, Continue);
		}
		
		public function Continue(e:Event=null)
		{
			gotoAndPlay("over");
		}
		
		
	}
	
}
