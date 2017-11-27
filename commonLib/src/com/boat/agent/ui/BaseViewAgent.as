package com.boat.agent.ui 
{
	import com.boat.agent.layout.DisplayAlignAgent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class BaseViewAgent implements IDragToResizeObject
	{
		protected var mDisplayAlignAgent:DisplayAlignAgent;
		
		protected var mMc:MovieClip;
		
		protected var mDisplayWidth:Number;
		protected var mDisplayHeight:Number;
		
		protected var mPosX:Number;
		protected var mPosY:Number;
		
		protected var mScrollRect:Rectangle;
		
		public function BaseViewAgent(mc:MovieClip) 
		{
			mMc = mc;
			
			baseInit();
			initView();
			initEvent();
		}
		
		protected function baseInit():void
		{
			mDisplayAlignAgent = new DisplayAlignAgent(0, 0);
			initDisplaySize(mMc.width, mMc.height);
			initPosition(mMc.x, mMc.y);
			
			mScrollRect = new Rectangle();
			refresScrollRect();
		}
		
		protected function initDisplaySize(w:Number, h:Number):void
		{
			mDisplayWidth = w;
			mDisplayHeight = h;
			mDisplayAlignAgent.initParentSize(mDisplayWidth, mDisplayHeight);
		}
		
		protected function initPosition(px:Number, py:Number):void
		{
			mPosX = px;
			mPosY = py;
		}
		
		protected function initView():void
		{
			
		}
		
		protected function initEvent():void
		{
			
		}
		
		protected function addDisplayAlignItem(item:*, align:uint, margin:Array = null):void
		{
			mDisplayAlignAgent.addAgentItem(item, align, margin);
		}
		
		public function get width():Number
		{
			return mDisplayWidth;
		}
		
		public function set width(val:Number):void
		{
			if (mDisplayWidth != val) {
				mDisplayWidth = val;
				onResize();
			}
		}
		
		public function get height():Number
		{
			return mDisplayHeight;
		}
		
		public function set height(val:Number):void
		{
			if (mDisplayHeight != val) {
				mDisplayHeight = val;
				onResize();
			}
		}
		
		public function get x():Number 
		{
			return mPosX;
		}
		
		public function set x(val:Number):void 
		{
			mPosX = val;
			mMc.x = mPosX;
		}
		
		public function get y():Number 
		{
			return mPosY;
		}
		
		public function set y(val:Number):void 
		{
			mPosY = val;
			mMc.y = mPosY;
		}
		
		public function get mc():MovieClip
		{
			return mMc;
		}
		
		public function get displayObject():DisplayObject
		{
			return mMc;
		}
		
		protected function onResize():void
		{
			mDisplayAlignAgent.refreshAlign(mDisplayWidth, mDisplayHeight);
			refresScrollRect();
		}
		
		protected function refresScrollRect():void
		{
			mScrollRect.width = mDisplayWidth;
			mScrollRect.height = mDisplayHeight;
			mMc.scrollRect = mScrollRect;
		}
	}

}