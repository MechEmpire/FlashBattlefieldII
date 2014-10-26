package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	
	public class Hit_Animation extends MovieClip {
		
		
		public function Hit_Animation(type:int,xx:Number,yy:Number,t:Battlefield) {
			// constructor code
			/*
			if (type == 4 || type == 5)
			{
				//光棱磁暴直线效果
			}
			else 
			{
			*/
				gotoAndStop(type + 1);
				x = xx;
				y = yy;
				
				addEventListener(Battlefield.event_hit_remove, t.Remove_Hit_Animation);
			/*
			}
			*/
		}
	}
	
}
