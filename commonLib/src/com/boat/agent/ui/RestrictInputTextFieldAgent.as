package com.boat.agent.ui 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class RestrictInputTextFieldAgent extends EventDispatcher
	{
		private var mInputTf:TextField;
		
		private var mEnabled:Boolean = true;
		
		private var mOldStr:String = "";
		private var mOldCaretIndex:int = 0;
		
		private var mRestrictRegExp:RegExp;
		
		public function RestrictInputTextFieldAgent(inputTf:TextField) 
		{
			mInputTf = inputTf;
			mInputTf.addEventListener(Event.CHANGE, onInputChange);
			mInputTf.addEventListener(TextEvent.TEXT_INPUT, onInput);
			mInputTf.addEventListener(FocusEvent.FOCUS_IN, onInputFocusIn);
			mInputTf.addEventListener(KeyboardEvent.KEY_UP, onInputEnter);
			mInputTf.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onInputMouseFocusChange);
			mInputTf.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onInputChange(e:Event):void 
		{
			if (mRestrictRegExp) {
				var tempStr:String = mInputTf.text;
				if (tempStr != null && tempStr != "") {
					if (!mRestrictRegExp.test(tempStr)) {
						mInputTf.text = mOldStr;
						mInputTf.setSelection(mOldCaretIndex, mOldCaretIndex);
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
		
		private function onInputEnter(e:KeyboardEvent):void 
		{
			if (e.keyCode == 13) {
				onComplete();
			}
		}
		
		private function onInputMouseFocusChange(e:FocusEvent):void 
		{
			onComplete();
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			onComplete();
		}
		
		public function setSize(w:Number, h:Number):void {
			mInputTf.width = w;
			mInputTf.height = h;
		}
		
		public function setRestrictRegExp(value:RegExp):void {
			mRestrictRegExp = value;
		}
		
		private function recordLastTextFieldInfo():void {
			mOldStr = mInputTf.text;
			mOldCaretIndex = mInputTf.caretIndex;
		}
		
		private function onComplete():void {
			if (mInputTf.stage) {
				mInputTf.stage.focus = null;
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get text():String {
			return mInputTf.text;
		}
		
		public function set text(val:String):void {
			mInputTf.text = val;
		}
		
		public function get enabled():Boolean {
			return mEnabled;
		}
		
		public function set enabled(val:Boolean):void {
			mEnabled = val;
			mInputTf.mouseEnabled = mEnabled;
		}
		
		public function get textField():TextField {
			return mInputTf;
		}
	}

}