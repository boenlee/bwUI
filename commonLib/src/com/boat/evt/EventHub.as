package com.boat.evt 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EventHub extends EventDispatcher 
	{
		private static var _instance:EventHub;
		
		private static var _defaultEvent:Class = CommonEvent;
		
		public function EventHub() 
		{
			super(this);
		}
		
		private static function getInstance():EventHub 
		{
			if (!_instance) {
				_instance = new EventHub();
			}
			return _instance;
		}
		
		public static function get defaultEvent():Class 
		{
			return _defaultEvent;
		}
		
		public static function set defaultEvent(value:Class):void 
		{
			_defaultEvent = value;
		}
		
		public static function addListener(type:String, listener:Function):void 
		{
			getInstance().addEventListener(type, listener);
		}
		
		public static function removeListener(type:String, listener:Function):void 
		{
			getInstance().removeEventListener(type, listener);
		}
		
		public static function sendEvent(type:String, data:* = null):void 
		{
			getInstance().dispatchEvent(new _defaultEvent(type, data));
		}
		
		public static function sendUIEvent(type:String, data:*= null):void
		{
			getInstance().dispatchEvent(new UIEvent(type, data));
		}
		
		public static function sendEventObject(evt:Event):void 
		{
			getInstance().dispatchEvent(evt);
		}
		
	}

}