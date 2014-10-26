package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class SpiningAnimation extends MovieClip {
		static const EVENT_SPEED_UP:String = "Speed_Up";
		
		private var SPIN_SPEED:Number;
		private const SPIN_SPEED_HIGH:Number = 55;
		private var vr:Number;	//旋转速度
		private var direction:Boolean;	//顺逆时针
		
		public function SpiningAnimation() {
			// constructor code
			SPIN_SPEED = Math.random() * 5;
			vr = SPIN_SPEED;
			direction = Math.random()>0.5;
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function onAddToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//stage.addEventListener(EVENT_SPEED_UP, onSpeedUp);
			stage.addEventListener(Bar.click_event, onSpeedUp);
		}
		
		public function set_direction(d:Boolean):void
		{
			direction = d;
		}
		
		public function onEnterFrame(event:Event):void
		{
			if (direction)
			{
				rotation += vr;
			}
			else
			{
				rotation -= vr;
			}
			
			if (vr > SPIN_SPEED)
			{
				//缓动减速
				vr -= (vr - SPIN_SPEED) * 0.13;
				if (vr - 0.2 <= SPIN_SPEED)
				{
					vr = SPIN_SPEED;
				}
			}
		}
		
		public function onSpeedUp(event:Event):void
		{
			//trace("ss");
			vr = SPIN_SPEED_HIGH;
		}
		
		
		public function onRemoveFromStage(event:Event)
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			//stage.removeEventListener(EVENT_SPEED_UP, onSpeedUp);
			stage.removeEventListener(Bar.click_event, onSpeedUp);
		}
		
		
	}
	
}
