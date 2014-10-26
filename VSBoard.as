package  
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	/**对阵的选手板子，在flash里构建的
	 * ...
	 * @author ShrekShao
	 */
	public class VSBoard extends MovieClip 
	{
		
		public function VSBoard() 
		{
			
		}
		
		public function Init(name:String,author:String,data:String,wpn:int,eng:int,wr:int,wg:int,wb:int,er:int,eg:int,eb:int):void
		{
			txt_name.text = name;
			txt_author.text = author;
			txt_data.text = data;
			
			armor.Init(wpn, eng, wr, wg, wb, er, eg, eb);
			
			//颜色渐变板
			var avgr:int = (wr + er) / 2;
			var avgg:int = (wg + eg) / 2;
			var avgb:int = (wb + eb) / 2;
			
			//阈值调整
			//???不需要
			
			color_bar.transform.colorTransform = new ColorTransform(1, 1, 1, 1,avgr*0.8,avgg*0.8,avgb*0.8);
			
			
		}
		
		
	}

}