package{
	
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;	
	
	public class Engine extends MovieClip {
		public var e:int;
		
		public function Engine() {
			// constructor code
			
		}
		
		public function Set_Type(ee:int):void
		{
			e = ee;
			gotoAndStop(e + 1);
			
			switch(e)
			{
				case 0:
					//Spider
					engine.l0.gotoAndStop("middle");
					engine.l2.gotoAndStop("middle");
					engine.l4.gotoAndStop("middle");
					engine.l6.gotoAndStop("middle");
					
					engine.l1.gotoAndStop("start");
					engine.l3.gotoAndStop("start");
					engine.l5.gotoAndStop("start");
					engine.l7.gotoAndStop("start");
					break;
					
				case 1:
					//Destroyer
					engine.gotoAndStop("start");
			}
		}
		
		
		public function Run_Animation():void
		{
			switch(e)
			{
				case 0:
					//Spider
					
					engine.l0.play();
					engine.l2.play();
					engine.l4.play();
					engine.l6.play();
					
					engine.l1.play();
					engine.l3.play();
					engine.l5.play();
					engine.l7.play();
					
					/*
					engine.l0.gotoAndPlay("middle");
					engine.l2.gotoAndPlay("middle");
					engine.l4.gotoAndPlay("middle");
					engine.l6.gotoAndPlay("middle");
					
					engine.l1.gotoAndPlay("start");
					engine.l3.gotoAndPlay("start");
					engine.l5.gotoAndPlay("start");
					engine.l7.gotoAndPlay("start");
					*/
					
					break;
					
				case 1:
					//Destroyer
					engine.play();
					
					break;
			}
		}
		
		
		public function Stop_Animation():void
		{
			switch(e)
			{
				case 0:
					engine.l0.stop();
					engine.l2.stop();
					engine.l4.stop();
					engine.l6.stop();
					
					engine.l1.stop();
					engine.l3.stop();
					engine.l5.stop();
					engine.l7.stop();
					
					break;
					
				case 1:
					engine.stop();
					break;
			}
		}
		
		
		
		
		
	}
	
}
