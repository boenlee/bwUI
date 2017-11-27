package com.boat.agent.ui
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class DragableObjectAgent extends EventDispatcher
	{
		private var _dragObject:DisplayObject;
		private var _restrictRect:Rectangle;
		private var _stageMouseAnchor:Point = new Point();
		private var _panelPositionAnchor:Point = new Point();
		
		private var _stage:Stage;
		
		public function DragableObjectAgent(obj:DisplayObject, restrictRect:Rectangle) 
		{
			_restrictRect = restrictRect;
			_dragObject = obj;
			_dragObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			if (_dragObject.stage) {
				_stage = _dragObject.stage;
			}else {
				_dragObject.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
		}
		
		private function onAddToStage(e:Event):void 
		{
			_dragObject.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			_stage = _dragObject.stage;
		}
		
		public function fireMouseDown():void {
			onMouseDown(null);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			_stageMouseAnchor.x = _stage.mouseX;
			_stageMouseAnchor.y = _stage.mouseY;
			
			_panelPositionAnchor.x = _dragObject.x;
			_panelPositionAnchor.y = _dragObject.y;
			
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			_dragObject.x = _panelPositionAnchor.x + (e.stageX - _stageMouseAnchor.x);
			_dragObject.y = _panelPositionAnchor.y + (e.stageY - _stageMouseAnchor.y);
			restrictPosition();
		}
		
		public function restrictPosition():void {
			_dragObject.x = Math.max(_restrictRect.left, Math.min(_dragObject.x, _restrictRect.right));
			_dragObject.y = Math.max(_restrictRect.top, Math.min(_dragObject.y, _restrictRect.bottom));
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function get restrictRect():Rectangle 
		{
			return _restrictRect;
		}
		
		public function set restrictRect(value:Rectangle):void 
		{
			_restrictRect = value;
		}
		
	}

}