package com.boat.agent.ui 
{
	import com.boat.evt.UIEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 
	 */
	public class TabGroupAgent extends EventDispatcher
	{
		private var _tabList:Array;
		private var _viewList:Array;
		
		private var _selIndex:int = -1;
		private var _isShow:Boolean = true;
		private var _enabled:Boolean = true;
		
		public function TabGroupAgent() 
		{
			_tabList = [];
			_viewList = [];
		}
		
		public function addView(view:ITabView):int
		{
			var viewID:int = getViewID(view);
			if (viewID <= 0) {
				view.hide();
				viewID = _viewList.push(view);
			}
			return viewID;
		}
		
		public function getViewID(view:ITabView):int
		{
			return _viewList.indexOf(view) + 1;
		}
		
		public function getView(viewID:int):ITabView
		{
			return _viewList[viewID - 1] || null;
		}
		
		public function getTabCount():int
		{
			return _tabList.length;
		}
		
		public function getTabBtnByIndex(index:int):ITabButton
		{
			var tabHolder:TabHolder = _tabList[index];
			if (tabHolder)
			{
				return tabHolder.tabBtn;
			}
			return null;
		}
		
		public function addTab(tabBtn:ITabButton, viewID:int, viewData:* = null):void
		{
			var index:int = getTablIndex(tabBtn);
			if (index < 0) {
				_tabList.push(new TabHolder(tabBtn, viewID, viewData));
				tabBtn.isSelected = false;
				tabBtn.displayObject.addEventListener(MouseEvent.CLICK, onTabClick);
			}
		}
		
		public function getTablIndex(tabBtn:ITabButton):int
		{
			return getTabIndexByDisplayObj(tabBtn.displayObject);
		}
		
		private function getTabIndexByDisplayObj(displayObj:DisplayObject):int
		{
			var tabHolder:TabHolder;
			for (var i:int = 0; i < _tabList.length; i++) 
			{
				tabHolder = _tabList[i];
				if (tabHolder.tabBtn.displayObject == displayObj) {
					return i;
				}
			}
			return -1;
		}
		
		public function addTabAndView(tabBtn:ITabButton, view:ITabView, viewData:* = null):void
		{
			addTab(tabBtn, addView(view), viewData);
		}
		
		private function onTabClick(e:MouseEvent):void 
		{
			var index:int = getTabIndexByDisplayObj(e.currentTarget as DisplayObject);
			if (index >= 0) 
			{
				var evt:UIEvent = new UIEvent(UIEvent.TAB_GROUP_CLICK, index);
				dispatchEvent(evt);
				if (!evt.isDefaultPrevented())
				{
					selectedIndex = index;
				}
			}
		}
		
		public function set selectedIndex(value:int):void
		{
			if (_selIndex == value)
			{
				return;
			}
			var tabHolder:TabHolder = _tabList[value];
			if (tabHolder && !tabHolder.tabBtn.isSelected) {
				var view:ITabView;
				var selTabHolder:TabHolder = _tabList[_selIndex];
				if (selTabHolder) {
					selTabHolder.tabBtn.isSelected = false;
					if (selTabHolder.viewID != tabHolder.viewID) {
						view = getView(selTabHolder.viewID);
						if (view) {
							view.hide();
						}
					}
				}
				_selIndex = value;
				selTabHolder = tabHolder;
				selTabHolder.tabBtn.isSelected = true;
				view = getView(selTabHolder.viewID);
				if (view) {
					view.show();
					view.setData(selTabHolder.viewData);
					dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
		
		public function get selectedIndex():int
		{
			return _selIndex;
		}
		
		public function set isShow(value:Boolean):void
		{
			_isShow = value;
			var tabHolder:TabHolder;
			for (var i:int = 0; i < _tabList.length; i++) 
			{
				tabHolder = _tabList[i];
				tabHolder.tabBtn.displayObject.visible = _isShow;
			}
		}
		
		public function get isShow():Boolean
		{
			return _isShow;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			var tabHolder:TabHolder;
			for (var i:int = 0; i < _tabList.length; i++) 
			{
				tabHolder = _tabList[i];
				tabHolder.tabBtn.enabled = _enabled;
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
	}

}

import com.boat.agent.ui.ITabButton;

class TabHolder
{
	public var tabBtn:ITabButton;
	public var viewID:int;
	public var viewData:*;
	
	public function TabHolder(tb:ITabButton, vID:int, vData:*)
	{
		tabBtn = tb;
		viewID = vID;
		viewData = vData;
	}
}