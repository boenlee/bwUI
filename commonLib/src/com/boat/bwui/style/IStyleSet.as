package com.boat.bwui.style 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface IStyleSet 
	{
		//function setStyleFrame(styleFrame:IStyleFrame, frameName:*):void;
		function getStyleFrame(frameName:* = null):IStyleFrame;
	}
	
}