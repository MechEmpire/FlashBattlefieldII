package  
{
	/**
	 * ...
	 * @author ShrekShao
	 */
	import flash.events.*;
	 
	public class TournamentRankingWin extends State 
	{
	
		protected var mc:mc_TournamentRankingWin;
		
		public function TournamentRankingWin(m:MenuManager) 
		{
			super(m);
			
		}
	
		
		override public function Execute():void
		{
		}
		
		override public function Enter():void
		{
			mc = new mc_TournamentRankingWin(this);
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