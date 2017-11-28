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
		function setRenderInfo(renderFlag:Number):void;
		function dispose():void;
	}
	
}