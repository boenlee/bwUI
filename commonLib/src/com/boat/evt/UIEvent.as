package com.boat.evt 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class UIEvent extends CommonEvent 
	{
		public static const SCROLL_LIST_ITEM_SELECTED:String = "scrollListItemSelected";
		public static const SCROLL_LIST_ITEM_UNSELECTED:String = "scrollListItemUnselected";
		public static const TAB_GROUP_CLICK:String = "tabGroupClick";
		public static const RADIO_BUTTON_GROUP_CLICK:String = "radioButtonGroupClick";
		
		public function UIEvent(type:String, data:*= null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public override function clone():Event 
		{ 
			return new UIEvent(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UIEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}
	}

}