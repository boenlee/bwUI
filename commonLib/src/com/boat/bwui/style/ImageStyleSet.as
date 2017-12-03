package com.boat.bwui.style 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boen
	 */
	public class ImageStyleSet implements IStyleSet 
	{
		protected var _styleFrameDic:Dictionary;
		
		public function ImageStyleSet() 
		{
			_styleFrameDic = new Dictionary();
		}
		
		public function setStyleFrame(styleFrame:IStyleFrame, frameName:* = null):void
		{
			if (frameName == null)
			{
				frameName = StyleFrameNameDef.DEFAULT;
			}
			_styleFrameDic[frameName] = styleFrame;
		}
		
		public function getStyleFrame(frameName:* = null):IStyleFrame
		{
			if (frameName == null)
			{
				frameName = StyleFrameNameDef.DEFAULT;
			}
			return _styleFrameDic[frameName];
		}
		
	}

}