package{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Weapon extends MovieClip {
		
		public var w:int;		//type
		
		public function Weapon() {
			// constructor code
		}
		
		
		public function Set_Type(ww:int):void
		{
			w = ww;
			gotoAndStop(w + 1);
			
			/*
			switch(w)
			{
				
			}
			*/
		}
		
		public function Fire():void
		{
			weapon.gotoAndPlay("fire");
		}
		
	}
	
}
