package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ShrekShao
	 */
	
	public class PreviewWin extends State 
	{
		protected var mc:mc_PreviewWin;
		
		public function PreviewWin(m:MenuManager) 
		{
			super(m);
		}
		
		
		override public function Execute():void
		{
		}
		
		override public function Enter():void
		{
			mc = new mc_PreviewWin(this);
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