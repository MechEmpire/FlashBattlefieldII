package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FramRateController extends MovieClip {
		
		
		public function FramRateController() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(event:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			faster.addEventListener(MouseEvent.CLICK, onFaster);
			slower.addEventListener(MouseEvent.CLICK, onSlower);
		}
		
		public function onRemovedFromStage(event:Event)
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			faster.removeEventListener(MouseEvent.CLICK, onFaster);
			slower.removeEventListener(MouseEvent.CLICK, onSlower);
		}
		
		public function onFaster(e:MouseEvent)
		{
			if (stage.frameRate < 60)
			{
				stage.frameRate += 5;
			}
		}
		public function onSlower(e:MouseEvent)
		{
			if (stage.frameRate > 30)
			{
				stage.frameRate -= 5;
			}
		}
		
	}
	
}
