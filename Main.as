package  {
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.URLRequest;
	
	public class Main extends MovieClip {
		
		public static const event_play_bgm:String = "play_bgm";
		public static const event_stop_bgm:String = "stop_bgm";
		
		protected var bgm:Sound;
		protected var bgm_channel:SoundChannel;
		
		protected static const num_line:int = 70;
		protected static const line_gap:Number = 768 / num_line;
		
		
		protected var mm:MenuManager;		//mm=menu_manager
		
		//temp
		
		
		public function Main() {
			// constructor code
			stage.displayState = StageDisplayState.FULL_SCREEN;
			
			DrawBackground();
			
			mm = new MenuManager(this);
			
			
			
			Init();
		}
		
		
		public function Init():void
		{
			//mm.Update();
			//addEventListener(MouseEvent.CLICK, click);
			addEventListener("close_stop", invisable_frame);
			addEventListener("back_adjust", visable_frame);
			addEventListener("frame_meter", frame_meter_visible);
			addEventListener("frame_meter_invisible", frame_meter_invisible);
			addEventListener(event_play_bgm, play_bgm);
			addEventListener(event_stop_bgm, stop_bgm);
			
			bgm = new Sound();
			bgm.load(new URLRequest("bgm050.mp3"), new SoundLoaderContext(5000, true));
			//bgm_channel=bgm.play(0, int.MAX_VALUE);
			play_bgm(null);
		}
		
		public function play_bgm(e:Event):void
		{
			bgm_channel=bgm.play(0, int.MAX_VALUE);
		}
		public function stop_bgm(e:Event):void
		{
			bgm_channel.stop();
		}
		
		/*
		public function click(e:MouseEvent):void
		{
			mm.Update();
			removeEventListener(MouseEvent.CLICK, click);
			
			addEventListener("close_stop", invisable_frame);
		}
		*/
		
		
		
		
		public function DrawBackground():void
		{
			graphics.lineStyle(0.5, 0x001111);
			var i:int = 0;
			for (i = 0; i < num_line; i++)
			{
				graphics.moveTo(-20, i * line_gap);
				graphics.lineTo(1400, i * line_gap);
			}
			
			//addChild(new Back_Animation_6());
			//addChild(new Front_Board());
		}
		
		public function invisable_frame(e:Event):void
		{
			b.visible = false;
			ba.visible = false;
			setChildIndex(curtain,numChildren-1);
		}
		
		
		public function visable_frame(e:Event):void
		{
			b.gotoAndStop(1);
			b.visible = true;
			ba.visible = true;
			
			setChildIndex(ba, 0);
			setChildIndex(b, numChildren - 1);
			setChildIndex(Iron_Board, numChildren - 1);
			setChildIndex(curtain,numChildren-1);
		}
		
		public function frame_meter_visible(e:Event):void
		{
			b.gotoAndStop(2);
		}
		public function frame_meter_invisible(e:Event):void
		{
			b.gotoAndStop(1);
		}
		
	}
	
}
