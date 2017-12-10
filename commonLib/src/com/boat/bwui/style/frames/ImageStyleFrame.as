package com.boat.bwui.style.frames 
{
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.frames.setters.RectangleSetter;
	import com.boat.bwui.style.types.BitmapRepeatType;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author boen
	 */
	public class ImageStyleFrame extends BaseStyleFrame implements IStyleFrame 
	{
		private var _bitmapData:BitmapData;
		private var _repeatType:int;
		private var _smooth:Boolean;
		
		public function ImageStyleFrame(bmpData:BitmapData, rptType:int = 0, smth:Boolean = false, rdrwOnRsz:Boolean = false)
		{
			super(rdrwOnRsz);
			
			_bitmapData = bmpData;
			_repeatType = rptType;
			_smooth = smth;
		}
		
		override public function setStyleTo(sprite:Sprite, width:Number, height:Number):void 
		{
			if (sprite)
			{
				sprite.graphics.clear();
				switch(_repeatType)
				{
					case BitmapRepeatType.NO_REPEAT:
						sprite.graphics.beginBitmapFill(_bitmapData, new Matrix(width / _bitmapData.width, 0, 0, height / _bitmapData.height),false, _smooth);
						break;
					case BitmapRepeatType.REPEAT:
						sprite.graphics.beginBitmapFill(_bitmapData, null, true);
						break;
					case BitmapRepeatType.X_REPEAT:
						sprite.graphics.beginBitmapFill(_bitmapData, new Matrix(1, 0, 0, height / _bitmapData.height), true, _smooth);
						break;
					case BitmapRepeatType.Y_REPEAT:
						sprite.graphics.beginBitmapFill(_bitmapData, new Matrix(width / _bitmapData.width, 0, 0, 1), true, _smooth);
						break;
				}
				sprite.graphics.drawRect(0, 0, width, height);
				sprite.graphics.endFill();
			}
		}
		
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void 
		{
			_bitmapData = value;
		}
		
		public function get repeatType():int 
		{
			return _repeatType;
		}
		
		public function set repeatType(value:int):void 
		{
			_repeatType = value;
		}
		
		public function get smooth():Boolean 
		{
			return _smooth;
		}
		
		public function set smooth(value:Boolean):void 
		{
			_smooth = value;
		}
		
	}

}