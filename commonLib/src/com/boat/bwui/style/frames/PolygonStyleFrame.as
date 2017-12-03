package com.boat.bwui.style.frames 
{
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.vo.IPolygonVo;
	import com.boat.bwui.style.vo.LineStyleVo;
	import com.boat.bwui.style.vo.RectanglePolygonVo;
	
	/**
	 * ...
	 * @author boen
	 */
	public class PolygonStyleFrame implements IStyleFrame 
	{
		protected var _redrawOnResize:Boolean;
		
		private var _polygonVo:IPolygonVo;
		private var _lineStyleVo:LineStyleVo;
		
		public function PolygonStyleFrame(plgnVo:IPolygonVo, lnStyleVo:LineStyleVo = null, rdrwOnRsz:Boolean = false)
		{
			_polygonVo = plgnVo;
			_lineStyleVo = lnStyleVo;
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
		
		public function get polygonVo():IPolygonVo 
		{
			return _polygonVo;
		}
		
		public function set polygonVo(value:IPolygonVo):void 
		{
			_polygonVo = value;
		}
		
		public function get lineStyleVo():LineStyleVo 
		{
			return _lineStyleVo;
		}
		
		public function set lineStyleVo(value:LineStyleVo):void 
		{
			_lineStyleVo = value;
		}
		
	}

}