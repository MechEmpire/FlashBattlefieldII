package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	
	public class Bar extends MovieClip {
		public var index:int;
		public static const click_event:String = "bar_click";
		
		//public var des:String;		//描述
		
		public static var sound_flip:Sound;
		
		public function Bar(i:int,ch:String,en:String) {
			// constructor code
			txtCh.text = ch;
			txtEn.text = en;
			
			//des = str;
			
			index = i;
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			//addEventListener(MouseEvent.MOUSE_OVER, onOver);
			
			sound_flip = new Sound_Tab();
		}
		
		public function onAddToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onRemoveFromStage(event:Event):void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		public function onClick(event:MouseEvent):void
		{
			//trace(index);
			/*
			dispatchEvent(new Event("Info_Update", true));
			dispatchEvent(new Event("OtherSelected", true));
			dispatchEvent(new Event("Speed_Up", true));
			MovieClip(parent).addEventListener("OtherSelected", onOtherSelected);
			*/
			dispatchEvent(new Event(click_event, true));
			MovieClip(parent).addEventListener(click_event, onOtherSelected);
			//添加滤镜
			var gf:GlowFilter = new GlowFilter(0xFFFFFF, 1, 15, 15);
			filters = [gf];
			//声音
			sound_flip.play();
		}
		
		public function onOver(event:MouseEvent):void
		{
			//removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			//addEventListener(MouseEvent.MOUSE_OUT, onOut);
			
			
			//声音
			//sound_flip.play();
		}
		
		public function onOut(event:MouseEvent):void
		{
			//removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			//addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}
		
		public function onOtherSelected(event:Event):void
		{
			//MovieClip(parent).removeEventListener("OtherSelected", onOtherSelected);
			MovieClip(parent).removeEventListener(click_event, onOtherSelected);
			
			//消除滤镜
			//trace("123");
			filters = [];
		}
		
	}
	
}