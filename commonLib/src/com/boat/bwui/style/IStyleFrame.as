package com.boat.bwui.style 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author boen
	 */
	public interface IStyleFrame 
	{
		function get redrawOnResize():Boolean;
		function set redrawOnResize(value:Boolean):void;
		function setStyleTo(sprite:Sprite, width:Number, height:Number):void;
	}
	
}