package  {
	
	import flash.display.MovieClip;
	
	
	public class Bullet extends MovieClip {
		
		public var b:int	//type
		
		public var entityID:String;
		
		public var exist:Boolean;
		
		public function Bullet(eID:String,type:int,xx:Number,yy:Number,rr:Number) {
			// constructor code
			entityID = eID;
			b = type;
			x = xx;
			y = yy;
			rotation = rr;
			
			exist = true;
			
			gotoAndStop(b + 1);
		}
	}
	
}
