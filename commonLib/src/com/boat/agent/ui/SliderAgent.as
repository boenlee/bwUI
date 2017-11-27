package com.boat.agent.ui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class SliderAgent extends EventDispatcher
	{
		private var _sliderMc:MovieClip;
		
		private var _pointerDragAgent:DragableObjectAgent;
		
		private var _pointer:Sprite;
		private var _track:Sprite;
		
		private var _ratio:Number = 0;
		
		private var _slideRect:Rectangle;
		
		public function SliderAgent(sliderMc:MovieClip) 
		{
			_sliderMc = sliderMc;
			_pointer = _sliderMc.pointer;
			_track = _sliderMc.track;
			init();
		}
		
		private function init():void
		{
			_slideRect = new Rectangle(_track.x, _track.y, _track.width - _pointer.width, 0);
			
			_pointerDragAgent = new DragableObjectAgent(_pointer, _slideRect);
			_pointerDragAgent.addEventListener(Event.CHANGE, onPointerPosChange);
			_track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackMouseDown);
		}
		
		private function onPointerPosChange(e:Event):void 
		{
			_ratio = (_pointer.x - _slideRect.x) / _slideRect.width;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onTrackMouseDown(e:MouseEvent):void 
		{
			_ratio = (_track.mouseX - _pointer.width / 2) / _slideRect.width;
			dispatchEvent(new Event(Event.CHANGE));
			_pointerDragAgent.fireMouseDown();
		}
		
		public function set ratio(val:Number):void
		{
			_ratio = val;
			_pointer.x = _slideRect.width * _ratio + _slideRect.x;
		}
		
		public function get ratio():Number {
			return _ratio;
		}
	}

}