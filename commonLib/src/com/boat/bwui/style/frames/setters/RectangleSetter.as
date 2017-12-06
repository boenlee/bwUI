package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author boen
	 */
	public class RectangleSetter implements IPolygonSetter
	{		
		public function RectangleSetter() 
		{
		}
		
		public function setPolygonTo(graphic:Graphics, width:Number, height:Number):void
		{
			if (graphic)
			{
				graphic.drawRect(0, 0, width, height);
			}
		}
	}

}