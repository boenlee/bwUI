package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author boen
	 */
	public class LineStyleSetter implements ILineStyleSetter
	{
		public var fillSetter:IFillSetter;
		public var thickness:Number = 1;		
		public var pixelHinting:Boolean;
		public var scaleMode:String;
		public var caps:String;
		public var joints:String;
		public var miterLimit:Number;
		
		public function LineStyleSetter(fllSetter:IFillSetter, thkns:Number = 1, pxlHinting:Boolean = false, sclMode:String = "normal", cps:String = null, jnts:String = null, miterLmt:Number = 3) 
		{
			fillSetter = fllSetter || new SolidColorSetter();
			thickness = thkns;			
			pixelHinting = pxlHinting;
			scaleMode = sclMode;
			caps = cps;
			joints = jnts;
			miterLimit = miterLmt;
		}
		
		public function setLineStyleTo(graphic:Graphics):void
		{
			if (graphic)
			{
				var solidColor:SolidColorSetter = fillSetter as SolidColorSetter;
				if (solidColor)
				{
					graphic.lineStyle(thickness, solidColor.color, solidColor.alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
				}
				else
				{
					graphic.lineStyle(thickness, 0, 1, pixelHinting, scaleMode, caps, joints, miterLimit);
					fillSetter.setLineFillTo(graphic);
				}
			}
		}
	}

}