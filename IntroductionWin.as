package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ShrekShao
	 */
	public class IntroductionWin extends State 
	{
		protected var mc:Info;
		
		public function IntroductionWin(m:MenuManager) 
		{
			super(m);
		}
		
		
		override public function Execute():void
		{
		}
		
		override public function Enter():void
		{
			mc = new Info(this);
			mm.AddChildToMain(mc);
		}
		
		override public function Exit():void
		{
			mc.dispatchEvent(new Event(MovieClip_Alpha_Animation.disappear_event));
			
		}
		
		public function ReturnToMain():void
		{
			mm.ChangeState(new MainWin(mm));
		}
	}

}