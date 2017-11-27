package com.boat.agent.ui 
{
	import com.boat.def.CursorDef;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class DragToResizeObjectAgent extends EventDispatcher
	{
		public static const DRAG_TYPE_LEFT:uint = 1;
		public static const DRAG_TYPE_RIGHT:uint = 2;
		public static const DRAG_TYPE_TOP:uint = 4;
		public static const DRAG_TYPE_BOTTOM:uint = 8;
		
		private static var LockCheckResizable:Boolean = false;
		
		private var _stage:Stage;
		
		private var _dispObj:IDragToResizeObject;
		private var _dragType:uint;
		private var _edgeSpacing:uint;
		private var _presetRestrictSize:Rectangle;
		private var _presetRestrictMargin:Rectangle;
		
		private var _dragFlag:uint;
		private var _anchorDragFlag:uint;
		
		private var _anchorStageMousePos:Point = new Point();
		private var _anchorObjRect:Rectangle = new Rectangle();
		
		public function DragToResizeObjectAgent(dispObj:IDragToResizeObject, dragType:uint, edgeSpacing:uint, restrictSize:Rectangle = null, restrictMargin:Rectangle = null) 
		{
			_dispObj = dispObj;
			_dragType = dragType;
			_edgeSpacing = edgeSpacing;
			_presetRestrictSize = restrictSize;
			if (_presetRestrictSize) {
				_presetRestrictSize.x = Math.max(0, _presetRestrictSize.x);
				_presetRestrictSize.y = Math.max(0, _presetRestrictSize.y);
			}
			_presetRestrictMargin = restrictMargin;
			if (_presetRestrictMargin) {
				_presetRestrictMargin.x = Math.max(0, _presetRestrictMargin.x);
				_presetRestrictMargin.y = Math.max(0, _presetRestrictMargin.y);
				_presetRestrictMargin.width = Math.max(0, _presetRestrictMargin.width);
				_presetRestrictMargin.height = Math.max(0, _presetRestrictMargin.height);
			}
			if (_dispObj.displayObject.stage) {
				_stage = _dispObj.displayObject.stage;
				initEvent();
			}else {
				_dispObj.displayObject.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
		}
		
		private function onAddToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			_stage = _dispObj.displayObject.stage;
			initEvent();
		}
		
		private function initEvent():void
		{
			_dispObj.displayObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			if (_dragFlag == 0) {
				return;
			}
			
			LockCheckResizable = true;
			
			_stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			
			_anchorStageMousePos.x = Math.round(e.stageX);
			_anchorStageMousePos.y = Math.round(e.stageY);
			
			_anchorObjRect.x = Math.round(_dispObj.x);
			_anchorObjRect.y = Math.round(_dispObj.y);
			_anchorObjRect.width = Math.round(_dispObj.width);
			_anchorObjRect.height = Math.round(_dispObj.height);
			
			_anchorDragFlag = _dragFlag;
		}
		
		private function onStageMouseMove(e:MouseEvent):void 
		{
			if (_anchorDragFlag == 0) {
				if (LockCheckResizable) {	//阻止下次鼠标移动事件在其他同类对象中进行处理以阻止鼠标样式被重新设置为auto
					return;
				}
				checkResizable()
				if (_dragFlag != 0) {
					e.stopImmediatePropagation();	//阻止后续侦听器侦听以阻止鼠标样式被重新设置为auto
				}
			}
			else {
				resize(Math.round(e.stageX), Math.round(e.stageY));
			}
		}
		
		private function onStageMouseUp(e:MouseEvent):void 
		{
			LockCheckResizable = false;
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			_anchorDragFlag = 0;
			checkResizable();
		}
		
		private function checkResizable():void
		{
			_dragFlag = 0;
			
			checkResizableOnEdge(DRAG_TYPE_LEFT);
			checkResizableOnEdge(DRAG_TYPE_RIGHT);
			checkResizableOnEdge(DRAG_TYPE_TOP);
			checkResizableOnEdge(DRAG_TYPE_BOTTOM);
			
			refreshMouseCursor();
		}
		
		private function checkResizableOnEdge(type:uint):void
		{
			if ((_dragType & type) != 0) {
				var rect:Rectangle = getEdgeRectByType(type);
				if (rect.contains(_dispObj.displayObject.mouseX, _dispObj.displayObject.mouseY)) {
					_dragFlag |= type;
				}
			}
		}
		
		private function getEdgeRectByType(type:uint):Rectangle
		{
			var rect:Rectangle = _dispObj.displayObject.getBounds(_dispObj.displayObject);
			switch(type) {
				case DRAG_TYPE_RIGHT:
					rect.x += rect.width - _edgeSpacing;
				case DRAG_TYPE_LEFT:
					rect.width = _edgeSpacing;
					break;
				case DRAG_TYPE_BOTTOM:
					rect.y += rect.height - _edgeSpacing;
				case DRAG_TYPE_TOP:
					rect.height = _edgeSpacing;
					break;
			}
			return rect;
		}
		
		private function refreshMouseCursor():void
		{
			var cursorName:String;
			switch(_dragFlag) {
				case DRAG_TYPE_LEFT:
				case DRAG_TYPE_RIGHT:
					cursorName = CursorDef.CURSOR_RESIZE_H;
					break;
				case DRAG_TYPE_TOP:
				case DRAG_TYPE_BOTTOM:
					cursorName = CursorDef.CURSOR_RESIZE_V;
					break;
				case (DRAG_TYPE_LEFT + DRAG_TYPE_TOP):
				case (DRAG_TYPE_RIGHT + DRAG_TYPE_BOTTOM):
					cursorName = CursorDef.CURSOR_RESIZE_LT;
					break;
				case (DRAG_TYPE_RIGHT + DRAG_TYPE_TOP):
				case (DRAG_TYPE_LEFT + DRAG_TYPE_BOTTOM):
					cursorName = CursorDef.CURSOR_RESIZE_RT;
					break;
			}
			if (CursorDef.hasCursor(cursorName))
			{
				Mouse.cursor = cursorName;
			}
			else
			{
				Mouse.cursor = MouseCursor.AUTO;
			}
		}
		
		private function resize(stageX:Number, stageY:Number):void
		{
			var offsetX:Number = stageX - _anchorStageMousePos.x;
			var offsetY:Number = stageY - _anchorStageMousePos.y;
			
			var restrictRect:Rectangle = new Rectangle(0, 0, _stage.stageWidth, _stage.stageHeight);
			if (_presetRestrictMargin) {
				restrictRect.x = _presetRestrictMargin.x;
				restrictRect.y = _presetRestrictMargin.y;
				restrictRect.right = _stage.stageWidth - _presetRestrictMargin.width;
				restrictRect.bottom = _stage.stageHeight - _presetRestrictMargin.height;
			}
			var minSize:Point = new Point(0, 0);
			if (_presetRestrictSize) {
				minSize.x = _presetRestrictSize.x;
				if (_presetRestrictSize.width >= 0) {
					restrictRect.x = Math.max(restrictRect.x, _anchorObjRect.right - _presetRestrictSize.width);
					restrictRect.right = Math.min(restrictRect.right, _anchorObjRect.left + _presetRestrictSize.width);
				}
				
				minSize.y = _presetRestrictSize.y;
				if (_presetRestrictSize.height >= 0) {
					restrictRect.y = Math.max(restrictRect.y, _anchorObjRect.bottom - _presetRestrictSize.height);
					restrictRect.bottom = Math.min(restrictRect.bottom, _anchorObjRect.top + _presetRestrictSize.height);
				}
			}
			
			var newRect:Rectangle = _anchorObjRect.clone();
			
			if ((_anchorDragFlag & DRAG_TYPE_LEFT) != 0 || (_anchorDragFlag & DRAG_TYPE_RIGHT) != 0)
			{
				if ((_anchorDragFlag & DRAG_TYPE_LEFT) != 0)
				{
					newRect.x = restrictInterval(_anchorObjRect.x + offsetX, restrictRect.x, _anchorObjRect.right - minSize.x);
					newRect.right = _anchorObjRect.right;
				}
				else if ((_anchorDragFlag & DRAG_TYPE_RIGHT) != 0)
				{
					newRect.right = restrictInterval(_anchorObjRect.right + offsetX, _anchorObjRect.x + minSize.x, restrictRect.right);
				}
				_dispObj.x = newRect.x;
				_dispObj.width = newRect.width;
			}
			
			if ((_anchorDragFlag & DRAG_TYPE_TOP) != 0 || (_anchorDragFlag & DRAG_TYPE_BOTTOM) != 0)
			{
				if ((_anchorDragFlag & DRAG_TYPE_TOP) != 0)
				{
					newRect.y = restrictInterval(_anchorObjRect.y + offsetY, restrictRect.y, _anchorObjRect.bottom - minSize.y);
					newRect.bottom = _anchorObjRect.bottom;
				}
				else if ((_anchorDragFlag & DRAG_TYPE_BOTTOM) != 0)
				{
					newRect.bottom =  restrictInterval(_anchorObjRect.bottom + offsetY, _anchorObjRect.y + minSize.y, restrictRect.bottom);
				}
				
				_dispObj.y = newRect.y;
				_dispObj.height = newRect.height;
			}
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		private function restrictInterval(value:Number, minValue:Number, maxValue:Number):Number
		{
			return Math.min(maxValue, Math.max(minValue, value));
		}
		
	}

}