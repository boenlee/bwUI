package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Boen
	 */
	public class SolidColorSetter implements IFillSetter 
	{
		public var color:uint = 0;
		public var alpha:Number = 1;
		
		public function SolidColorSetter(clr:uint = 0, alp:Number = 1) 
		{
			color = clr;
			alpha = alp;
		}
		
		public function setFillTo(graphic:Graphics, width:Number = 0, height:Number = 0):void
		{
			if (graphic)
			{
				graphic.beginFill(color, alpha);
			}
		}
		
		public function setLineFillTo(graphic:Graphics):void
		{
			
		}
	}

}