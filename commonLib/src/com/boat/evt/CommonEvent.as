package com.boat.evt 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class CommonEvent extends Event 
	{
		protected var _data:*;
		
		protected var _isDefaultPrevented:Boolean = false;
		
		public function CommonEvent(type:String, data:*= null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_data = data;
		} 
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
		public override function clone():Event 
		{ 
			return new CommonEvent(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CommonEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public override function preventDefault():void 
		{
			_isDefaultPrevented = true;
		}
		
		public override function isDefaultPrevented():Boolean 
		{
			return _isDefaultPrevented;
		}
		
	}
	
}