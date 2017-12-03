package com.boat.bwui.components 
{
	import com.boat.bwui.components.BaseUISheet;
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.IStyleSet;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author 
	 */
	public class StyleUIComponent extends BaseUISheet 
	{
		protected var _styleSet:IStyleSet;
		
		protected var _styleFrame:*;
		
		public function StyleUIComponent(nm:String) 
		{
			super(nm);
			
		}
		
		public function setStyleSet(styleSet:IStyleSet):void
		{
			_styleSet = styleSet;
		}
		
		public function getStyleFrame():IStyleFrame
		{
			if (_styleSet)
			{
				return _styleSet.getStyleFrame(_styleFrame);
			}
			return null;
		}
	}

}