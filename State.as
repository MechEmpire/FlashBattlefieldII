package
{
	import flash.events.*;
	/**
	 * ...
	 * @author ShrekShao
	 */
	public class State extends EventDispatcher
	{
		protected var mm:MenuManager;
		public function State(m:MenuManager) 
		{
			mm = m;
		}
		
		public function Execute():void{};
		public function Enter():void{};
		public function Exit():void{};
	}

}