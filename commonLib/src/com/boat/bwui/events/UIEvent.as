package com.boat.bwui.events 
{
	import com.boat.bwui.components.BaseUIComponent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boen
	 */
	public class UIEvent extends Event 
	{
		public static const ADD_TO_RENDER:String = "addToRender";
		
		private var _comp:BaseUIComponent;
		
		public function UIEvent(type:String, comp:BaseUIComponent, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_comp = comp;
		} 
		
		public override function clone():Event 
		{ 
			return new UIEvent(type, _comp, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UIEvent", "type", "component", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get component():BaseUIComponent 
		{
			return _comp;
		}
		
	}
	
}