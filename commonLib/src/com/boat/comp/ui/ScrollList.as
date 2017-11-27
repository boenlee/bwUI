package com.boat.comp.ui 
{
	import com.boat.evt.EventHub;
	import com.boat.evt.UIEvent;
	import fl.containers.ScrollPane;
	import fl.controls.ScrollPolicy;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author boen
	 */
	public class ScrollList extends Sprite 
	{
		private const UNSELECTED_ORDER:int = -2;
		
		private var mPadding:Array = [3, 3, 2, 3];
		
		private var mSclPn:ScrollPane;
		
		private var mListContainer:Sprite;
		
		private var mItemClass:Class;
		
		private var mVGap:Number = 0;
		
		private var mItemArr:Array = [];
		private var mItemStorage:Array = [];
		
		private var mSelectedIndex:*;
		private var mSelectedOrder:int;
		
		private var mDataList:Array;
		
		public function ScrollList(cls:Class, scopeObj:DisplayObject, vGap:Number = 0, padding:Array = null)
		{
			mItemClass = cls;
			
			mVGap = vGap;
			
			mListContainer = new Sprite();
			addChild(mListContainer);
			
			mSclPn = new ScrollPane();
			mSclPn.setStyle("upSkin", Sprite);
			mSclPn.source = mListContainer;
			mSclPn.verticalScrollPolicy = ScrollPolicy.AUTO;
			mSclPn.horizontalScrollPolicy = ScrollPolicy.OFF;
			addChild(mSclPn);
			
			setScopeByObj(scopeObj, padding);
			
			mSclPn.focusEnabled = false;
			
			EventHub.addListener(UIEvent.SCROLL_LIST_ITEM_SELECTED, onItemSelected);
			EventHub.addListener(UIEvent.SCROLL_LIST_ITEM_UNSELECTED, onItemSelected);
			
			reset();
		}
		
		public function setScopeByObj(scopeObj:DisplayObject, padding:Array = null):void 
		{
			if (padding) {
				mPadding = padding;
			}
			
			x = scopeObj.x + mPadding[0];
			y = scopeObj.y + mPadding[1];
			mSclPn.width = scopeObj.width - (mPadding[0] + mPadding[2]);
			mSclPn.height = scopeObj.height - (mPadding[1] + mPadding[3]);
			
			resizeItems();
		}
		
		private function onItemSelected(e:UIEvent):void 
		{
			var item:* = e.data as mItemClass;
			if (item) {
				if (e.type == UIEvent.SCROLL_LIST_ITEM_SELECTED) {
					setSelectedIndex(item.getIndex());
				}else {
					setSelectedIndex(null);
				}
			}
		}
		
		private function resizeItems():void
		{
			var item:IScrollListItem;
			for (var i:int = 0; i < mItemArr.length; i++) 
			{
				item = mItemArr[i];
				if (mSclPn.verticalScrollBar.visible)
				{
					item.setWidth(mSclPn.width - mSclPn.verticalScrollBar.width);
				}
				else
				{
					item.setWidth(mSclPn.width);
				}
			}
		}
		
		public function setDataList(dataList:Array):void {
			clearItems();
			mDataList = dataList;
			var item:IScrollListItem;
			for (var i:int = 0; i < dataList.length; i++) 
			{
				if (mItemStorage.length > 0) {
					item = mItemStorage.pop();
				}else {
					item = new mItemClass();
				}
				mItemArr.push(item);
				item.setOrder(i);
				item.setItemData(dataList[i]);
				item.getItemDisplayObject().x = 0;
				item.getItemDisplayObject().y = (item.getItemHeight() + mVGap) * i;
				mListContainer.addChild(item.getItemDisplayObject());
				
				if (mSelectedIndex != null && mSelectedIndex !== "") {
					if (item.getIndex() == mSelectedIndex) {
						if (stage != null) {
							item.setSelected(true);
						}
						mSelectedOrder = item.getOrder();
					}
				}
			}
			updateScrollPane();
			resizeItems();
			refreshSelectedPosition();
		}
		
		private function clearItems():void {
			var item:IScrollListItem;
			var itemDO:DisplayObject;
			while (mItemArr.length > 0) {
				item = mItemArr.pop();
				if (item) {
					mItemStorage.push(item);
					item.setItemData(null);
					itemDO = item.getItemDisplayObject();
					if (itemDO && mListContainer.contains(itemDO)) {
						mListContainer.removeChild(itemDO);
					}
				}
			}
			mSelectedOrder = UNSELECTED_ORDER;
			mDataList = null;
		}
		
		public function setSelectedIndex(selIndex:*):void {
			var item:IScrollListItem;
			var itemIndex:*;
			mSelectedOrder = UNSELECTED_ORDER;
			for (var i:int = 0; i < mItemArr.length; i++) 
			{
				item = mItemArr[i];
				itemIndex = item.getIndex();
				if (itemIndex != null && itemIndex !== "") {
					if (itemIndex == mSelectedIndex) {
						if (stage != null)
						{
							item.setSelected(false);
						}
					}
					if (itemIndex == selIndex) {
						if (stage != null)
						{
							item.setSelected(true);
						}
						mSelectedOrder = item.getOrder();
					}
				}
			}
			mSelectedIndex = selIndex;
		}
		
		public function getSelectedItem():IScrollListItem{
			var item:IScrollListItem;
			var itemIndex:*;
			for (var i:int = 0; i < mItemArr.length; i++) 
			{
				item = mItemArr[i];
				itemIndex = item.getIndex();
				if (itemIndex != null && itemIndex !== "") {
					if (itemIndex == mSelectedIndex) {
						return item;
					}
				}
			}
			return null;
		}
		
		public function setSelectedByDir(dir:int):void {
			if (mItemArr.length == 0) {
				return;
			}
			var selOrder:int = mSelectedOrder + dir;
			if (mSelectedOrder == UNSELECTED_ORDER) {
				selOrder = 0;
			}else {
				selOrder = mSelectedOrder + dir;
				if (selOrder < 0) {
					selOrder = mItemArr.length - 1;
				}else if (selOrder >= mItemArr.length) {
					selOrder = 0;
				}
			}
			if (mSelectedOrder != selOrder) {
				setSelectedByOrder(selOrder);
			}
		}
		
		private function setSelectedByOrder(selOrder:int):void {
			var item:IScrollListItem = mItemArr[selOrder];
			if (item) {
				setSelectedIndex(item.getIndex());
			}
		}
		
		private function updateScrollPane():void
		{
			mSclPn.update();
			if (stage)
			{
				mSclPn.drawNow();
			}
		}
		
		public function refreshSelectedPosition():void {
			var item:IScrollListItem = getSelectedItem();
			if (item) {
				var posY:Number = item.getItemDisplayObject().y;
				if (posY < mSclPn.verticalScrollPosition)
				{
					mSclPn.verticalScrollPosition = posY
				}
				else if (posY > (mSclPn.verticalScrollPosition + mSclPn.height - item.getItemHeight()))
				{
					mSclPn.verticalScrollPosition = posY - mSclPn.height + item.getItemHeight();
				}
			}else {
				mSclPn.verticalScrollPosition = 0;
			}
		}
		
		public function reset():void {
			mSelectedIndex = null;
			clearItems();
			if (mSclPn.verticalScrollPosition != 0) {
				mSclPn.verticalScrollPosition = 0;
			}
			updateScrollPane();
		}
		
		public function getItems():Array {
			return mItemArr;
		}
		
		public function rerenderItems():void {
			var item:IScrollListItem;
			var itemIndex:*;
			for (var i:int = 0; i < mItemArr.length; i++) 
			{
				item = mItemArr[i];
				itemIndex = item.getIndex();
				if (itemIndex != null && itemIndex !== "") {
					if (itemIndex == mSelectedIndex) {
						item.setSelected(true);
					}else {
						item.setSelected(false);
					}
				}
			}
		}
		
		public function getDataList():Array
		{
			return mDataList;
		}
	}

}