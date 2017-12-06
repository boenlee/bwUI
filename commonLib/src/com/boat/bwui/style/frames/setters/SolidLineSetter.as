package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author boen
	 */
	public class SolidLineSetter implements ILineStyleSetter
	{
		public var thickness:Number = 1;
		public var color:uint = 0;
		public var alpha:Number = 1;
		
		public function SolidLineSetter(thkns:Number = 1, clr :uint = 0, alp:Number = 1) 
		{
			thickness = thkns;
			color = clr;
			alpha = alp;
		}
		
		public function setLineStyleTo(graphic:Graphics):void
		{
			if (graphic)
			{
				graphic.lineStyle(thickness, color, alpha, false, "none");
			}
		}
	}

}