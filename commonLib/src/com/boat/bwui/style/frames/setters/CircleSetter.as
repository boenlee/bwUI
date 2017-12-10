package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author boen
	 */
	public class CircleSetter implements IPolygonSetter 
	{
		
		public function CircleSetter() 
		{
			
		}
		
		/* INTERFACE com.boat.bwui.style.frames.setters.IPolygonSetter */
		
		public function setPolygonTo(graphic:Graphics, width:Number, height:Number):void 
		{
			if (graphic)
			{
				graphic.drawEllipse(0, 0, width, height);
			}
		}
		
	}

}