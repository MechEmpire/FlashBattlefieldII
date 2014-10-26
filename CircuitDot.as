package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flash.filters.GlowFilter;
	
	public class CircuitDot extends MovieClip {
		const event_flash:String = "dot_flash";
		
		private var flash_left_time:int;
		private var dot_filter:Array;
		
		public function CircuitDot() {
			// constructor code
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener(event_flash, Flash);
		}
		
		
		public function onRemoveFromStage(e:Event):void
		{
			stage.removeEventListener(event_flash, Flash);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		
		public function Flash(e:Event=null):void
		{
			//闪一下
			flash_left_time = 100;
			
			
			dot_filter = [new GlowFilter(0xffffff, 0, 16, 16)];
			filters = dot_filter;
			
			
			addEventListener(Event.ENTER_FRAME, Flashing);
		}
		
		public function Flashing(e:Event):void
		{
			//动画内容
			
			//filters.
			if (flash_left_time > 50)
			{
				//强度增加
				filters[0].alpha += 0.1;
			}
			else if (flash_left_time>0)
			{
				//强度减少
				filters[0].alpha -= 0.1;
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, Flashing);
			}
			
			flash_left_time--;
		}
		
		
	}
	
}
