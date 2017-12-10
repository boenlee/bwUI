package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author boen
	 */
	public class RectangleSetter implements IPolygonSetter
	{
		private var _type:int = 0;
		
		public var ellipseWidth:Number;
		public var ellipseHeight:Number;
		public var topLeftRadius:Number;
		public var topRightRadius:Number;
		public var bottomLeftRadius:Number;
		public var bottomRightRadius:Number;
		
		public function RectangleSetter(...args) 
		{			
			switch(args.length)
			{
				case 2:
					ellipseHeight = Number(args[1]) || 0;
				case 1:
					ellipseWidth = Number(args[0]) || 0;
					_type = 1;
					break;
				case 4:
					bottomRightRadius = Number(args[3]) || 0;
				case 3:
					topLeftRadius = Number(args[0]) || 0;
					topRightRadius = Number(args[1]) || 0;
					bottomLeftRadius = Number(args[2]) || 0;
					bottomRightRadius = bottomRightRadius || 0;
					_type = 2;
					break;
			}
		}
		
		public function setPolygonTo(graphic:Graphics, width:Number, height:Number):void
		{
			if (graphic)
			{
				switch(_type)
				{
					case 0:
						graphic.drawRect(0, 0, width, height);
						break;
					case 1:
						graphic.drawRoundRect(0, 0, width, height, ellipseWidth, ellipseHeight);
						break;
					case 2:
						graphic.drawRoundRectComplex(0, 0, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);
						break;
				}
			}
		}
	}

}