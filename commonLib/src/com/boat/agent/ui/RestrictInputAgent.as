package com.boat.agent.ui
{
	import fl.controls.TextInput;
	import fl.events.ComponentEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class RestrictInputAgent extends EventDispatcher
	{
		private var mInput:TextInput;
		
		private var mOldStr:String = "";
		private var mOldCaretIndex:int = 0;
		
		private var mRestrictRegExp:RegExp;
		
		public function RestrictInputAgent(input:TextInput) 
		{
			mInput = input;
			mInput.addEventListener(Event.CHANGE, onInputChange);
			mInput.addEventListener(TextEvent.TEXT_INPUT, onInput);
			mInput.addEventListener(FocusEvent.FOCUS_IN, onInputFocusIn);
			mInput.addEventListener(ComponentEvent.ENTER, onInputEnter);
			mInput.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onInputMouseFocusChange);
		}		
		
		private function onInputChange(e:Event):void 
		{
			if (mRestrictRegExp) {
				var tempStr:String = mInput.text;
				if (tempStr != null && tempStr != "") {
					if (!mRestrictRegExp.test(tempStr)) {
						mInput.text = mOldStr;
						mInput.setSelection(mOldCaretIndex, mOldCaretIndex);
					}
				}
			}
		}
		
		private function onInput(e:TextEvent):void 
		{
			recordLastTextFieldInfo();
		}
		
		private function onInputFocusIn(e:FocusEvent):void 
		{
			recordLastTextFieldInfo();
		}
		
		private function onInputEnter(e:ComponentEvent):void 
		{
			onComplete();
		}
		
		private function onInputMouseFocusChange(e:FocusEvent):void 
		{
			onComplete();
		}
		
		public function setSize(w:Number, h:Number):void {
			mInput.setSize(w, h);
		}
		
		public function setRestrictRegExp(value:RegExp):void {
			mRestrictRegExp = value;
		}
		
		private function recordLastTextFieldInfo():void {
			mOldStr = mInput.text;
			mOldCaretIndex = mInput.textField.caretIndex;
		}
		
		private function onComplete():void {
			if (mInput.stage) {
				mInput.stage.focus = null;
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get text():String {
			return mInput.text;
		}
		
		public function set text(val:String):void {
			mInput.text = val;
		}
		
		public function get enabled():Boolean {
			return mInput.enabled;
		}
		
		public function set enabled(val:Boolean):void {
			mInput.enabled = val;
		}
		
		public function get input():TextInput
		{
			return mInput;
		}
	}

}