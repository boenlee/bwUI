package com.boat.bwui.style.frames.setters 
{
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author boen
	 */
	public class ShaderFillSetter implements IFillSetter 
	{
		public var shader:Shader;
		public var matrix:Matrix;
		
		public function ShaderFillSetter(shdr:Shader, mtrx:Matrix = null) 
		{
			shader = shdr;
			matrix = mtrx;
		}
		
		/* INTERFACE com.boat.bwui.style.frames.setters.IFillSetter */
		
		public function setFillTo(graphic:Graphics, width:Number = 0, height:Number = 0):void 
		{
			if (graphic)
			{
				graphic.beginShaderFill(shader, matrix);
			}
		}
		
		public function setLineFillTo(graphic:Graphics):void 
		{
			if (graphic)
			{
				graphic.lineShaderStyle(shader, matrix);
			}
		}
		
	}

}