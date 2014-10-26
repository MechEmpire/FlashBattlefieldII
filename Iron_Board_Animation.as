package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Iron_Board_Animation extends MovieClip {
		
		
		public function Iron_Board_Animation() {
			// constructor code
			gotoAndStop("start");
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
		}
		public function onAddToStage(event:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener("start_play", Start_Play);
			stage.addEventListener("close_stop", Close_Stop);
			stage.addEventListener("open_play", Open_Play);
			stage.addEventListener("start_stop", Start_Stop);
		}
		
		
		public function Start_Play(event:Event):void
		{
			visible = true;
			gotoAndPlay("start");
		}
		
		public function Start_Stop(event:Event):void
		{
			visible = false;
			gotoAndStop("start");
		}
		
		public function Close_Stop(event:Event):void
		{
			gotoAndStop("close");
		}
		
		public function Open_Play(event:Event):void
		{
			gotoAndPlay("open");
		}
	}
	
}
