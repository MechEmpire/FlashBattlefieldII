package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	
	import com.oaxoa.fx.Lightning;
	import com.oaxoa.fx.LightningFadeType;
	
	public class Info extends MovieClip_Alpha_Animation {
		protected var state:IntroductionWin;
		
		protected var barlist:BarList;
		
		protected var returnButton:ReturnButton;
		
		
		public var info:Array;
		private var info_des:Array;
		
		private var ci:int;		//当前打字机式字符下标
		private var des:String;
		
		
		//载具的最大参数
		static const height_max:int = 350;
		static const weight_max:int = 70;
		static const armor_max:int = 110;
		static const speed_engine_max:int = 80;
		
		//武器的最大参数
		static const damage_max:int = 35;
		static const speed_max:int = 1000;
		static const cooling_max:int = 100;
		static const ammo_max:int = 50;
		
		
		private var current_index:int;
		private var armor_animation:Boolean;	//armor的效果控制，消失还是出现
		
		private const use_lightning:Boolean = false;
		private const num_lightning:int = 5;
		private var lightning:Vector.<Lightning>;
		//private var lightning:Array;
		private var update_lightning:Boolean;
		
		
		private const armor_focus_x:Number = 265;
		
		
		private var utext:Sound;
		
		private static const init_x = 686.95;
		private static const init_y = 200.65;
		
		public function Info(s:IntroductionWin) {
			
			
			
			x = init_x;
			y = init_y;
			// constructor code
			state = s;
			
			BarListInit();
			
			utext = new Sound_Text();
			
			armor2.scaleX = 0.5;
			armor2.scaleY = 0.5;
			armor.x = armor_focus_x;
			
			update_lightning = false;
			/*
			if (use_lightning)
			{
				lightning = new Vector.<Lightning>;
				var i:int;
				var glow:GlowFilter = new GlowFilter();
				glow.color = 0xffffff;
				glow.strength = 4;
				glow.quality = 3;
				glow.blurX = glow.blurY = 10;
				for (i = 0; i < num_lightning; i++)
				{
					lightning.push(new Lightning(0xddeeff));
					lightning[i].filters = [glow];
					lightning[i].childrenLifeSpanMax = 3;
					lightning[i].childrenLifeSpanMin = 1;
					lightning[i].childrenProbability = 1;
					lightning[i].childrenMaxGenerations = 3;
					lightning[i].childrenMaxCount = 4;
					lightning[i].childrenAngleVariation = 110;
					lightning[i].thickness = 2;
					lightning[i].steps = 50;
					
					
					//lightning[i].childrenDetachedEnd = true;
					//lightning[i].blendMode = "add";
					//lightning[i].childrenDetachedEnd =true;
				}
			//lightning = new Array(num_lightning);
			}
			*/
			
			armor_animation = true;
			ci = 0;
			des = "";
			//temp
			
			
			//version 2014_3_6
			info = new Array([278, 33, 25, 30], [342, 58, 60, 51], [243, 63, 110, 72], [200, 22, 98, 75],
								[25, 800, 30, 10], [10, 750, 80, 8], [35, 600, 100, 5], [7, 1000, 5, 50],
								[20, 1000, 50, 7], [22, 1000, 40, 11], [18, 500, 25, 12], [15, 400, 100, 10], [5, 10, 1, 100]);
			info_des = new Array("行进装置：钛合金三关节蜘蛛爬行爪\n动力核心：液压柴油发动机\n拥有八只机械爪的蜘蛛型载具，无需转向即可向任何方向爬行，不过这种外置式无保护的部件也降低了其抗击性能"
									,"行进装置：隼式液压活塞机械腿\n动力核心：核子能反应堆\n最为先进的人形机甲，直立3关节下肢允许他在静止中改变朝向，是灵活性、操纵性、防护性的上佳平衡"
									,"行进装置：复合金属履带\n动力核心：AGT-1500燃气涡轮发动机\n充斥冰冷的铆钉铁链与履带，暴力美学的完美诠释，不过强大的战斗力需要开阔的空间才能尽情释放"
									,"行进装置：涡轮喷气推进器\n动力核心：磁能反应炉\n代表未来科技，整个机甲悬浮于空中，喷气推进提供动力，行动如幽灵般轻盈飘忽"
									,"精度损失：普通\n炮弹类型：普通\n有着震天巨响和大口径的传统火炮，粗犷而不事雕琢，实用和可靠地代名词"
									,"精度损失：普通\n炮弹类型：多发散射\n一声巨响之后是扑面而来的霰弹砂，近程无解的覆盖面和，让所有物体难以靠近的恐怖炮塔"
									,"精度损失：小\n炮弹类型：火箭推进+爆炸伤害\n巨大口径的发射筒散发着榴弹的暴力气息，被击中目标方圆十里内将化为乌有"
									,"精度损失：大\n炮弹类型：普通\n旋转的组合枪管不停歇地射出银色子弹，未知合金制成，具备极佳冷却性能，有着难以置信的射速，可惜这是以一定设计精度为代价的"
									,"精度损失：普通\n炮弹类型：射线\n来自欧美盟军的先进科技，棱镜折射激光将高热和能量集中于一点，瞬间将目标引爆"
									,"精度损失：很大\n炮弹类型：射线偏离\n来自苏联红军的先进科技，高能线圈释放出致命电弧击穿射程内的金属装备"
									,"精度损失：普通\n炮弹类型：触壁反弹\n来自宇宙的未来科技，发射出的等离子体具有物体斥性，从而可以在墙壁间反弹穿梭"
									,"精度损失：普通\n炮弹类型：跟踪\n地球武器中的王者，跟踪导弹一旦咬住目标就不会放弃追逐"
									,"精度损失：-\n炮弹类型：-\n血腥暴力的原始性肉搏武器，钢牙拉锯装甲，重重火花裂溅，在近距离将是极其致命的");
			
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function ChangePointMeterName_Update(index:int):void
		{
			if (index <= 3)
			{
				//engine
				m0.txtName.text = "Height";
				m1.txtName.text = "Weight";
				m2.txtName.text = "Armor";
				m3.txtName.text = "Speed";
				
				m0.Update(info[index][0], height_max);
				m1.Update(info[index][1], weight_max);
				m2.Update(info[index][2], armor_max);
				m3.Update(info[index][3], speed_engine_max);
			}
			else
			{
				//weapon
				m0.txtName.text = "Damage";
				m1.txtName.text = "Speed";
				m2.txtName.text = "Cooling";
				m3.txtName.text = "Ammo";
				
				m0.Update(info[index][0], damage_max);
				m1.Update(info[index][1], speed_max);
				m2.Update(info[index][2], cooling_max);
				m3.Update(info[index][3], ammo_max);
			}
		}
		
		
		
		
		public function BarListInit():void
		{
			//introduction page
			barlist = new BarList(2);
			
			
			
			//Engine
			barlist.AddBar(new Bar(0,"蜘蛛V3", "Spider V3"));
			barlist.AddBar(new Bar(1,"毁灭者", "Destoryer"));
			barlist.AddBar(new Bar(2,"战锤坦克", "Warhammer"));
			barlist.AddBar(new Bar(3,"幽浮", "UFO"));
			//Weapon
			barlist.AddBar(new Bar(4,"加农炮", "Cannon-130mm"));
			barlist.AddBar(new Bar(5,"霰弹枪", "Shotgun"));
			barlist.AddBar(new Bar(6,"火箭筒", "R.P.G."));
			barlist.AddBar(new Bar(7,"M249 SAW", "B51"));
			barlist.AddBar(new Bar(8,"光棱", "Prism"));
			barlist.AddBar(new Bar(9,"磁暴", "Tesla"));
			barlist.AddBar(new Bar(10,"等离子发射器", "PlasmaTorch"));
			barlist.AddBar(new Bar(11,"爱国者飞弹", "MIM-104 Patriot"));
			barlist.AddBar(new Bar(12,"钢牙电锯", "Electric Saw"));
			
			
			barlist.Init();
			barlist.x = -init_x;
			barlist.y = -init_y;
		}
		
		
		
		
		public function onAddToStage(event:Event)
		{
			//stage.addEventListener("Info_Update", onUpdate);
			addEventListener(Bar.click_event, onUpdate);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			m0.meter.gotoAndStop(1);
			m1.meter.gotoAndStop(2);
			m2.meter.gotoAndStop(3);
			m3.meter.gotoAndStop(4);
			
			armor.gotoAndStop(15);
			//Update(0);
			
			
			addChild(barlist);
			
			
			//return button
			
			returnButton = new ReturnButton();
			returnButton.x = mc_MainWin.returnbutton_x-x;
			returnButton.y = mc_MainWin.returnbutton_y-y;
			addChild(returnButton);
			returnButton.addEventListener(MouseEvent.CLICK, ReturnToMain);
			
			////
			
			dispatchEvent(new Event("back_adjust", true));
			dispatchEvent(new Event("frame_meter", true));//真蛋疼的设计。。
		}
		
		public function onRemoveFromStage(e:Event)
		{
			
			returnButton.removeEventListener(MouseEvent.CLICK, ReturnToMain);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			removeEventListener(Bar.click_event, onUpdate);
		}
		
		protected function ReturnToMain(e:MouseEvent)
		{
			dispatchEvent(new Event("frame_meter_invisible", true));
			state.ReturnToMain();
		}
		
		
		public function Update(index:int):void
		{
			//柱状图的指标名称
			ChangePointMeterName_Update(index);
			
			
			
			des = info_des[index];
			ci = 0;
			description.text = "";
			
			//var l:Lightning = new Lightning(armor.x, armor.y, armor.x, armor.y - 400);
			//addChild(l);
			//addChild(new Lightning(armor.x, armor.y, armor.x, armor.y - 400));
			
			//armor.gotoAndStop(index+1);
			current_index = index;
		}
		
		public function onUpdate(event:Event):void
		{
			//trace(12345678);
			//trace(event.target.index);
			Update(event.target.index);
			
			/*
			if (use_lightning)
			{
				LightningUpdate();
			}
			*/
			
			armor_animation = false;
			
			armor2.gotoAndStop(current_index + 1);
			
			//armor2.width = 442;
			armor2.x = armor_focus_x + 200;
			armor2.scale_X = 0.5;
			armor2.scale_Y = 0.5;
			armor2.alpha = 0;
			armor2.visible = true;
			
			//description.text = event.target.des;
		}
		
		public function onEnterFrame(event:Event):void
		{
			if (ci < des.length)
			{
				
				description.appendText(des.charAt(ci));
				ci++;
				
				if (ci % 2 == 0)
				{
					utext.play();
				}
			}
			
			if (!armor_animation)
			{
				if (armor.alpha <= 0)
				{
					armor.gotoAndStop(current_index + 1);
					
					armor2.visible = false;
					armor2.scaleX = 0.5;
					armor2.scaleY = 0.5;
					
					
					armor.x = armor_focus_x;
					armor.scaleX = 1;
					armor.scaleY = 1;
					armor.alpha = 1;
					
					
					armor_animation = true;
				}
				else
				{
					//armor淡出
					armor.alpha -= 0.1;
					armor.scaleX -= 0.05;
					armor.scaleY -= 0.05;
					armor.x -= 20;
					
					//armor2淡入
					armor2.alpha += 0.1;
					armor2.scaleX += 0.05;
					armor2.scaleY += 0.05;
					armor2.x -= 20;
					
					
				}
			}
			/*
			else
			{
				if (armor.alpha < 1)
				{
					armor.alpha += 0.2;
				}
			}
			*/
			
			/*
			//闪电效果（可选）
			if (update_lightning)
			{
				for each(var item:Lightning in lightning)
				{
					item.x += (Math.random() - 0.5) * 10;
					item.update();
				}
				if (armor.alpha >= 1)
				{
					update_lightning = false;
					for each(var items:Lightning in lightning)
					{
						removeChild(items);
					}
				}
				//setChildIndex(board, numChildren - 1);
			}
			*/
		}
		
		/*
		public function LightningUpdate():void
		{
			update_lightning = true;
			for each(var item:Lightning in lightning)
			{
				item.startY = 30*(Math.random()-0.5)+10;
				item.endY = armor.y +90 + (Math.random()-0.5) * 100;
				item.startX = 0;
				item.endX = 0;
				
				addChild(item);
				item.x = armor.x + (Math.random() - 0.5) * 300;
				item.y = 0;
				
				item.maxLength = item.endY - item.startY - 10;;
				item.maxLengthVary = 15;
			}
		}
		*/
		
		
	}
	
}
