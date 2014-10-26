package  
{
	import flash.text.TextField;
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author ShrekShao
	 */
	public class mc_AboutWin extends MovieClip_Alpha_Animation 
	{
		protected var state:AboutWin;		//所属状态的引用
		
		protected var returnButton:ReturnButton;	//返回MainWin按钮
		
		
		protected var tf_about:TextField;
		
		
		public function mc_AboutWin(s:AboutWin) 
		{
			state = s;
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
			
			SetAboutText();
		}
	
		
		protected function SetAboutText():void
		{
			
			
			tf_about = new TextField();
			
			tf_about.x = 530;
			tf_about.y = 210;
			tf_about.width = 620;
			tf_about.height = 430;
			
			tf_about.multiline = true;
			tf_about.wordWrap = true;
			
			tf_about.text = "【机甲帝国_C++智能体争霸赛】\n由吴健雄学院科技部和先声网主办。\n选手使用官方提供的c++ dll工程模板，依照开发手册进行自己的机甲AI开发，将生成的.dll文件上传到官方QQ群中，参与联赛，突围赛，和决赛。\n详细比赛的信息请加入官方QQ群：207730813\n和关注先声网\n\n";
			tf_about.appendText("开发团队\n【统筹】张建飞\n【策划/程序/动画】狄学长\n【平面设计】文轶    【3D模型】李昕钰\n【LOGO】杨宇尘   【视频】骆一扬 崔正阳\n【Lua脚本】周杨   【测试】段尚甫 杨逍");
			
			tf_about.setTextFormat(new TextFormat("微软雅黑", 20, 0xcccccc));
			addChild(tf_about);
			
		}
	
		
		
		
		protected function ReturnToMain(e:MouseEvent):void
		{
			state.ReturnToMain();
		}
		
		
		
	
		protected function onRemoveFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		
	}
	
	

}