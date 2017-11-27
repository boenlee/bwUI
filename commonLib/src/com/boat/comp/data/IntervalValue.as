package com.boat.comp.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class IntervalValue extends EventDispatcher
	{
		public static const MIN_CHANGE:String = "minChange";
		public static const MAX_CHANGE:String = "maxChange";
		public static const VALUE_CHANGE:String = "valueChange";
		
		private var mMinValue:int = 0;
		private var mMaxValue:int = 0;
		private var mValue:int = 0;
		
		public function IntervalValue(initValue:int, min:int, max:int) 
		{
			setInterval(min, max);
			mValue = initValue;
		}
		
		public function setInterval(min:int, max:int):void
		{
			maxValue = Math.max(min, max);
			minValue = Math.min(min, max);
		}
		
		public function get minValue():int 
		{
			return mMinValue;
		}
		
		public function set minValue(val:int):void 
		{
			if (val <= mMaxValue && val != mMinValue) {
				mMinValue = val;
				dispatchEvent(new Event(MIN_CHANGE));
				refreshValue(mValue);
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		public function get maxValue():int 
		{
			return mMaxValue;
		}
		
		public function set maxValue(val:int):void 
		{
			if (val >= mMinValue && val != mMaxValue) {
				mMaxValue = val;
				dispatchEvent(new Event(MAX_CHANGE));
				refreshValue(mValue);
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		public function get value():int 
		{
			return mValue;
		}
		
		public function set value(val:int):void 
		{
			if (refreshValue(val)) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		private function refreshValue(val:int):Boolean {
			var newValue:Number = Math.max(mMinValue, Math.min(mMaxValue, val));
			if (newValue != mValue) {
				mValue = newValue;
				dispatchEvent(new Event(VALUE_CHANGE));
				return true;
			}
			return false;
		}
		
		public function get ratio():Number {
			return (mValue-mMinValue) / (mMaxValue-mMinValue);
		}
		
		public function set ratio(val:Number):void {
			value = Math.round((mMaxValue-mMinValue) * val) + mMinValue;
		}
		
		public function isEqualMin():Boolean {
			return mValue == mMinValue;
		}
		
		public function isEqualMax():Boolean {
			return mValue == mMaxValue;
		}
	}

}