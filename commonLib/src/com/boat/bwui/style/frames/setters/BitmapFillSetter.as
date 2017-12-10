package com.boat.bwui.style.frames.setters 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author boen
	 */
	public class BitmapFillSetter implements IFillSetter 
	{
		
		public var bitmapData:BitmapData;
		public var matrix:Matrix;
		public var repeat:Boolean;
		public var smooth:Boolean;
		
		public function BitmapFillSetter(bmpData:BitmapData = null, mtrx:Matrix = null, rpt:Boolean = true, smth:Boolean = false)
		{
			bitmapData = bmpData;
			matrix = mtrx;
			repeat = rpt;
			smooth = smth;
		}
		
		/* INTERFACE com.boat.bwui.style.frames.setters.IFillSetter */
		
		public function setFillTo(graphic:Graphics, width:Number = 0, height:Number = 0):void 
		{
			if (graphic && bitmapData)
			{
				graphic.beginBitmapFill(bitmapData, matrix, repeat, smooth);
			}
		}
		
		public function setLineFillTo(graphic:Graphics):void 
		{
			if (graphic && bitmapData)
			{
				graphic.lineBitmapStyle(bitmapData, matrix, repeat, smooth);
			}
		}
		
	}

}