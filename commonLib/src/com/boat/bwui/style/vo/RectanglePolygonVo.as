package com.boat.bwui.style.vo 
{
	/**
	 * ...
	 * @author boen
	 */
	public class RectanglePolygonVo implements IPolygonVo
	{
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		public var color:uint = 0;
		public var alpha:Number = 1;
		
		public function RectanglePolygonVo(px:Number, py:Number, pw:Number, ph:Number, pclr:uint = 0, palp:Number = 1) 
		{
			x = px;
			y = py;
			width = pw;
			height = ph;
			color = pclr;
			alpha = palp;
		}
		
	}

}