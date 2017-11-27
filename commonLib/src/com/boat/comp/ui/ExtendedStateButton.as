package com.boat.comp.ui
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author 
	 */
	public class ExtendedStateButton extends MovieClip 
	{
		private var mIsEnabled:Boolean;
		
		public function ExtendedStateButton() 
		{
			super();
			enabled = true;
		}
		
		override public function set enabled(val:Boolean):void {
			if (mIsEnabled == val) {
				return;
			}
			mIsEnabled = val;
			if (mIsEnabled) {
				gotoAndStop(1);
			}else {
				gotoAndStop(2);
			}
			mouseEnabled = mouseChildren = mIsEnabled;
		}
		
		override public function get enabled():Boolean {
			return mIsEnabled;
		}
		
	}

}