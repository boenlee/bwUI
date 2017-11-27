package com.boat.agent.ui 
{
	import com.boat.evt.UIEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Boen
	 */
	public class RadioButtonGroupAgent extends EventDispatcher 
	{
		private var _btnList:Array;
		
		private var _selIndex:int = -1;
		private var _isShow:Boolean = true;
		private var _enabled:Boolean = true;
		
		public function RadioButtonGroupAgent() 
		{
			_btnList = [];
		}
		
		public function get buttonCount():uint
		{
			return _btnList.length;
		}
		
		public function getRadioButtonByIndex(index:uint):IRadioButton
		{
			return _btnList[index];
		}
		
		public function addRadioButton(radioBtn:IRadioButton):void
		{
			var index:int = getRadioButtonlIndex(radioBtn);
			if (index < 0) 
			{
				_btnList.push(radioBtn);
				radioBtn.isSelected = false;
				radioBtn.displayObject.addEventListener(MouseEvent.CLICK, onRadioBtnClick);
			}
		}
		
		public function getRadioButtonlIndex(radioBtn:IRadioButton):int
		{
			return getRadioButtonIndexByDisplayObj(radioBtn.displayObject);
		}
		
		public function getRadioButtonIndexByDisplayObj(displayObj:DisplayObject):int
		{
			var btn:IRadioButton;
			for (var i:int = 0; i < _btnList.length; i++) 
			{
				btn = _btnList[i];
				if (btn.displayObject == displayObj) {
					return i;
				}
			}
			return -1;
		}
		
		private function onRadioBtnClick(e:MouseEvent):void 
		{
			var index:int = getRadioButtonIndexByDisplayObj(e.currentTarget as DisplayObject);
			if (index >= 0) 
			{
				var evt:UIEvent = new UIEvent(UIEvent.RADIO_BUTTON_GROUP_CLICK, index);
				dispatchEvent(evt);
				if (!evt.isDefaultPrevented())
				{
					selectedIndex = index;
				}
			}
		}
		
		public function set selectedIndex(value:int):void
		{
			if (value < -1 || value >= _btnList.length)
			{
				return;
			}
			if (_selIndex == value)
			{
				return;
			}
			var selBtn:IRadioButton = _btnList[_selIndex];
			if (selBtn) {
				selBtn.isSelected = false;
			}
			selBtn = _btnList[value];
			if (selBtn) {
				selBtn.isSelected = true;
			}
			_selIndex = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get selectedIndex():int
		{
			return _selIndex;
		}
		
		public function set isShow(value:Boolean):void
		{
			_isShow = value;
			var btn:IRadioButton;
			for (var i:int = 0; i < _btnList.length; i++) 
			{
				btn = _btnList[i];
				btn.displayObject.visible = _isShow;
			}
		}
		
		public function get isShow():Boolean
		{
			return _isShow;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			var btn:IRadioButton;
			for (var i:int = 0; i < _btnList.length; i++) 
			{
				btn = _btnList[i];
				btn.enabled = _enabled;
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
	}

}