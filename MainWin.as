package
{
	import flash.display.*;
	import flash.events.*;
	/**
	 * ...
	 * @author ShrekShao
	 */
	public class MainWin extends State 
	{
		protected var mc:mc_MainWin;
		
		public function MainWin(m:MenuManager)
		{
			super(m);
		}
		
		override public function Execute():void
		{
			//temp
		}
		
		override public function Enter():void
		{
			mc = new mc_MainWin(this);
			mm.AddChildToMain(mc);
		}
		
		override public function Exit():void
		{
			mc.dispatchEvent(new Event(MovieClip_Alpha_Animation.disappear_event));
			//m.RemoveChildFromMain(mc);
		}
		
		
		
		public function ChangeState_Battle():void
		{
			mm.ChangeState(new BattleWin(mm));
		}
		
		public function ChangeState_Introduction():void
		{
			mm.ChangeState(new IntroductionWin(mm));
		}
		
		public function ChangeState_Preview():void
		{
			mm.ChangeState(new PreviewWin(mm));
		}
		
		public function ChangeState_TournamentRanking():void
		{
			mm.ChangeState(new TournamentRankingWin(mm));
		}
		
		
		public function ChangeState_About():void
		{
			mm.ChangeState(new AboutWin(mm));
		}
		
	}

}