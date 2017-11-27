package com.boat.agent.layout 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class DisplayAlignAgent 
	{
		private var mItemHash:Dictionary;
		
		private var mParentWidth:Number;
		private var mParentHeight:Number;
		
		public function DisplayAlignAgent(parentInitWidth:Number, parentInitHeight:Number) 
		{
			mItemHash = new Dictionary();
			initParentSize(parentInitWidth, parentInitHeight);
		}
		
		public function initParentSize(width:Number, height:Number):void
		{
			mParentWidth = width;
			mParentHeight = height;
		}
		
		public function addAgentItem(executeObj:*, align:uint, margin:Array = null):void
		{
			if (!executeObj.hasOwnProperty("x") || !executeObj.hasOwnProperty("y") || !executeObj.hasOwnProperty("width") || !executeObj.hasOwnProperty("height")) {
				trace(executeObj + "缺少属性 x/y/width/height 中的一个或多个。");
				return;
			}
			mItemHash[executeObj] = new DisplayAlignAgentItem(executeObj, mParentWidth, mParentHeight, align, margin);
		}
		
		public function setAgentItemAlign(executeObj:*, align:uint):void
		{
			if (mItemHash[executeObj])
			{
				mItemHash[executeObj].setAlign(align);
			}
		}
		
		public function getAgentItemAlign(executeObj:*):uint
		{
			if (mItemHash[executeObj])
			{
				return mItemHash[executeObj].getAlign();
			}
			return 0;
		}
		
		public function setAgentItemMargin(executeObj:*, margin:Array):void
		{
			if (mItemHash[executeObj])
			{
				mItemHash[executeObj].setMargin(margin);
			}
		}
		
		public function getAgentItemMargin(executeObj:*):Array
		{
			if (mItemHash[executeObj])
			{
				return mItemHash[executeObj].getMargin();
			}
			return null;
		}
		
		public function refreshAlign(parentNewWidth:Number, parentNewHeight:Number):void
		{
			mParentWidth = parentNewWidth;
			mParentHeight = parentNewHeight;
			for each (var item:DisplayAlignAgentItem in mItemHash) 
			{
				item.refreshAlign(mParentWidth, mParentHeight);
			}
		}
		
		public function refreshItemAlign(executeObj:*, parentNewWidth:Number, parentNewHeight:Number):void
		{
			if (mItemHash[executeObj])
			{
				mItemHash[executeObj].refreshAlign(parentNewWidth, parentNewHeight);
			}
		}
		
		public function get parentWidth():Number 
		{
			return mParentWidth;
		}
		
		public function get parentHeight():Number 
		{
			return mParentHeight;
		}
	}

}
import com.boat.agent.layout.DisplayAlignType;

class DisplayAlignAgentItem
{
	private var mExecuteObj:*;
	private var mParentWidth:Number;
	private var mParentHeight:Number;
	private var mAlign:uint;
	private var mMargin:Array;
	private var mMarginDataArr:Array;
	
	public function DisplayAlignAgentItem(executeObj:*, parentInitWidth:Number, parentInitHeight:Number, align:uint, margin:Array = null) 
	{
		mExecuteObj = executeObj;
		mParentWidth = parentInitWidth;
		mParentHeight = parentInitHeight;
		mAlign = align;
		mMargin = margin;
		mMarginDataArr = [];
		initMargin();
		refreshAlign(mParentWidth, mParentHeight);
	}
	
	private function initMargin():void
	{
		if (!mMargin) {
			mMargin = [];
		}
		initMarginElement(0, mExecuteObj.x);
		initMarginElement(1, mExecuteObj.y);
		initMarginElement(2, mParentWidth - mExecuteObj.x - mExecuteObj.width);
		initMarginElement(3, mParentHeight - mExecuteObj.y - mExecuteObj.height);
	}
	
	private function initMarginElement(index:int, defaultVal:Number):void
	{
		if (mMargin[index] == undefined || mMargin[index] == null) {
			mMargin[index] = defaultVal;
		}
		mMarginDataArr[index] = new MarginData(mMargin[index]);
	}
	
	public function setMargin(margin:Array):void
	{
		mMargin = margin;
		initMargin();
	}
	
	public function getMargin():Array
	{
		return mMargin;
	}
	
	public function setAlign(align:uint):void
	{
		mAlign = align;
	}
	
	public function getAlign():uint
	{
		return mAlign;
	}
	
	public function refreshAlign(parentNewWidth:Number, parentNewHeight:Number):void
	{
		mParentWidth = parentNewWidth;
		mParentHeight = parentNewHeight;
		
		var ml:MarginData = mMarginDataArr[0];
		var mt:MarginData = mMarginDataArr[1];
		var mr:MarginData = mMarginDataArr[2];
		var mb:MarginData = mMarginDataArr[3];
		
		if ((mAlign & DisplayAlignType.LEFT) > 0) {
			if (ml.usePercent) {
				mExecuteObj.x = int(ml.calcByPercent(mParentWidth));
			}else {
				mExecuteObj.x = int(ml.offset);
			}
		}
		if ((mAlign & DisplayAlignType.RIGHT) > 0) {
			if (mr.usePercent) {
				mExecuteObj.x = int(mr.calcByPercent(mParentWidth) - mExecuteObj.width);
			}else {
				mExecuteObj.x = int(mParentWidth - mr.offset - mExecuteObj.width);
			}
		}
		if ((mAlign & DisplayAlignType.HORZ_CENTER) > 0) {
			mExecuteObj.x = int((mParentWidth -  mExecuteObj.width) / 2);
		}
		if ((mAlign & DisplayAlignType.TOP) > 0) {
			if (mt.usePercent) {
				mExecuteObj.y = int(mt.calcByPercent(mParentHeight));
			}else {
				mExecuteObj.y = int(mt.offset);
			}
		}
		if ((mAlign & DisplayAlignType.BOTTOM) > 0) {
			if (mb.usePercent) {
				mExecuteObj.y = int(mb.calcByPercent(mParentHeight) - mExecuteObj.height);
			}else {
				mExecuteObj.y = int(mParentHeight - mb.offset - mExecuteObj.height);
			}
		}
		if ((mAlign & DisplayAlignType.VERT_CENTER) > 0) {
			mExecuteObj.y = int((mParentHeight -  mExecuteObj.height) / 2);
		}
		if ((mAlign & DisplayAlignType.HORZ_JUSTIFY) > 0) {
			if (ml.usePercent) {
				mExecuteObj.x = int(ml.calcByPercent(mParentWidth));
			}else {
				mExecuteObj.x = int(ml.offset);
			}
			if (mr.usePercent) {
				mExecuteObj.width = int(mr.calcByPercent(mParentWidth) - mExecuteObj.x);
			}else {
				mExecuteObj.width = int(mParentWidth - mExecuteObj.x - mr.offset);
			}
			
		}
		if ((mAlign & DisplayAlignType.VERT_JUSTIFY) > 0) {
			if (mt.usePercent) {
				mExecuteObj.y = int(mt.calcByPercent(mParentHeight));
			}else {
				mExecuteObj.y = int(mt.offset);
			}
			if (mb.usePercent) {
				mExecuteObj.height = int(mb.calcByPercent(mParentHeight) - mExecuteObj.y);
			}else {
				mExecuteObj.height = int(mParentHeight - mExecuteObj.y - mb.offset);
			}
		}
	}
}

class MarginData
{
	public var percent:Number;
	public var offset:Number = 0;
	
	public function MarginData(val:*)
	{
		if (val is Number)
		{
			offset = val;
		}
		else if (val is String)
		{
			var str:String = val as String;
			var percentIndex:int = str.indexOf("%");
			percent = Number(str.substr(0, percentIndex));
			if (!isNaN(percent)) {
				percent = percent / 100;
			}
			offset = Number(str.substr(percentIndex + 1));
			if (isNaN(offset)) {
				offset = 0;
			}
		}
	}
	
	public function get usePercent():Boolean {
		return !isNaN(percent);
	}
	
	public function calcByPercent(val:Number):Number {
		return val * percent + offset;
	}
}