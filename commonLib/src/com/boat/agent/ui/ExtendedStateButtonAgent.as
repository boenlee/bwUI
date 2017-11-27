package com.boat.agent.ui
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ExtendedStateButtonAgent extends EventDispatcher
	{
		private var mMc:MovieClip;
		private var mIsEnabled:Boolean;
		
		public function ExtendedStateButtonAgent(mc:MovieClip) 
		{
			super();
			mMc = mc;
			enabled = true;
		}
		
		public function set enabled(val:Boolean):void {
			if (mIsEnabled == val) {
				return;
			}
			mIsEnabled = val;
			if (mIsEnabled) {
				mMc.gotoAndStop(1);
				mMc.addEventListener(MouseEvent.CLICK, onClick);
			}else {
				mMc.gotoAndStop(2);
				mMc.removeEventListener(MouseEvent.CLICK, onClick);
			}
			mMc.mouseEnabled = mMc.mouseChildren = mIsEnabled;
		}
		
		public function get enabled():Boolean {
			return mIsEnabled;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			dispatchEvent(e);
		}
		
		public function get buttonMc():MovieClip
		{
			return mMc;
		}
		
	}

}