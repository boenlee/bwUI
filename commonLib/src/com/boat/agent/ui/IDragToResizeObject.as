package com.boat.agent.ui
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IDragToResizeObject 
	{
		function get displayObject():DisplayObject;
		function get x():Number;
		function set x(val:Number):void;
		function get y():Number;
		function set y(val:Number):void;
		function get width():Number;
		function set width(val:Number):void;
		function get height():Number;
		function set height(val:Number):void;
	}
	
}