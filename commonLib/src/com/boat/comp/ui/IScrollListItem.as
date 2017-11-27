package com.boat.comp.ui
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IScrollListItem 
	{
		function getItemHeight():Number;
		function setItemData(obj:*):void;
		function getItemData():*;
		function getItemDisplayObject():DisplayObject;
		function getIndex():*;
		function setSelected(selected:Boolean):void;
		function getOrder():int;
		function setOrder(order:int):void;
		function setWidth(newWidth:Number):void;
	}
	
}