package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	
	/**
	 * ...
	 * @author Boen
	 */
	public interface IRenderer 
	{
		function setComponent(comp:BaseUIComponent):void;
		function render():void;
		function dispose():void;
	}
	
}