package
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ShrekShao
	 */
	public class BattleWin extends State 
	{
		protected var btf:Battlefield;
		
		public function BattleWin(m:MenuManager) 
		{
			super(m);
		}
		
		override public function Execute():void
		{
			
		}
		
		override public function Enter():void
		{
			btf = new Battlefield();
			
			btf.addEventListener("ReturnToMain", ReturnToMain);
			btf.addEventListener("CancelToMain", CancelToMain);
			//stage.addChild(btf);
			mm.AddChildToMain(btf,-1);
			btf.NewBattle();
		}
		
		override public function Exit():void
		{
			//stage.removeChild(btf);
			
			
			
			
			
		}
		
		
		public function CancelToMain(e:Event):void
		{
			btf.dispatchEvent(new Event("open_play", true));
			
			mm.ChangeState(new MainWin(mm));
			btf.dispatchEvent(new Event("back_adjust", true));
			btf.dispatchEvent(new Event(Main.event_play_bgm, true));
			mm.RemoveChildFromMain(btf);
		}
		
		
		public function ReturnToMain(e:Event):void
		{
			
			btf.dispatchEvent(new Event("start_play", true));
			btf.stage.addEventListener("close_stop", BackToMain);
			
		}
		
		public function BackToMain(e:Event):void
		{
			btf.stage.removeEventListener("close_stop", BackToMain);
			btf.dispatchEvent(new Event("open_play", true));
			
			mm.ChangeState(new MainWin(mm));
			btf.dispatchEvent(new Event("back_adjust", true));
			btf.dispatchEvent(new Event(Main.event_play_bgm, true));
			mm.RemoveChildFromMain(btf);
		}
		
	}

}