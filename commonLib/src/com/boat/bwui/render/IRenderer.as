package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	
	/**
	 * ...
	 * @author Boen
	 */
	public interface IRenderer 
	{
		function set component(comp:BaseUIComponent):void;
		function get component():BaseUIComponent
		function setRenderFlag(renderFlag:Number):void;
		function getRenderFlags():Number;
		function render(renderAll:Boolean = false):void;
		function dispose():void;
	}
	
}