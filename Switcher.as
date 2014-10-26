package  {
	
	//import fl.video.VideoAlign;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	
	
	public class Switcher extends MovieClip {
		protected static var sound_tab:Sound_Tab;
		protected var current_index:int;
		
		public var name_list:Vector.<String>;
		
		public function Switcher(itemname:String="武器\nweapon") {
			// constructor code
			tf_item.text = itemname;
			current_index = 0;
			
			name_list = new Vector.<String>();
			
			sound_tab = new Sound_Tab();
		}
		
		
		public function init():void
		{
			//call this after this switcher is ready
			update();
			lb.addEventListener(MouseEvent.CLICK, move_left);
			rb.addEventListener(MouseEvent.CLICK, move_right);
		}
		
		protected function update():void
		{
			dispatchEvent(new Event(Event.CHANGE));
			tf_current.text = name_list[current_index];
		}
		
		protected function move_left(e:MouseEvent):void
		{
			sound_tab.play();
			if (current_index > 0)
			{
				current_index--;
			}
			else
			{
				current_index = name_list.length - 1;
			}
			update();
			
			//temp for animation
			dispatchEvent(new Event(Bar.click_event, true));
		}
		
		protected function move_right(e:MouseEvent):void
		{
			sound_tab.play();
			if (current_index < name_list.length - 1)
			{
				current_index++;
			}
			else
			{
				current_index = 0;
			}
			update();
			//temp for animation
			dispatchEvent(new Event(Bar.click_event, true));
		}
		
		
		public function get_current():int
		{
			return current_index;
		}
		
		
		
	}
	
}
