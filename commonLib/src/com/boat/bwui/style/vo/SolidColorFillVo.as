package com.boat.bwui.style.vo 
{
	/**
	 * ...
	 * @author Boen
	 */
	public class SolidColorFillVo implements IPolygonFillVo 
	{
		public var color:uint = 0;
		public var alpha:Number = 1;
		
		public function SolidColorFillVo(clr:uint = 0, alp:Number = 1) 
		{
			color = clr;
			alpha = alp;
		}
		
	}

}