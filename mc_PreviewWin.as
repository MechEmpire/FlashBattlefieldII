package  {
	import slider.SimpleSlider;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class mc_PreviewWin extends MovieClip_Alpha_Animation {
		
		protected static const display_x:Number = 1050;
		protected static const display_y:Number = 412;
		
		
		protected var state:PreviewWin;		//所属状态的引用
		
		protected var returnButton:ReturnButton;	//返回MainWin按钮
		
		
		
		//specialized Window items
		
		//robot display mc
		protected var robot:Robot;
		
		protected var weapon_transform:ColorTransform;
		protected var engine_transform:ColorTransform;
		
		
		//weapon,engine switcher
		protected var weapon_switcher:Switcher;
		protected var engine_switcher:Switcher;
		
		//Slider for color control
		protected var weapon_red:SimpleSlider;
		protected var weapon_green:SimpleSlider;
		protected var weapon_blue:SimpleSlider;
		
		protected var engine_red:SimpleSlider;
		protected var engine_green:SimpleSlider;
		protected var engine_blue:SimpleSlider;
		/////////////////////
		
		
		
		public function mc_PreviewWin(s:PreviewWin) {
			// constructor code
			state = s;
			
			
			robot = new Robot();
			weapon_transform = new ColorTransform();
			engine_transform = new ColorTransform();
			robot.weapon.transform.colorTransform = weapon_transform;
			robot.engine.transform.colorTransform = engine_transform;
			/*
			robot.weapon.transform.colorTransform.redMultiplier = 1;
			robot.weapon.transform.colorTransform.greenMultiplier = 1;
			robot.weapon.transform.colorTransform.blueMultiplier = 1;
			*/
			
			weapon_switcher = new Switcher("武器炮塔\nweapon");
			weapon_switcher.name_list.push("加农炮\nCannon", "霰弹枪\nTap", "火箭筒\nR.P.G.", "M249 SAW\nB51"
											,"光棱\nPrism", "磁暴\nTesla", "等离子\nPlasmaTorch", "爱国者飞弹\nMIM-104 Patriot"
											,"钢牙电锯\nElectric Saw");
			weapon_switcher.addEventListener(Event.CHANGE, ChangeWeapon);
			weapon_switcher.init();
			addChild(weapon_switcher);
			
			engine_switcher = new Switcher("引擎载具\nengine");
			engine_switcher.name_list.push("蜘蛛V3\nSpiderV3", "毁灭者\nDestoryer", "战锤坦克\nWarhammer", "幽浮\nUFO");
			engine_switcher.addEventListener(Event.CHANGE, ChangeEngine);
			engine_switcher.init();
			
			
			//todo:slider
			weapon_red = new SimpleSlider( -255, 255, 0, "WR");
			weapon_red.addEventListener(Event.CHANGE, ChangeWeaponRed);
			weapon_green = new SimpleSlider( -255, 255, 0, "WG");
			weapon_green.addEventListener(Event.CHANGE, ChangeWeaponGreen);
			weapon_blue = new SimpleSlider( -255, 255, 0, "WB");
			weapon_blue.addEventListener(Event.CHANGE, ChangeWeaponBlue);
			
			engine_red = new SimpleSlider( -255, 255, 0, "ER");
			engine_red.addEventListener(Event.CHANGE, ChangeEngineRed);
			engine_green = new SimpleSlider( -255, 255, 0, "EG");
			engine_green.addEventListener(Event.CHANGE, ChangeEngineGreen);
			engine_blue = new SimpleSlider( -255, 255, 0, "EB");
			engine_blue.addEventListener(Event.CHANGE, ChangeEngineBlue);
			////////////////
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		protected function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			//return button
			returnButton = new ReturnButton();
			returnButton.x = mc_MainWin.returnbutton_x-x;
			returnButton.y = mc_MainWin.returnbutton_y-y;
			addChild(returnButton);
			returnButton.addEventListener(MouseEvent.CLICK, ReturnToMain);
			///////////
			
			SetWindows();
			
			addEventListener(Event.ENTER_FRAME, Robot_Rotation);
		}
		
		
		protected function ChangeWeapon(e:Event):void
		{
			robot.Set_Weapon(e.target.get_current());
		}
		protected function ChangeEngine(e:Event):void
		{
			robot.Set_Engine(e.target.get_current());
		}
		
		protected function ChangeWeaponRed(e:Event):void
		{
			weapon_transform.redOffset = weapon_red.value;
			robot.weapon.transform.colorTransform = weapon_transform;
		}
		protected function ChangeWeaponGreen(e:Event):void
		{
			weapon_transform.greenOffset = weapon_green.value;
			robot.weapon.transform.colorTransform = weapon_transform;
		}
		protected function ChangeWeaponBlue(e:Event):void
		{
			weapon_transform.blueOffset = weapon_blue.value;
			robot.weapon.transform.colorTransform = weapon_transform;
		}
		
		protected function ChangeEngineRed(e:Event):void
		{
			engine_transform.redOffset = engine_red.value;
			robot.engine.transform.colorTransform = engine_transform;
		}
		protected function ChangeEngineGreen(e:Event):void
		{
			engine_transform.greenOffset = engine_green.value;
			robot.engine.transform.colorTransform = engine_transform;
		}
		protected function ChangeEngineBlue(e:Event):void
		{
			engine_transform.blueOffset = engine_blue.value;
			robot.engine.transform.colorTransform = engine_transform;
		}
		
		
		
		
		
		
		protected function SetWindows():void
		{
			//窗口布局,安排控件位置
			weapon_red.x = 420;
			weapon_red.y = 400;
			addChild(weapon_red);
			weapon_green.x = 460;
			weapon_green.y = 400;
			addChild(weapon_green);
			weapon_blue.x = 500;
			weapon_blue.y = 400;
			addChild(weapon_blue);
			
			engine_red.x = 570;
			engine_red.y = 400;
			addChild(engine_red);
			engine_green.x = 610;
			engine_green.y = 400;
			addChild(engine_green);
			engine_blue.x = 650;
			engine_blue.y = 400;
			addChild(engine_blue);
			
			
			
			
			
			var display0:SpiningAnimation = new SpiningAnimation();
			display0.x = display_x;
			display0.y = display_y;
			display0.set_direction(true);
			addChild(display0);
			
			var display1:SpiningAnimation = new SpiningAnimation();
			display1.x = display_x;
			display1.y = display_y;
			display1.scaleX = 0.6;
			display1.scaleY = 0.6;
			display1.set_direction(false);
			addChild(display1);
			
			robot.scaleX = 2;
			robot.scaleY = 2;
			robot.x = display_x;
			robot.y = display_y;
			addChild(robot);
			
			weapon_switcher.x = 580;
			weapon_switcher.y = 180;
			addChild(weapon_switcher);
			
			engine_switcher.x = 580;
			engine_switcher.y = 255;
			addChild(engine_switcher);
		}
		
		
		protected function ReturnToMain(e:MouseEvent):void
		{
			state.ReturnToMain();
		}
		
		protected function onRemoveFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			removeEventListener(Event.ENTER_FRAME, Robot_Rotation);
			
			weapon_red.removeEventListener(Event.CHANGE, ChangeWeaponRed);
		}
		
		
		protected function Robot_Rotation(e:Event):void
		{
			robot.rotation += 0.3;
			robot.weapon.rotation += 0.5;
		}
		
	}
	
}
