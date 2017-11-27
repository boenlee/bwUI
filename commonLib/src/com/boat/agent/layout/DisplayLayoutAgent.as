package com.boat.agent.layout 
{
	import com.boat.agent.layout.DisplayAlignAgent;
	import com.boat.agent.layout.DisplayLayoutDependPlace;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class DisplayLayoutAgent 
	{
		private var mDisplayAlignAgent:DisplayAlignAgent;
		
		private var mDependListDic:Dictionary;
		
		private var mDependListCalcDic:Dictionary;
		
		public function DisplayLayoutAgent(parentInitWidth:Number, parentInitHeight:Number) 
		{
			mDisplayAlignAgent = new DisplayAlignAgent(parentInitWidth, parentInitHeight);
			mDependListDic = new Dictionary();
			mDependListCalcDic = new Dictionary();
		}
		
		public function initParentSize(width:Number, height:Number):void
		{
			mDisplayAlignAgent.initParentSize(width, height);
		}
		
		public function addAgentItem(executeObj:*, align:uint, margin:Array = null):void
		{
			mDisplayAlignAgent.addAgentItem(executeObj, align, margin);
			mDependListCalcDic[String(executeObj)] = false;
		}
		
		public function addDependObj(obj:*, dependObj:*, place:int, enabled:Boolean = true):void
		{
			if (!obj.hasOwnProperty("x") || !obj.hasOwnProperty("y") || !obj.hasOwnProperty("width") || !obj.hasOwnProperty("height")) {
				trace(obj + "缺少属性 x/y/width/height 中的一个或多个。");
				return;
			}
			if (!dependObj.hasOwnProperty("x") || !dependObj.hasOwnProperty("y") || !dependObj.hasOwnProperty("width") || !dependObj.hasOwnProperty("height") || !dependObj.hasOwnProperty("visible")) {
				trace(dependObj + "缺少属性 x/y/width/height/visible 中的一个或多个。");
				return;
			}
			var key:String = String(obj);
			if (!mDependListDic[key]) {
				mDependListDic[key] = new DependList(obj);
			}
			mDependListDic[key].addDependObj(dependObj, place);
			mDependListDic[key].setDependObjEnabled(dependObj, enabled);
		}
		
		public function setDependObjEnabled(obj:*, dependObj:*, enabled:Boolean):void
		{
			if (mDependListDic[String(obj)]) {
				mDependListDic[String(obj)].setDependObjEnabled(dependObj, enabled);
			}
		}
		
		public function relayout(parentNewWidth:Number, parentNewHeight:Number):void
		{			
			for (var name:String in mDependListCalcDic) 
			{
				mDependListCalcDic[name] = false;
			}
			
			mDisplayAlignAgent.refreshAlign(parentNewWidth, parentNewHeight);
			
			for each (var dependList:DependList in mDependListDic) 
			{
				refreshItemMarginAndAlign(dependList, parentNewWidth, parentNewWidth);
			}
			
			mDisplayAlignAgent.refreshAlign(parentNewWidth, parentNewHeight);
		}
		
		private function refreshItemMarginAndAlign(dependList:DependList, parentNewWidth:Number, parentNewHeight:Number):void
		{
			if (!dependList) {
				return;
			}
			if (dependList.obj.hasOwnProperty("visible") && !dependList.obj.visible) {
				return;
			}
			
			mDependListCalcDic[String(dependList.obj)] = true;	//在可能递归之前先设置为已经计算过，避免循环引用导致死循环
			
			var newMargin:Array = [0, 0, 0, 0];
			for each (var dependItem:DependItem in dependList.dependList) 
			{
				if (!dependItem.enabled) {
					continue;
				}
				if (dependItem.obj.visible) {
					if (mDependListCalcDic[String(dependItem.obj)] == false) {
						if (mDependListDic[String(dependItem.obj)]) {
							refreshItemMarginAndAlign(mDependListDic[String(dependItem.obj)], parentNewWidth, parentNewWidth);
						}
					}
					
					switch(dependItem.place)
					{
						case DisplayLayoutDependPlace.PLACE_LEFT:
						case DisplayLayoutDependPlace.PLACE_RIGHT:
							if (checkObjsHaveOverlap(dependList.obj, dependItem.obj, false)) {
								newMargin[dependItem.place] += dependItem.obj.width;
							}
							break;
						case DisplayLayoutDependPlace.PLACE_TOP:
						case DisplayLayoutDependPlace.PLACE_BOTTOM:
							if (checkObjsHaveOverlap(dependList.obj, dependItem.obj, true)) {
								newMargin[dependItem.place] += dependItem.obj.height;
							}
							break;
					}
				}
			}
			mDisplayAlignAgent.setAgentItemMargin(dependList.obj, newMargin);
			mDisplayAlignAgent.refreshItemAlign(dependList.obj, parentNewWidth, parentNewWidth);
		}
		
		private function checkObjsHaveOverlap(obj1:*, obj2:*, isHorz:Boolean):Boolean
		{
			if (isHorz) {
				return Math.max(obj1.x, obj2.x) < Math.min(obj1.x + obj1.width, obj2.x + obj2.width);
			}
			return Math.max(obj1.y, obj2.y) < Math.min(obj1.y + obj1.height, obj2.y + obj2.height);
		}
	}

}

class DependList
{
	public var obj:*;
	public var dependList:Array;
	
	public function DependList(pObj:*)
	{
		obj = pObj;
		dependList = [];
	}
	
	public function addDependObj(pDependObj:*, pPlace:int):void
	{
		dependList.push(new DependItem(pDependObj, pPlace));
	}
	
	public function setDependObjEnabled(obj:*, enabled:Boolean):void
	{
		for each (var item:DependItem in dependList) 
		{
			if (item.obj == obj) {
				item.enabled = enabled;
				break;
			}
		}
	}
}

class DependItem
{
	public var obj:*;
	public var place:int;
	public var enabled:Boolean = true;
	
	public function DependItem(pObj:*, pPlace:int) {
		obj = pObj;
		place = pPlace;
	}
}