package com.boat.def 
{
	import com.boat.utils.ClassUtils;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	/**
	 * ...
	 * @author 
	 */
	public class CursorDef 
	{
		
		public static const CURSOR_RESIZE_H:String = "resizeH";
		public static const CURSOR_RESIZE_V:String = "resizeV";
		public static const CURSOR_RESIZE_LT:String = "resizeLT";
		public static const CURSOR_RESIZE_RT:String = "resizeRT";
		public static const CURSOR_CROSS:String = "crossCursor";
		
		private static var _cursorDic:Object = { };
		
		public static function initCursor():void {
			registerCursor(CURSOR_RESIZE_H, "resizeArrowH", 9, 4);
			registerCursor(CURSOR_RESIZE_V, "resizeArrowV", 4, 9);
			registerCursor(CURSOR_RESIZE_LT, "resizeArrowLT", 7, 7);
			registerCursor(CURSOR_RESIZE_RT, "resizeArrowRT", 7, 7);
			registerCursor(CURSOR_CROSS, "crossCursor", 9, 9);
		}
		
		private static function registerCursor(name:String, clsName:String, px:int, py:int):void
		{
			var arrowCls:Class = ClassUtils.getClassByName(clsName);
			if (arrowCls)
			{
				Mouse.registerCursor(name, getCursorData(new arrowCls(), px, py));
				_cursorDic[name] = true;
			}
		}
		
		private static function getCursorData(bmd:BitmapData, px:int, py:int):MouseCursorData 
		{
			var cursorData:MouseCursorData = new MouseCursorData();
			var vec:Vector.<BitmapData> = new Vector.<BitmapData>;
			vec[0] = bmd;
			cursorData.data = vec;
			cursorData.frameRate = 0;
			cursorData.hotSpot = new Point(px, py);
			return cursorData;
		}
		
		public static function hasCursor(name:String):Boolean
		{
			if (name)
			{
				return _cursorDic[name] == true;
			}
			return false;
		}
	}

}