package com.boat.agent.ui 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author 
	 */
	public class CCheckBoxAgent extends EventDispatcher 
	{
		private var _mc:MovieClip;
		
		private var _bg:MovieClip;
		private var _checkedMark:MovieClip;
		private var _label:TextField;
		
		private var _isChecked:Boolean = true;
		private var _labelStr:String;
		
		private var _data:Object;
		
		private var _enabled:Boolean;
		
		public function CCheckBoxAgent(pMc:MovieClip) 
		{
			_mc = pMc;
			
			_bg = _mc.getChildByName("bg") as MovieClip;
			_checkedMark = _mc.getChildByName("checkedMark") as MovieClip;
			_label = _mc.getChildByName("labelTf") as TextField;
			if (_label)
			{
				_label.autoSize = TextFieldAutoSize.LEFT;
			}
			
			_mc.mouseChildren = false;
			
			_mc.addEventListener(MouseEvent.CLICK, onClick);
			
			enabled = true;
			checked = false;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (!_enabled)
			{
				return;
			}
			checked = !_isChecked;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get mc():MovieClip
		{
			return _mc;
		}
		
		public function set checked(flag:Boolean):void 
		{
			if (_isChecked != flag) {
				_isChecked = flag;
				
				if (_checkedMark) {
					_checkedMark.visible = _isChecked;
				}
			}
		}
		
		public function get checked():Boolean {
			return _isChecked;
		}
		
		public function set label(txt:String):void {
			_labelStr = txt;
			if (_label && _labelStr) {
				_label.text = _labelStr;
			}
		}
		
		public function get label():String {
			return _labelStr;
		}
		
		public function set labelColor(color:uint):void
		{
			if (_label)
			{
				_label.textColor = color;
			}
		}
		
		public function set data(obj:Object):void {
			_data = obj;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			
			if (_bg)
			{
				_bg.gotoAndStop(int(!_enabled) + 1);
			}
			if (_checkedMark)
			{
				_checkedMark.gotoAndStop(int(!_enabled) + 1);
			}
		}
		
	}

}