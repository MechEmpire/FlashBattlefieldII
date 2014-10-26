package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	
	
	public class Robot extends MovieClip {
		
		public var r_name:String;
		public var author:String;
		
		protected var weapon_type:int;
		protected var engine_type:int;
		
		protected var run:Boolean;
		
		protected var exist:Boolean;
		
		
		public function Robot(n:String="",a:String="") 
		{
			// constructor code
			exist = true;
			
			r_name = n;
			author = a;
			
			
			run = false;
			
			weapon_type = -1;
			engine_type = -1;
			/*
			weapon_type = w;
			engine_type = e;
			
			weapon.gotoAndStop(w+1);
			engine.gotoAndStop(e+1);
			*/
		}
		
		public function Set_Weapon_Engine(w:int, e:int):void
		{
			Set_Weapon(w);
			
			Set_Engine(e);
		}
		
		public function Set_Weapon(w:int):void
		{
			if (weapon_type != w)
			{
				weapon_type = w;
				weapon.Set_Type(w);
				
			}
		}
		public function Set_Engine(e:int):void
		{
			if (engine_type != e)
			{
				engine_type = e;
				engine.Set_Type(e);
			}
		}
		
		public function Run_Animation():void
		{
			if (!run)
			{
				//trace("asdfasfdasf");
				run = true;
				engine.Run_Animation();
			}
		}
		
		public function Stop_Animation():void
		{
			if (run)
			{
				run = false;
				engine.Stop_Animation();
			}
		}
		
		public function Explode_Animation():void
		{
			//event.target.removeEventListener("explode_animation", Explode_Animation);
			exist = false;
			
			new S_Explo9().play();
			addChild(new Explode_Robot);
			engine.Stop_Animation();
			
			addEventListener(Event.ENTER_FRAME, Disappear);
		}
		
		public function IsExist():Boolean
		{
			return exist;
		}
		
		public function Disappear(event:Event):void
		{	
			if (alpha <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, Disappear);
				dispatchEvent(new Event("remove"));
			}
			else
			{
				alpha -= 0.1;
			}
		}
		
	}
	
}
