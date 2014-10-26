package
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ShrekShao
	 */
	public class MenuManager 
	{
		protected var state_win:State;
		
		protected var main:MovieClip;	//文档类对应的mc的引用
		
		public function MenuManager(mc:MovieClip) 
		{
			main = mc;
			state_win = new MainWin(this);
			state_win.Enter();
		}
		
		public function ChangeState(s:State):void
		{
			state_win.Exit();
			state_win = s;
			state_win.Enter();
		}
		
		public function AddChildToMain(mc:MovieClip,set_top:int=0):void
		{
			//main.addChild(mc);
			
			switch(set_top)
			{
				case -1:
					//置顶
					main.addChildAt(mc, main.numChildren);
					//main.setChildIndex(mc, main.numChildren - 1);
					//trace(main.numChildren);
					break;
				case -2:
					//置底
					//main.setChildIndex(mc, 0);
					main.addChildAt(mc, 0);
					break;
				default:
					main.addChild(mc);
					break;
			}
		}
		
		public function RemoveChildFromMain(mc:MovieClip):void
		{
			main.removeChild(mc);
		}
		
		
		public function Update():void
		{
			state_win.Execute();
		}
		
	}

}