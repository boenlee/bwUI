package com.boat.bwui.style.frames 
{
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.frames.setters.IFillSetter;
	import com.boat.bwui.style.frames.setters.ILineStyleSetter;
	import com.boat.bwui.style.frames.setters.IPolygonSetter;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author boen
	 */
	public class PolygonStyleFrame extends BaseStyleFrame implements IStyleFrame 
	{		
		private var _polygonSetter:IPolygonSetter;
		private var _fillSetter:IFillSetter;
		private var _lineStyleSetter:ILineStyleSetter;
		
		public function PolygonStyleFrame(plgnSetter:IPolygonSetter, fllSetter:IFillSetter, lnStyleSetter:ILineStyleSetter = null, rdrwOnRsz:Boolean = false)
		{
			super(rdrwOnRsz);
			_polygonSetter = plgnSetter;
			_fillSetter = fllSetter;
			_lineStyleSetter = lnStyleSetter;
			_redrawOnResize = rdrwOnRsz;
		}
		
		override public function setStyleTo(sprite:Sprite, width:Number, height:Number):void
		{
			sprite.graphics.clear();
			if (_lineStyleSetter)
			{
				_lineStyleSetter.setLineStyleTo(sprite.graphics);
			}
			if (_fillSetter)
			{
				_fillSetter.setFillTo(sprite.graphics, width, height);
			}
			if (_polygonSetter)
			{
				_polygonSetter.setPolygonTo(sprite.graphics, width, height);
			}
			sprite.graphics.endFill();
		}
		
		public function get polygonSetter():IPolygonSetter 
		{
			return _polygonSetter;
		}
		
		public function set polygonSetter(value:IPolygonSetter):void 
		{
			_polygonSetter = value;
		}
		
		public function get fillSetter():IFillSetter 
		{
			return _fillSetter;
		}
		
		public function set fillSetter(value:IFillSetter):void 
		{
			_fillSetter = value;
		}
		
		public function get lineStyleSetter():ILineStyleSetter 
		{
			return _lineStyleSetter;
		}
		
		public function set lineStyleSetter(value:ILineStyleSetter):void 
		{
			_lineStyleSetter = value;
		}
		
	}

}