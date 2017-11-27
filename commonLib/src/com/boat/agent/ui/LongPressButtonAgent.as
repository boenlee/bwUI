package com.boat.agent.ui 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author 
	 */
	public class LongPressButtonAgent 
	{
		private var mButton:InteractiveObject;
		private var mDelayTimeoutID:int;
		private var mContinuousTimer:Timer;
		
		private var mDelay:uint;
		private var mInterval:uint;
		private var mHandler:Function;
		
		public function LongPressButtonAgent(btn:InteractiveObject, dly:uint, intrvl:uint, func:Function) 
		{
			mButton = btn;
			mDelay = dly;
			mInterval = intrvl;
			mHandler = func;
			
			mButton.addEventListener(MouseEvent.MOUSE_DOWN, onBtnMouseDown);
		}
		
		public function get button():InteractiveObject {
			return mButton;
		}
		
		public function set delay(val:uint):void {
			mDelay = val;
		}
		
		public function set interval(val:uint):void {
			mInterval = val;
		}
		
		private function onBtnMouseDown(e:MouseEvent):void
		{
			clearTimeout(mDelayTimeoutID);
			mDelayTimeoutID = setTimeout(startTimer, mDelay);
			
			if (mButton.stage) {
				mButton.stage.addEventListener(MouseEvent.MOUSE_UP, onBtnMouseUp);
			}
		}
		
		private function onBtnMouseUp(e:MouseEvent):void 
		{
			clearTimeout(mDelayTimeoutID);
			if (mContinuousTimer) {
				mContinuousTimer.stop();
			}
			if (mButton.stage) {
				mButton.stage.removeEventListener(MouseEvent.MOUSE_UP, onBtnMouseUp);
			}
		}
		
		private function startTimer():void {
			clearTimeout(mDelayTimeoutID);
			if (!mContinuousTimer) {
				mContinuousTimer = new Timer(1);
				mContinuousTimer.addEventListener(TimerEvent.TIMER, onTimer);
			}
			mContinuousTimer.delay = mInterval;
			mContinuousTimer.reset();
			mContinuousTimer.start();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			if (mHandler != null) {
				mHandler(this);
			}
		}
	}

}