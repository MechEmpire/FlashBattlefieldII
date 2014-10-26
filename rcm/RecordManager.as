package rcm
{
	//--尝试一下as3的单例模式
	import flash.net.*;
	import flash.text.*;
	import flash.events.*;
	
	
	public class RecordManager extends EventDispatcher
	{
		//as3的录像管理器
		//protected static var instance:RecordManager = new RecordManager();
		
		
		public static const event_load:String = "Record_Load";
		public static const event_complete:String = "Record_Load_Complete";
		public const num_robot:int = 2;
		public const num_bullet_max:int = 20;
		public const num_hit_max:int = 10;
		
		public var num_frame:int;
		
		
		
		
		//robot下标指示
		public static const index_robot:int = 0;
		
		public static const index_r_entityID:int = 0;
		public static const index_r_id:int = 1;
		public static const index_r_x:int = 2;
		public static const index_r_y:int = 3;
		public static const index_r_weaponRotation:int = 4;	//局部
		public static const index_r_engineRotation:int = 5;	//robot的全局
		public static const index_r_hp:int = 6;
		public static const index_r_weaponTypeName:int = 7;
		public static const index_r_engineTypeName:int = 8;
		public static const index_r_fire:int = 9;			//Boolean,效果声音等指示
		public static const index_r_wturn:int = 10;
		public static const index_r_run:int = 11;
		public static const index_r_eturn:int = 12;
		public static const index_r_remainingAmmo:int = 13;
		//似乎还可以多传些信息出来
		
		
		
		//bullet下标指示
		public static const index_bullet:int = 1;
		
		public static const index_b_entityID:int = 0;
		public static const index_b_type:int = 1;
		public static const index_b_x:int = 2;
		public static const index_b_y:int = 3;
		public static const index_b_rotation:int = 4;
		
		//hit下标指示
		public static const index_hit:int = 2;
		
		//public static const index_h_entityID:int = 0;
		public static const index_h_type:int = 0;
		public static const index_h_x:int = 1;
		public static const index_h_y:int = 2;
		
		public static const index_h_ex:int = 3;
		public static const index_h_ey:int = 4;
		//public static const index_h_rotation:int = 4;
		
		//arsenal下标指示
		public static const index_arsenal = 3;
		
		public static const index_a_respawning = 0;
		
		
		
		
		
		//开头部分
		
		//obstacle下标指示
		public static const index_o_x:int = 0;
		public static const index_o_y:int = 1;
		public static const index_o_r:int = 2;
		
		//arsenal index info
		public static const index_a_x:int = 0;
		public static const index_a_y:int = 1;
		public static const index_a_r:int = 2;
		
		
		//achievement_data index info
		public static const index_ach_fire:int = 0;
		public static const index_ach_hit:int = 1;
		public static const index_ach_damage:int = 2;
		public static const index_ach_output:int = 3;
		
		
		protected var fileRef:FileReference;	//文件
		
		
		protected var text_load:String;		//加载txt到此String(不会溢出吗)
		
		//protected var temp_data:Array;		//split时的临时数组
		
		public var frame_data:Array;		//每个元素代表每帧的信息
		
		public var robot_data:Array;		//机器人的静态信息（第一行左）
		
		public var obstacle_data:Array;
		
		public var arsenal_data:Array;
		
		public var boundary_width:Number;	
		public var boundary_height:Number;
		
		public var weapon_ammo_data:Array;
		public var engine_hp_data:Array;
		
		public var achievement_data:Array;
		
		public var winner:int;	//本场胜者下标，无胜者为-1
		
		//读录像文件
		//处理文本进各数组
		//提供方法给主程序调用
		
		
		public function RecordManager()
		{
			//construct code
			/*
			if (instance)
			{
				throw new Error("Get()获取实例");
			}
			else
			{
				
				addEventListener(event_load, onLoadFile);
			}
			*/
			//trace("sssss");
			//addEventListener(event_load, onLoadFile);
			Load_Weapon_Engine_Data();
		}
		
		
		public function Load_Weapon_Engine_Data():void
		{
			//2014_1_21
			//为了用swf好部署，不用air的file系统了。。
			
			/*
			var loader:File = File.applicationDirectory;
			loader = loader.resolvePath("weapon_engine_data.data");
			
			var fs:FileStream = new FileStream();
			fs.open(loader, FileMode.READ);
			var t:String = fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			var ary:Array = t.split('|');
			weapon_ammo_data = ary[0].split(',');
			engine_hp_data = ary[1].split(',');
			*/
			
			//需要根据脚本实时更新
			//version   2014/08/02
			weapon_ammo_data = [10, 8, 5, 50, 7, 11, 12, 10, 100,9];
			engine_hp_data = [85,90,100,100];
		}
		
		
		
		public function init():void
		{
			//此处垃圾回收机制是否能可靠工作？
			frame_data = new Array();
			//robot_data = new Array();
			//obstacle_data = new Array();
		}
		
		
		public function onLoadFile(event:Event):void
		{
			init();
			fileRef = new FileReference();
			fileRef.browse([new FileFilter("战斗录像", "*.txt"),
				new FileFilter("所有文件", "*")]);
			fileRef.addEventListener(Event.SELECT, onLoadSelect, false, 0, true);
			fileRef.addEventListener(Event.CANCEL, onCancel, false, 0, true);
		}
		
		public function onLoadSelect(event:Event):void
		{
			fileRef.load();
			fileRef.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		public function onCancel(event:Event):void
		{
			dispatchEvent(new Event("cancel"));
		}
		
		public function onLoadComplete(event:Event):void
		{
			text_load = fileRef.data.readMultiByte(fileRef.data.length, "cn-gb");
			
			//载入界面事件派发？
			HandleRecord();	
		}
		
		public function HandleRecord():void
		{
			var temp:int;
			var i:int;
			var j:int;
			
			//trace("enter..");
			
			//处理载入的String
			frame_data = text_load.split('\n');
			frame_data[0] = frame_data[0].split('|');
			robot_data = [frame_data[0][0]];
			obstacle_data = [frame_data[0][2]];
			arsenal_data = [frame_data[0][3]];
			
			achievement_data = [frame_data[0][4]];
			
			winner = frame_data[0][5];
			
			robot_data = robot_data[0].split('*');
			temp = robot_data.length;
			for (i = 0; i < temp; i++)
			{
				robot_data[i]=robot_data[i].split(',');
				//暂时是0-name,1-author
				//2,3,4-Weapon RGB
				//5,6,7-Engine RGB
			}
			
			//trace("robot_data complete..");
			
			obstacle_data = obstacle_data[0].split('*');
			temp = obstacle_data.length;
			for (i = 0; i < temp; i++)
			{
				obstacle_data[i]=obstacle_data[i].split(',');
			}
			
			arsenal_data = arsenal_data[0].split('*');
			temp = arsenal_data.length;
			for (i = 0; i < temp; i++)
			{
				arsenal_data[i] = arsenal_data[i].split(',');
			}
			
			achievement_data = achievement_data[0].split('*');
			temp = achievement_data.length;
			for (i = 0; i < temp; i++)
			{
				achievement_data[i] = achievement_data[i].split(',');
			}
			
			
			
			
			//trace("obstacle_data complete..");
			
			frame_data[0][1] = frame_data[0][1].split(',');
			boundary_width = Number(frame_data[0][1][0]);
			boundary_height = Number(frame_data[0][1][1]);
			
			
			num_frame = frame_data.length - 1;
			
			for (i = 1; i <= num_frame; i++)
			{
				frame_data[i]=frame_data[i].split('|');
				//现在每帧有4部分,robot,bullet,hit,arsenal
				
				//这里没预留多台机甲对战吗?
				//robot,固定大小，num_robot
				frame_data[i][index_robot] = frame_data[i][index_robot].split('*');
				
				temp = frame_data[i][index_robot].length;
				for (j = 0; j < temp; j++)
				{
					frame_data[i][index_robot][j] = frame_data[i][index_robot][j].split(',');
				}
				//frame_data[i][index_robot][j][...]  是最终属性
				
				
				//bullet,未知个数
				frame_data[i][index_bullet] = frame_data[i][index_bullet].split('*');
				
				temp = frame_data[i][index_bullet].length;
				for (j = 0; j < temp; j++)
				{
					frame_data[i][index_bullet][j] = frame_data[i][index_bullet][j].split(',');
				}
				
				//hitinfo,未知个数
				frame_data[i][index_hit] = frame_data[i][index_hit].split('*');
				
				temp = frame_data[i][index_hit].length;
				for (j = 0; j < temp; j++)
				{
					frame_data[i][index_hit][j] = frame_data[i][index_hit][j].split(',');
				}
				
				
				//arsenal
				frame_data[i][index_arsenal] = frame_data[i][index_arsenal].split('*');
				
				//temp = frame_data[i][index_arsenal].length;
				
				//暂时arsenal的信息只有一个，无逗号分割
				/*
				for (j = 0; j < temp; j++)
				{
					frame_data[i][index_arsenal][j] = frame_data[i][index_arsenal][j].split(',');
				}
				*/
				
				
			}
			//处理结束
			
			//num_frame = frame_data.length - 1;
			text_load = "";
			
			dispatchEvent(new Event(event_complete));
		}
		
		/*
		static public function Get():RecordManager
		{
			return instance;
		}
		*/
		
	}
	
}