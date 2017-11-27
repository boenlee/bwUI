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
	public class CTriCheckBoxAgent extends EventDispatcher 
	{
		public static const STATE_UNCHECKED:uint = 1;
		public static const STATE_ALL_CHECKED:uint = 2;
		public static const STATE_SOME_CHECKED:uint = 3;
		
		private var _mc:MovieClip;
		
		private var _bg:MovieClip;
		private var _allCheckedMark:MovieClip;
		private var _someCheckedMark:MovieClip;
		private var _label:TextField;
		
		private var _isCheckedState:uint;
		private var _labelStr:String;
		
		private var _data:Object;
		
		private var _enabled:Boolean;
		
		private var _isSomeCheckedToAll:Boolean = true;
		
		private var _labelColor:uint = 0x000000;
		private var _disabledLabelColor:uint = 0x999999;
		
		public function CTriCheckBoxAgent(pMc:MovieClip) 
		{
			_mc = pMc;
			
			_bg = _mc.getChildByName("bg") as MovieClip;
			_allCheckedMark = _mc.getChildByName("allCheckedMark") as MovieClip;
			_someCheckedMark = _mc.getChildByName("someCheckedMark") as MovieClip;
			_label = _mc.getChildByName("labelTf") as TextField;
			if (_label)
			{
				_label.autoSize = TextFieldAutoSize.LEFT;
			}
			
			_mc.mouseChildren = false;
			
			_mc.addEventListener(MouseEvent.CLICK, onClick);
			
			enabled = true;
			checkedState = STATE_UNCHECKED;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (!_enabled)
			{
				return;
			}
			if (_isCheckedState == STATE_UNCHECKED)
			{
				checkedState = STATE_ALL_CHECKED;
			}
			else if (_isCheckedState == STATE_ALL_CHECKED)
			{
				checkedState = STATE_UNCHECKED;
			}
			else
			{
				if (_isSomeCheckedToAll)
				{
					checkedState = STATE_ALL_CHECKED;
				}
				else
				{
					checkedState = STATE_UNCHECKED;
				}
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get mc():MovieClip
		{
			return _mc;
		}
		
		public function set checkedState(value:uint):void 
		{
			if (_isCheckedState != value) {
				_isCheckedState = value;
				
				if (_allCheckedMark) {
					_allCheckedMark.visible = (_isCheckedState == STATE_ALL_CHECKED);
				}
				if (_someCheckedMark) {
					_someCheckedMark.visible = (_isCheckedState == STATE_SOME_CHECKED);
				}
			}
		}
		
		public function get checkedState():uint {
			return _isCheckedState;
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
		
		public function set labelColor(value:uint):void
		{
			_labelColor = value;
			if (_label && _enabled)
			{
				_label.textColor = _labelColor;
			}
		}
		
		public function get labelColor():uint 
		{
			return _labelColor;
		}
		
		public function set disabledLabelColor(value:uint):void 
		{
			_disabledLabelColor = value;
			if (_label && !_enabled)
			{
				_label.textColor = _disabledLabelColor;
			}
		}
		
		public function get disabledLabelColor():uint 
		{
			return _disabledLabelColor;
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
			
			if (_label)
			{
				if (_enabled)
				{
					_label.textColor = _labelColor;
				}
				else
				{
					_label.textColor = _disabledLabelColor;
				}
			}
			
			if (_bg)
			{
				_bg.gotoAndStop(int(!_enabled) + 1);
			}
			if (_allCheckedMark)
			{
				_allCheckedMark.gotoAndStop(int(!_enabled) + 1);
			}
			if (_someCheckedMark)
			{
				_someCheckedMark.gotoAndStop(int(!_enabled) + 1);
			}
		}
		
		public function get isSomeCheckedToAll():Boolean 
		{
			return _isSomeCheckedToAll;
		}
		
		public function set isSomeCheckedToAll(value:Boolean):void 
		{
			_isSomeCheckedToAll = value;
		}
		
	}

}