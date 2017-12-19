package com.boat.bwui.geom 
{
	import com.boat.bwui.utils.MathUtils;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Boen
	 */
	public class BmpFillTrans 
	{
		private var _sourceRect:ExtRect;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _rotateAngle:Number;
		private var _skewAngleX:Number;
		private var _skewAngleY:Number;
		
		private var _matrix:Matrix;
		
		public function BmpFillTrans(srcRect:ExtRect = null, sclX:Number = 1, sclY:Number = 1, rotAngle:Number = 0, skwAngleX:Number = 0, skwAngleY:Number = 0) 
		{
			_sourceRect = srcRect;
			_scaleX = sclX;
			_scaleY = sclY;
			_rotateAngle = rotAngle;
			_skewAngleX = skwAngleX;
			_skewAngleY = skwAngleY;
			
			_matrix = new Matrix();
		}
		
		public function getTargetMatrix(targetRect:ExtRect, fillTypeX:uint = 0, fillTypeY:uint = 0):Matrix
		{
			_matrix.identity();
			
			if (targetRect)
			{				
				var srcRect:ExtRect = _sourceRect;
				if (!srcRect)
				{
					srcRect = targetRect.clone();
				}
				var sclX:Number = _scaleX;
				if (fillTypeX == BmpFillType.STRETCH)
				{
					sclX = targetRect.width / srcRect.width;
				}
				var sclY:Number = _scaleY;
				if (fillTypeY == BmpFillType.STRETCH)
				{
					sclY = targetRect.height / srcRect.height;
				}
				
				var skewX:Number = Math.tan(MathUtils.angleToRadian(_skewAngleX));
				var skewY:Number = Math.tan(MathUtils.angleToRadian(_skewAngleY));
				
				_matrix.translate(-(srcRect.y * skewX + srcRect.x), -(srcRect.x * skewY + srcRect.y));
				_matrix.c = skewX;
				_matrix.b = skewY;
				_matrix.scale(sclX, sclY);
				_matrix.rotate(MathUtils.angleToRadian(_rotateAngle));
				
			}
			return _matrix;
		}
		
	}

}