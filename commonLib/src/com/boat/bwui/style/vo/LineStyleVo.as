package com.boat.bwui.style.vo 
{
	/**
	 * ...
	 * @author boen
	 */
	public class LineStyleVo 
	{
		public var thickness:Number = 1;
		public var color:uint = 0;
		public var alpha:Number = 1;
		
		public function LineStyleVo(pThickness:Number, pColor:uint, pAlpha:Number) 
		{
			thickness = pThickness;
			color = pColor;
			alpha = pAlpha;
		}
		
	}

}