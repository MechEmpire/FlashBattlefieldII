package 
{
	import com.oaxoa.fx.Lightning;
	import com.oaxoa.fx.LightningFadeType;
	import flash.media.SoundChannel;
	
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import rcm.RecordManager;
	//import Robot;
	
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	
	import flash.media.SoundTransform;
	
	import flash.display.*;
	import flash.events.Event;
	
	public class Battlefield extends MovieClip
	{
		
		protected var record_manager:RecordManager;
		
		protected var arsenal:Vector.<Arsenal>;
		
		protected var obstacle:Vector.<Obstacle>;
		
		protected var robot:Vector.<Robot>;
		
		protected var bullet:Vector.<Bullet>;
		
		protected var cf:uint;			//currentFrame
		
		
		protected var point_meter:Vector.<PointMeter>;
		
		
		
		protected var sound_fire:Array;
		protected var sound_hit:Array;		
		
		static const event_hit_remove:String = "Hit_Remove";
		
		protected var prism_filter:Array;
		protected var tesla_filter:Array;
		
		
		static const vsanimation_x:Number = 683;
		static const vsanimation_y:Number = 384;
		
		
		public function Battlefield()
		{
			//construction code
			prism_filter = [new GlowFilter(0x0099ff)];
			tesla_filter= [new GlowFilter(0xcc99ff)];
			
			//temp
			record_manager = new RecordManager();
			
			arsenal = new Vector.<Arsenal>();
			obstacle = new Vector.<Obstacle>();
			robot = new Vector.<Robot>();
			bullet = new Vector.<Bullet>();
			
			sound_fire = new Array();
			sound_fire.push(new S_Fire0());
			sound_fire.push(new S_Fire1());
			sound_fire.push(new S_Fire2());
			sound_fire.push(new S_Fire3());
			sound_fire.push(new S_Fire4());
			sound_fire.push(new S_Fire5());
			sound_fire.push(new S_Fire6());
			sound_fire.push(new S_Fire7());
			sound_fire.push(new S_Fire8());
			sound_fire.push(new S_Fire0());	//grenade temp
			//TODO..
			
			
			sound_hit = new Array();
			sound_hit.push(new S_Explo0());
			sound_hit.push(new S_Explo1());
			sound_hit.push(new S_Explo2());
			sound_hit.push(new S_Explo3());
			sound_hit.push(new S_Explo0());//4
			sound_hit.push(new S_Explo0());//5
			sound_hit.push(new S_Explo6());
			sound_hit.push(new S_Explo7());
			sound_hit.push(new S_Explo8());
			sound_hit.push(new S_Explo2());	//grenade temp
			//sound_hit.push(new S_Explo9());
			//TODO..
			
			
			
			point_meter = new Vector.<PointMeter>;
		}
		
		public function NewBattle():void
		{
			cf = 1;
			
			record_manager.addEventListener("cancel",CancelBattle );
			
			dispatchEvent(new Event(Main.event_stop_bgm, true));
			dispatchEvent(new Event("start_play", true));
			stage.addEventListener("close_stop", StartLoading);
				
		}
		
		public function CancelBattle(e:Event):void
		{
			//修改。。这封装的越来越烂，结构越来越烂了
			dispatchEvent(new Event("CancelToMain"));
		}
		
		public function StartLoading(event:Event):void
		{
			stage.removeEventListener("close_stop", StartLoading);
			
			addEventListener(RecordManager.event_load,record_manager.onLoadFile);
			dispatchEvent(new Event(RecordManager.event_load));
			
			//record_manager.addEventListener(RecordManager.event_complete, onEnterBattle);
			record_manager.addEventListener(RecordManager.event_complete, onEnterBattle);
			//stage.addChild(this);
		}
		
		
		
		/*
		public function FinishLoading(evnet:Event = null):void
		{
			record_manager.removeEventListener(RecordManager.event_complete, FinishLoading);
			
			dispatchEvent(new Event("open_play", true));
			
			stage.addEventListener("start_stop", onEnterBattle);
		}
		*/
		
		
		
		public function onEnterBattle(event:Event = null):void
		{
				
			
			record_manager.removeEventListener(RecordManager.event_complete, onEnterBattle);
			
			dispatchEvent(new Event("open_play", true));
			
			//invisable背景框架?
			
			
			
			//stage.addEventListener("start_stop", PlayBattle);
			stage.addEventListener("start_stop", DisplayVSAnimation);
			
			//录像数据载入完成了进入战斗
			var temp:int;
			var i:int;
			
			
			DrawBoundary();
			Build_PointMeter();
			
			//draw Arsenal
			temp = record_manager.arsenal_data.length;
			for (i = 0; i < temp; i++)
			{
				arsenal.push(new Arsenal());
				arsenal[i].x = record_manager.arsenal_data[i][RecordManager.index_a_x];
				arsenal[i].y = record_manager.arsenal_data[i][RecordManager.index_a_y];
				//arsenal[i].width = arsenal[i].height = 2 * record_manager.arsenal_data[i][RecordManager.index_a_r];
				
				addChild(arsenal[i]);
			}
			
			
			
			
			
			
			
			
			//draw Obstacle
			temp = record_manager.obstacle_data.length;
			for (i = 0; i < temp; i++)
			{
				obstacle.push(new Obstacle());
				obstacle[i].x = record_manager.obstacle_data[i][RecordManager.index_o_x];
				obstacle[i].y = record_manager.obstacle_data[i][RecordManager.index_o_y];
				obstacle[i].width = obstacle[i].height = 2 * record_manager.obstacle_data[i][RecordManager.index_o_r];
				
				addChild(obstacle[i]);
			}
			
			
			//draw robot
			temp = record_manager.robot_data.length;
			for (i = 0; i < temp; i++)
			{
				robot.push(new Robot(record_manager.robot_data[i][0],
										record_manager.robot_data[i][1]));
										
				addChild(robot[i]);
				
				//addEventListener("explode_animation", robot[i].Explode_Animation);
				
				//设定颜色变换
				robot[i].weapon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, record_manager.robot_data[i][2], record_manager.robot_data[i][3], record_manager.robot_data[i][4]);
				robot[i].engine.transform.colorTransform = new ColorTransform(1, 1, 1, 1, record_manager.robot_data[i][5], record_manager.robot_data[i][6], record_manager.robot_data[i][7]);
				
				//Point Meter
				//trace(record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_hp]);
				//trace(record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_remainingAmmo]);
				
				point_meter[i].Set_Max(record_manager.robot_data[i][8],
										record_manager.robot_data[i][9]);
				point_meter[i].txt_info.text = "名称：\n" + robot[i].r_name + '\n开发者：\n' + robot[i].author;
				
				
				//设定初始位置
				robot[i].x = record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_x];
				robot[i].y = record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_y];
				robot[i].engine.rotation = record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_engineRotation];
				robot[i].weapon.rotation = record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_weaponRotation];
				
				robot[i].Set_Weapon_Engine(record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_weaponTypeName],
											record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_engineTypeName]);
				//trace(point_meter[i].max);
			}
			
			
			MovieClip(parent).setChildIndex(this, 0);
			MovieClip(root).setChildIndex(MovieClip(root).curtain,MovieClip(root).numChildren-1);
			//trace(record_manager.robot_data[1][RecordManager.index_robot][0]);
			
			
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		public function DisplayVSAnimation(event:Event = null):void
		{
			stage.removeEventListener("start_stop", DisplayVSAnimation);
			
			
			var animation:VSAnimation=new VSAnimation;
			
			animation.x = vsanimation_x;
			animation.y = vsanimation_y;
			
			//data:TODO
			
			
			//public function Init(name:String,author:String,data:String,wpn:int,eng:int,wr:int,wg:int,wb:int,er:int,eg:int,eb:int):void
			var i:int;
			
			i = 0;
			animation.l.Init(record_manager.robot_data[i][0], record_manager.robot_data[i][1],
								"", 
								record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_weaponTypeName],
								record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_engineTypeName],
								record_manager.robot_data[i][2],
								record_manager.robot_data[i][3],
								record_manager.robot_data[i][4],
								record_manager.robot_data[i][5],
								record_manager.robot_data[i][6],
								record_manager.robot_data[i][7]);
			
			i = 1;
			animation.r.Init(record_manager.robot_data[i][0], record_manager.robot_data[i][1],
								"", 
								record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_weaponTypeName],
								record_manager.frame_data[1][RecordManager.index_robot][i][RecordManager.index_r_engineTypeName],
								record_manager.robot_data[i][2],
								record_manager.robot_data[i][3],
								record_manager.robot_data[i][4],
								record_manager.robot_data[i][5],
								record_manager.robot_data[i][6],
								record_manager.robot_data[i][7]);
								
			
			addChild(animation);
			
			
			
			addEventListener("finish_vs_display", PlayBattle);
		}
		
		
		
		public function PlayBattle(event:Event = null):void
		{
			//stage.removeEventListener("start_stop", PlayBattle);
			removeEventListener("finish_vs_display", PlayBattle);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		public function BattleEnd():void
		{
			//战斗结束
			//Achievement信息
			
			
			DisplayAchievementBoard(record_manager.achievement_data);
			
			//清理工作
		}
		
		
		public function DisplayAchievementBoard(ary:Array):void
		{
			
			var achievement_board:Achievement_Board = new Achievement_Board(ary,record_manager.robot_data[0][RecordManager.index_r_entityID],record_manager.robot_data[1][RecordManager.index_r_entityID],record_manager.winner);
			
			achievement_board.x = 680;
			achievement_board.y = 340;
			
			addChild(achievement_board);
			
		}
		
		
		
		
		
		
		
		//帧刷新，主要工作部分
		public function onEnterFrame(event:Event):void
		{
			//帧数检测，removeEventListener
			
			
			//temp
			if (cf > record_manager.num_frame)
			{
				//trace(cf);
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				BattleEnd();
				return;
			}
			
			
			var temp:int;
			var i:int;
			
			//Robot
			temp= record_manager.robot_data.length;
			
			
			
			var bot:Array;
			for (i = 0; i < temp; i++)
			{
				bot = record_manager.frame_data[cf][RecordManager.index_robot][i];
				
				//PointMeter
				point_meter[i].Set_Max(record_manager.engine_hp_data[bot[RecordManager.index_r_engineTypeName]],
										record_manager.weapon_ammo_data[bot[RecordManager.index_r_weaponTypeName]]);
				
										
				point_meter[i].Update(bot[RecordManager.index_r_hp], bot[RecordManager.index_r_remainingAmmo]);
				
				//trace(bot);
				if (int(bot[RecordManager.index_r_hp])>0)
				{
					
					//trace(point_meter[i].
					
					///////
					robot[i].x = bot[RecordManager.index_r_x];
					robot[i].y = bot[RecordManager.index_r_y];
					
					//2014_3_1 武器，引擎角度独立
					robot[i].engine.rotation = bot[RecordManager.index_r_engineRotation];
					robot[i].weapon.rotation = bot[RecordManager.index_r_weaponRotation];
					
					robot[i].Set_Weapon_Engine(bot[RecordManager.index_r_weaponTypeName], bot[RecordManager.index_r_engineTypeName]);
					
					//效果
					
					
					//开火
					if (int(bot[RecordManager.index_r_fire] )== 1)
					{
						/*
						if (bot[RecordManager.index_r_weaponTypeName] == 8)
						{
							//锯子声太吵了
							var sc:SoundChannel = new SoundChannel();
							sc.soundTransform.volume = 0.1;
							sc = Sound(sound_fire[bot[RecordManager.index_r_weaponTypeName]]).play();
						}
						else
						{
							sound_fire[bot[RecordManager.index_r_weaponTypeName]].play();
						}
						*/
						
						sound_fire[bot[RecordManager.index_r_weaponTypeName]].play();
						
						
						robot[i].weapon.Fire();
					}
					
					
					//跑动
					if (int(bot[RecordManager.index_r_run]) == 1)
					{
						//trace(bot[RecordManager.index_r_run]);
						robot[i].Run_Animation();
					}
					else
					{
						robot[i].Stop_Animation();
					}
					
					
				}
				else
				{
					//dispatchEvent(new Event("explode_animation"));
					if (robot[i].IsExist())
					{
						robot[i].Explode_Animation();
						robot[i].addEventListener("remove", Remove_Hit_Animation);	//这个函数名字起得不好，暂不改了。。。
					}
				}
				
				
			}
			
			
			//Arsenal
			//Robot
			temp = record_manager.frame_data[cf][RecordManager.index_arsenal].length;
			
			for (i = 0; i < temp; i++)
			{
				arsenal[i].Update(record_manager.frame_data[cf][RecordManager.index_arsenal][i]);
			}
			
			
			
			
			//Bullet
			for each(var items:Bullet in bullet)
			{
				items.exist = false;
			}
			
			temp = record_manager.frame_data[cf][RecordManager.index_bullet].length;
			if (temp <= 1 && record_manager.frame_data[cf][RecordManager.index_bullet][0] == "")
			{
				//空串
				//trace(cf+"bullet_empty");
			}
			else
			{
			
			var isfind:Boolean;
			for (i = 0; i < temp; i++)
			{
				isfind = false;
				bot = record_manager.frame_data[cf][RecordManager.index_bullet][i];
				
				for each(var item:Bullet in bullet)
				{
					//item.exist = false;
					if (item.entityID == bot[RecordManager.index_b_entityID])
					{
						isfind = true;
						//没有entityID和type的更新
						item.x = bot[RecordManager.index_b_x];
						item.y = bot[RecordManager.index_b_y];
						item.rotation = bot[RecordManager.index_b_rotation];
						
						item.exist = true;
						
						break;
					}
				}
				
				if (!isfind)
				{
					//创建一个新的bullet
					bullet.push(new Bullet(bot[RecordManager.index_b_entityID],
											bot[RecordManager.index_b_type],
											bot[RecordManager.index_b_x],
											bot[RecordManager.index_b_y],
											bot[RecordManager.index_b_rotation]));
					
					addChild(bullet[bullet.length - 1]);
					
					//sound_fire[bot[RecordManager.index_b_type]].play();
					//调到robot判断fire项
				}
			}
			
			}
			
			temp = bullet.length ;
			for (i = 0; i < temp; i++)
			{
				if (!bullet[i].exist)
				{
					removeChild(bullet[i]);
					bullet.splice(i, 1);
					temp = bullet.length;
					i--;
				}
			}
			
			
			
			
			
			//Hit
			temp = record_manager.frame_data[cf][RecordManager.index_hit].length;
			
			//trace(cf);
			//trace(record_manager.frame_data[cf][RecordManager.index_hit][0]);
			
			if (temp <= 1 && record_manager.frame_data[cf][RecordManager.index_hit][0] == "")
			{
				//空串
				//trace(cf+"hit_empty");
			}
			else
			{
				for (i = 0; i < temp; i++)
				{
					bot = record_manager.frame_data[cf][RecordManager.index_hit][i];
					if (bot[RecordManager.index_h_type] == 4 || bot[RecordManager.index_h_type] == 5)
					{
						//这边特殊状况没封装好了
						//光棱,磁暴
						sound_fire[bot[RecordManager.index_h_type]].play();		//注意此处是sound_fire
						var ha:Hit_Animation = new Hit_Animation(bot[RecordManager.index_h_type], 
																	bot[RecordManager.index_h_x], 
																	bot[RecordManager.index_h_y], this);
																	
						if (bot[RecordManager.index_h_type] == 4)
						{
							//var m:Matrix = new Matrix();
							//m.createGradientBox(300, 1, Math.PI / 2);
							
							ha.graphics.lineStyle(2, 0x00ffff);
							ha.filters = prism_filter;
							//ha.graphics.lineGradientStyle(GradientType.LINEAR, [0x0099ff, 0x33ffff, 0x0099ff], [1, 1, 1], [0, 127, 255],m);
							ha.graphics.moveTo(0, 0);
							ha.graphics.lineTo(Number(bot[RecordManager.index_h_ex]) - ha.x, Number(bot[RecordManager.index_h_ey]) - ha.y);
							
							
						}
						else
						{
							//Tesla lightning
							var lightning:Lightning = new Lightning();
							lightning.startX = 0;
							lightning.startY = 0;
							lightning.endX = Number(bot[RecordManager.index_h_ex]) - ha.x;
							lightning.endY = Number(bot[RecordManager.index_h_ey]) - ha.y;
							lightning.amplitude = 0.3;
							lightning.filters = tesla_filter;
							ha.addChild(lightning);
						}
						
						addChild(ha);
						
						
					}
					else
					{
						New_Hit_Animation(bot[RecordManager.index_h_type], bot[RecordManager.index_h_x], bot[RecordManager.index_h_y]);
					}
					
					
					
				}
			}
			
			
			
			
			
			/////
			cf++;
		}
		
		
		
		
		
		
		public function DrawBoundary():void
		{
			//12-10 temp
			/*
			graphics.clear();
			var w:Number = record_manager.boundary_width;
			var h:Number = record_manager.boundary_height;
			
			
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xaaaaaa);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
			*/
			
			//temp
			addChild(new BattlefieldBackground);
		}
		
		public function New_Hit_Animation(type:int, xx:Number, yy:Number):void
		{
			
			sound_hit[type].play();
			addChild(new Hit_Animation(type,xx,yy,this));
			
			
		}
		
		
		public function Remove_Hit_Animation(event:Event):void
		{
			removeChild(MovieClip(event.target));
		}
		
		
		
		
		
		
		public function Build_PointMeter():void
		{
			//先搞成1v1固定的吧
			point_meter.push(new PointMeter(1));
			point_meter.push(new PointMeter(2));
			
			addChild(point_meter[0]);
			point_meter[0].x = 0;
			point_meter[0].y = 768-point_meter[0].height;
			
			addChild(point_meter[1]);
			point_meter[1].x = 1366-point_meter[1].width;
			point_meter[1].y = 768-point_meter[1].height;
		}
		
		
		
		
		
	}
	
	
}