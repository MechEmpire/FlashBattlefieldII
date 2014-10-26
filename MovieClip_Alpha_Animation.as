package 
{
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.events.Event;
	/**
	 * ...
	 * @author ShrekShao
	 */
	public class MovieClip_Alpha_Animation extends MovieClip
	{
		public static const appear_event:String = "appear";
		public static const disappear_event:String = "disappear";
		
		protected static const alpha_speed:Number = 0.1;
		protected static const scale_speed:Number = 0.02;
		
		
		public function MovieClip_Alpha_Animation()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage_my);
		}
		
		public function onAddToStage_my(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage_my);
			Appear();
			//addEventListener(disappear_event, Disappear);
		}
		
		public function Appear():void
		{
			stage.quality = StageQuality.LOW;
			
			alpha = 0;
			scaleX = 1.0 / alpha_speed * scale_speed + 1.0;
			scaleY = scaleX;
			addEventListener(Event.ENTER_FRAME, AppearFrameEvent);
		}
		
		public function Disappear(e:Event):void
		{
			stage.quality = StageQuality.LOW;
			if (alpha < 1)
			{
				alpha = 1;
				removeEventListener(Event.ENTER_FRAME, AppearFrameEvent);
			}
			addEventListener(Event.ENTER_FRAME, DisappearFrameEvent);
		}
		
		public function AppearFrameEvent(e:Event):void
		{
			alpha += alpha_speed;
			scaleX -= scale_speed;
			scaleY = scaleX;
			if (alpha >=1)
			{
				stage.quality = StageQuality.HIGH;
				removeEventListener(Event.ENTER_FRAME, AppearFrameEvent);
				addEventListener(disappear_event, Disappear);
			}
		}
		
		
		
		public function DisappearFrameEvent(e:Event):void
		{
			alpha -= alpha_speed;
			scaleX += scale_speed;
			scaleY = scaleX;
			if (alpha <= 0)
			{
				stage.quality = StageQuality.HIGH;
				
				removeEventListener(Event.ENTER_FRAME, DisappearFrameEvent);
				removeEventListener(disappear_event, Disappear);
				
				MovieClip(parent).removeChild(this);
			}
		}
		
	}
	
}