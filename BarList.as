package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	public class BarList extends MovieClip {
		//private static const num_bar:int = 13;
		private var num_bar:int;
		
		//滑动函数类型
		private var list_type:int;	
		
		//舞台上位置相关
		private static const v_max:Number = 20;
		
		
		//只与直线型有关?
		private static const start_x:Number = 310;
		
		private static const px:Number=-25 ;
		private static const py:Number=60 ;
		
		
		
		private static var bar_width:Number;
		private static var bar_height:Number;
		
		
		
		private var start_y:Number;
		private var end_y:Number;
		
		
		private static var gap_x:Number;
		private static var gap_y:Number;
		
		
		
		
		private static const stop_y:Number = 20;		//鼠标距离focus_y不再滚动的距离
		private static const focus_y:Number = 380;		//mouseY的参考值
		private static const focus_x:Number = 300;		//中间块的参考坐标
		//static var focus_y:Number;
		
		//
		//var mouseY:Number;
		
		private var vy:Number;		//列表滑行速度
		
		public var bar:Array;
		
		public function BarList(listType:int = 2) {
			// constructor code
			list_type = listType;
			//num_bar = num;
			//start_y = -40;
			
			//end_y = start_y + num_bar * py;
			
			
			bar = new Array();
			/*
			//Engine
			bar.push(new Bar(0,"蜘蛛V3", "Spider V3"));
			bar.push(new Bar(1,"毁灭者", "Destoryer"));
			bar.push(new Bar(2,"战锤坦克", "Warhammer"));
			bar.push(new Bar(3,"幽浮", "UFO"));
			//Weapon
			bar.push(new Bar(4,"加农炮", "Cannon-130mm"));
			bar.push(new Bar(5,"喷子", "Tap"));
			bar.push(new Bar(6,"火箭筒", "R.P.G."));
			bar.push(new Bar(7,"M249 SAW", "B51"));
			bar.push(new Bar(8,"光棱", "Prism"));
			bar.push(new Bar(9,"磁暴", "Tesla"));
			bar.push(new Bar(10,"等离子发射器", "PlasmaTorch"));
			bar.push(new Bar(11,"跟踪者导弹", "Tracking Missile Launchcer"));
			bar.push(new Bar(12,"钢牙电锯", "Teeth Electric Saw"));
			*/
			
			/*
			var i:int;
			var size:int = bar.length;
			for (i = 0; i < size; i++)
			{
				addChild(bar[i]);
				
				bar[i].y = start_y + i * py;
				bar[i].x = SlidingF(bar[i].y);
			}
			
			gap_y = end_y - start_y;
			*/
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		
		public function AddBar(b:Bar):void
		{
			bar.push(b);
		}
		
		public function Init():void
		{
			//准备工作做完后，正式加入显示列表前请先调用Init()
			//把bars加入到显示列表
			
			var i:int;
			var size:int = bar.length;
			num_bar = size;
			
			start_y = focus_y - int(num_bar / 2) * py;
			
			for (i = 0; i < size; i++)
			{
				addChild(bar[i]);
				
				//bar[i].y = start_y + i * py;
				bar[i].y = start_y+i * py;
				bar[i].x = SlidingF(bar[i].y);
			}
			end_y = bar[i - 1].y + py;
			gap_y = end_y - start_y;
			
			
			
			//2014_02_26 平移使第一个Bar出现在中间
			var move:Number = focus_y - start_y;
			
			for each(var b:Bar in bar)
			{
				b.y += move;
			}
			//////////////////////////
			
		}
		
		
		
		
		protected function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		protected function onRemoveFromStage(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		
		
		
		public function Update(item:Bar, index:int, ary:Array):void
		{
			
			
			
			
			var d:Number = focus_y - mouseY;
			
			if (d > stop_y)
			{
				vy =(d-stop_y) / 200 * v_max/(1+Math.abs(mouseX-focus_x)/20);
				item.y += vy;
			}
			else if (d < -stop_y)
			{
				vy =(d+stop_y) / 200 * v_max/(1+Math.abs(mouseX-focus_x)/20);
				item.y += vy;
			}
			
			
			if (item.y >= end_y)
			{
				item.y -= gap_y;
			}
			else if (item.y < start_y)
			{
				item.y += gap_y;
			}
			item.x = SlidingF(item.y);
			
			
			
			
			var g:Number = Math.abs(focus_y - item.y);
			var j:Number = 1.5 / Math.exp(g / 200) ;
			//item.alpha=1/(g/45+1)
			
			//item.scaleX =j;
			item.scaleX = j;
			item.alpha = 1 - 2 * g / gap_y;
		}
		
		
		
		
		public function onEnterFrame(event:Event):void
		{
			bar.forEach(Update);
			bar.sortOn(["alpha"],Array.DESCENDING);
			setChildIndex(bar[0], numChildren - 1);
		}
		
		public function SlidingF(y:Number):Number
		{
			//通过y找x
			switch(list_type)
			{
				case 1:
					//一次函数，直线
					return px / py * (y - start_y) + start_x;
				case 2:
					//二次函数，抛物线
					return Math.pow(y - focus_y, 2) / 300 + focus_x;
				case 3:
					//指数函数
					return Math.exp((y - focus_y) / 30) + focus_x;
			}
			return 0;
		}
		
		
		
		
	}
	
}
