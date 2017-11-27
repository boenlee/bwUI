package com.boat.bwui.components 
{
	import com.boat.bwui.components.BaseUISheet;
	import com.boat.bwui.style.IStyleSetter;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author 
	 */
	public class StyleUIComponent extends BaseUISheet 
	{
		protected var mStyleSetter:IStyleSetter;
		
		public function StyleUIComponent(nm:String) 
		{
			super(nm);
			
		}
		
		public function setStyleSetter(styleSetter:IStyleSetter):void
		{
			mStyleSetter = styleSetter;
			setupStyle();
		}
		
		protected function setupStyle():void {
			
		}
		
		public function getCurrentGraphic():DisplayObject
		{
			return null;
		}
	}

}