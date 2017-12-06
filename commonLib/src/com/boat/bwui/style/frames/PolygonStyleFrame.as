package com.boat.bwui.style.frames 
{
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.frames.setters.IFillSetter;
	import com.boat.bwui.style.frames.setters.IPolygonSetter;
	import com.boat.bwui.style.frames.setters.SolidLineSetter;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author boen
	 */
	public class PolygonStyleFrame implements IStyleFrame 
	{
		protected var _redrawOnResize:Boolean;
		
		private var _polygonSetter:IPolygonSetter;
		private var _fillSetter:IFillSetter;
		private var _lineStyleSetter:SolidLineSetter;
		
		public function PolygonStyleFrame(plgnSetter:IPolygonSetter, filSetter:IFillSetter, lnStyleSetter:SolidLineSetter = null, rdrwOnRsz:Boolean = false)
		{
			_polygonSetter = plgnSetter;
			_fillSetter = filSetter;
			_lineStyleSetter = lnStyleSetter;
			_redrawOnResize = rdrwOnRsz;
		}
		
		public function get redrawOnResize():Boolean
		{
			return _redrawOnResize;
		}
		
		public function set redrawOnResize(value:Boolean):void
		{
			_redrawOnResize = value;
		}
		
		public function setStyleTo(sprite:Sprite, width:Number, height:Number):void
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
		
	}

}