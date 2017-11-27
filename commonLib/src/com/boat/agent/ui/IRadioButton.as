package com.boat.agent.ui 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Boen
	 */
	public interface IRadioButton 
	{
		function set isSelected(value:Boolean):void;
		function get isSelected():Boolean;
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
		function set data(value:*):void;
		function get data():*;
		function get displayObject():DisplayObject;
	}
	
}