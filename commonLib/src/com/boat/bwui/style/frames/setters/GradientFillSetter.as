package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author boen
	 */
	public class GradientFillSetter implements IFillSetter 
	{
		public var type:String;
		public var colors:Array;
		public var alphas:Array;
		public var ratios:Array;
		public var matrix:Matrix;
		public var spreadMethod:String;
		public var interpolationMethod:String;
		public var focalPointRatio:Number;
		
		public function GradientFillSetter(typ:String, clrs:Array, alps:Array, rtos:Array, mtrx:Matrix = null, sprdMthd:String = "pad", interpolationMthd:String = "rgb", focalPntRto:Number = 0) 
		{
			type = typ;
			colors = clrs;
			alphas = alps;
			ratios = rtos;
			matrix = mtrx;
			spreadMethod = sprdMthd;
			interpolationMethod = interpolationMthd;
			focalPointRatio = focalPntRto;
		}
		
		/* INTERFACE com.boat.bwui.style.frames.setters.IFillSetter */
		
		public function setFillTo(graphic:Graphics, width:Number = 0, height:Number = 0):void 
		{
			if (graphic)
			{
				graphic.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			}
		}
		
		public function setLineFillTo(graphic:Graphics):void 
		{
			if (graphic)
			{
				graphic.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			}
		}
		
	}

}