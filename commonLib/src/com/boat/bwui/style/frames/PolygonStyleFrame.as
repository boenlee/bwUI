package com.boat.bwui.style.frames 
{
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.vo.IPolygonFillVo;
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
		private var _polygonFillVo:IPolygonFillVo;
		private var _lineStyleVo:LineStyleVo;
		
		public function PolygonStyleFrame(plgnVo:IPolygonVo, fillVo:IPolygonFillVo, lnStyleVo:LineStyleVo = null, rdrwOnRsz:Boolean = false)
		{
			_polygonVo = plgnVo;
			_polygonFillVo = fillVo;
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
		
		public function get polygonFillVo():IPolygonFillVo 
		{
			return _polygonFillVo;
		}
		
		public function set polygonFillVo(value:IPolygonFillVo):void 
		{
			_polygonFillVo = value;
		}
		
	}

}