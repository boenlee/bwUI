package com.boat.agent.ui
{
	import fl.controls.UIScrollBar;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollBarTextFieldAgent extends Sprite
	{
		private var mIsAddIn:Boolean = false;
		
		private var mTextField:TextField;
		private var mScrollBar:UIScrollBar;
		
		private var mPosX:Number;
		private var mPosY:Number;
		
		private var mDisplayWidth:Number;
		private var mDisplayHeight:Number;
		
		private var mIsAlwaysScrollToEnd:Boolean = false;
		
		public function ScrollBarTextFieldAgent(tf:TextField, addIn:Boolean = false) 
		{
			mIsAddIn = addIn;
			
			mTextField = tf;
			mPosX = mTextField.x;
			mPosY = mTextField.y;
			
			mScrollBar = new UIScrollBar();
			mScrollBar.scrollTarget = mTextField;
			
			if (mIsAddIn) {
				mTextField.x = 0;
				mTextField.y = 0;
				
				addChild(mTextField);
				addChild(mScrollBar);				
			}else {
				mTextField.parent.addChild(mScrollBar);
			}
			
			mScrollBar.drawNow();
			
			x = mPosX;
			y = mPosY;
			width = mTextField.width;
			height = mTextField.height;
		}
		
		public function get textField():TextField
		{
			return mTextField;
		}
		
		override public function get x():Number 
		{
			return mPosX;
		}
		
		override public function set x(value:Number):void 
		{
			mPosX = value;
			if (mIsAddIn) {
				super.x = mPosX;
			}else {
				mTextField.x = mPosX;
				mScrollBar.x = mPosX + mDisplayWidth - mScrollBar.width;
			}
		}
		
		override public function get y():Number 
		{
			return mPosY;
		}
		
		override public function set y(value:Number):void 
		{
			mPosY = value;
			if (mIsAddIn) {
				super.y = mPosY;
			}else {
				mTextField.y = mPosY;
				mScrollBar.y = mPosY;
			}
		}
		
		override public function get width():Number 
		{
			return mDisplayWidth;
		}
		
		override public function set width(value:Number):void 
		{
			mDisplayWidth = value;
			if (mIsAddIn) {
				mScrollBar.x = mDisplayWidth - mScrollBar.width;
			}else {
				mScrollBar.x = mPosX + mDisplayWidth - mScrollBar.width;
			}
			
			refreshScrollBar();
		}
		
		override public function get height():Number 
		{
			return mDisplayHeight;
		}
		
		override public function set height(value:Number):void 
		{
			mDisplayHeight = value;
			mTextField.height = mDisplayHeight;
			mScrollBar.height = mDisplayHeight;
			refreshScrollBar();
		}
		
		public function set text(str:String):void
		{
			mTextField.text = str;
			refreshScrollBar();
		}
		
		public function set htmlText(str:String):void
		{
			mTextField.htmlText = str;
			refreshScrollBar();
		}
		
		public function set isAlwaysScrollToEnd(bool:Boolean):void
		{
			mIsAlwaysScrollToEnd = bool;
		}
		
		public function appendText(str:String):void
		{
			mTextField.appendText(str);
			refreshScrollBar();
		}
		
		//立即刷新一次  1毫秒后再刷新一次  保证任何情况下都正确
		//拖拽缩放窗口时第一次刷新就起作用
		//点击最大化最小化按钮的时候第二次刷新才起作用
		public function refreshScrollBar():void {
			doRefreshScrollBar();
			setTimeout(doRefreshScrollBar, 10);
		}
		
		private function doRefreshScrollBar():void
		{
			if (mIsAlwaysScrollToEnd) {
				mTextField.scrollV = mTextField.maxScrollV;
			}
			mScrollBar.update();
			mScrollBar.visible = mScrollBar.enabled;
			
			if (mScrollBar.enabled) {
				mTextField.width = mDisplayWidth - mScrollBar.width;
			}else {
				mTextField.width = mDisplayWidth;
			}
			
		}
	}

}