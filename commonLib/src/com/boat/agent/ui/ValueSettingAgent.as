package com.boat.agent.ui 
{
	import com.boat.comp.data.IntervalValue;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ValueSettingAgent 
	{
		private var mComp:MovieClip;
		private var mInputBg:MovieClip;
		private var mReduceBtnAgent:ExtendedStateButtonAgent;
		private var mIncreaseBtnAgent:ExtendedStateButtonAgent;
		private var mReduceBtnLongPressAgent:LongPressButtonAgent;
		private var mIncreaseBtnLongPressAgent:LongPressButtonAgent;
		private var mInputAgent:RestrictInputTextFieldAgent;
		private var mSliderAgent:SliderAgent;
		private var mIntervalValue:IntervalValue;
		
		public function ValueSettingAgent(comp:MovieClip, intervalValue:IntervalValue) 
		{
			mComp = comp;
			mIntervalValue = intervalValue;
			initView();
			initEvent();
		}
		
		private function initView():void
		{
			mReduceBtnAgent = new ExtendedStateButtonAgent(mComp.reduceBtnMc);
			mIncreaseBtnAgent = new ExtendedStateButtonAgent(mComp.increaseBtnMc);
			mInputAgent = new RestrictInputTextFieldAgent(mComp.valueInput);
			mInputAgent.setRestrictRegExp(/(^-$) | (^0$) | (^-{0,1}[1-9]\d*$)/x);
			mInputBg = mComp["inputBg"];
			if (mInputBg) {
				mInputBg.gotoAndStop(1);
			}
			mSliderAgent = new SliderAgent(mComp.slider);
			mSliderAgent.ratio = mIntervalValue.ratio;
			onIntervalValueChange(null);
		}
		
		private function initEvent():void
		{
			mIntervalValue.addEventListener(Event.CHANGE, onIntervalValueChange);
			
			mReduceBtnAgent.addEventListener(MouseEvent.CLICK, onChangeBtnClick);
			mIncreaseBtnAgent.addEventListener(MouseEvent.CLICK, onChangeBtnClick);
			
			mReduceBtnLongPressAgent = new LongPressButtonAgent(mReduceBtnAgent.buttonMc, 500, 100, onChangeBtnLongPress);
			mIncreaseBtnLongPressAgent = new LongPressButtonAgent(mIncreaseBtnAgent.buttonMc, 500, 100, onChangeBtnLongPress);
			
			mInputAgent.addEventListener(Event.COMPLETE, onInputComplete);
			mInputAgent.textField.addEventListener(FocusEvent.FOCUS_IN, onInputFocusIn);
			mSliderAgent.addEventListener(Event.CHANGE, onSlide);
		}
		
		private function onIntervalValueChange(e:Event):void 
		{
			mInputAgent.text = String(mIntervalValue.value);
			mSliderAgent.ratio = mIntervalValue.ratio;
			mReduceBtnAgent.enabled = !mIntervalValue.isEqualMin();
			mIncreaseBtnAgent.enabled = !mIntervalValue.isEqualMax();
		}
		
		private function onChangeBtnClick(e:MouseEvent):void 
		{
			onChangeBtnInteractive((e.target as ExtendedStateButtonAgent).buttonMc);
		}
		
		private function onChangeBtnLongPress(longPressAgent:LongPressButtonAgent):void {
			onChangeBtnInteractive(longPressAgent.button);
		}
		
		private function onChangeBtnInteractive(btn:InteractiveObject):void {
			if (btn == mReduceBtnAgent.buttonMc) {
				mIntervalValue.value += -1;
			}else {
				mIntervalValue.value += 1;
			}
		}
		
		private function onInputComplete(e:Event):void 
		{
			if (mInputBg) {
				mInputBg.gotoAndStop(1);
			}
			mIntervalValue.value = int(mInputAgent.text);
		}
		
		private function onInputFocusIn(e:FocusEvent):void 
		{
			if (mInputBg) {
				mInputBg.gotoAndStop(2);
			}
		}
		
		private function onSlide(e:Event):void 
		{
			mIntervalValue.ratio = mSliderAgent.ratio;
		}
		
	}

}