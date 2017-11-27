package com.boat.bwui.components 
{
	import com.boat.bwui.components.BaseUIComponent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Boen
	 */
	public class BaseUISheet extends BaseUIComponent 
	{		
		protected var _childList:Array;
		protected var _childDic:Dictionary;
		
		public function BaseUISheet(nm:String) 
		{
			super(nm);
			_childList = [];
			_childDic = new Dictionary();
		}
		
		public function get numChild():uint
		{
			return _childList.length;
		}
		
		public function addChild(child:BaseUIComponent):BaseUIComponent
		{
			if (child)
			{
				_childList.push(child);
				_childDic[child.name] = child;
			}
			return child;
		}
		
		public function addChildAt(child:BaseUIComponent, index:int):BaseUIComponent
		{
			if (child)
			{
				if (index < 0)
				{
					_childList.unshift(child);
				}
				else if (index >= _childList.length)
				{
					_childList.push(child);
				}
				else
				{
					_childList.splice(index, 0, child);
				}
				_childDic[child.name] = child;
			}
			return child;
		}
		
		public function removeChild(child:BaseUIComponent):BaseUIComponent
		{
			if (child)
			{
				var index:int = _childList.indexOf(child);
				if (index >= 0)
				{
					_childList.splice(index, 1);
					delete _childDic[child.name];
				}
			}
			return child;
		}
		
		public function getChildByName(nm:String):BaseUIComponent
		{
			return _childDic[nm];
		}
		
		public function getChildByIndex(index:int):BaseUIComponent
		{
			return _childList[index];
		}
	}

}