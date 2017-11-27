package com.boat.bwui.mgr 
{
	import com.boat.bwui.components.BaseUIComponent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Boen
	 */
	public class UIComponentManager 
	{
		private static var _instance:UIComponentManager;
		
		private var _componentSIDDic:Dictionary;
		private var _componentNameDic:Dictionary;
		
		private var _componentSerialNumber:Number = 0;
		
		public function UIComponentManager() 
		{
			if (_instance)
			{
				throw new Error("Exist UIComponentManager Instance");
			}
			
			_componentSIDDic = new Dictionary();
			_componentNameDic = new Dictionary();
		}
		
		public static function get instance():UIComponentManager
		{
			if (!_instance)
			{
				_instance = new UIComponentManager();
			}
			return _instance;
		}
		
		public function get componentSerialNumber():Number 
		{
			return _componentSerialNumber;
		}
		
		public function addComponent(comp:BaseUIComponent):BaseUIComponent
		{
			if (comp)
			{
				if (!_componentNameDic[comp.name])
				{
					var item:ComponentItem = new ComponentItem(_componentSerialNumber, comp);
					_componentNameDic[comp.name] = item;
					_componentSIDDic[_componentSerialNumber] = item;
					_componentSerialNumber++;
				}
				else
				{
					throw new Error("Exist Component " + comp.name);
				}
			}
			return comp;
		}
		
		public function getComponentByName(compName:String):BaseUIComponent
		{
			var item:ComponentItem = _componentNameDic[compName];
			if (item)
			{
				return item.comp;
			}
			return null;
		}
		
		public function getComponentBySID(sid:Number):BaseUIComponent
		{
			var item:ComponentItem = _componentSIDDic[sid];
			if (item)
			{
				return item.comp;
			}
			return null;
		}
		
		public function removeComponent(comp:BaseUIComponent):BaseUIComponent
		{
			if (comp)
			{
				var item:ComponentItem = _componentNameDic[comp.name];
				if (item)
				{
					delete _componentSIDDic[item.sid];
					delete _componentNameDic[comp.name];
				}
			}
			return comp;
		}
		
		public function removeComponentByName(compName:String):BaseUIComponent
		{
			var item:ComponentItem = _componentNameDic[compName];
			if (item)
			{
				delete _componentSIDDic[item.sid];
				delete _componentNameDic[compName];
				return item.comp;
			}
			return null;
		}
		
		public function removeComponentBySID(sid:String):BaseUIComponent
		{
			var item:ComponentItem = _componentSIDDic[sid];
			if (item)
			{
				delete _componentSIDDic[sid];
				delete _componentNameDic[item.comp.name];
				return item.comp;
			}
			return null;
		}
	}

}
import com.boat.bwui.components.BaseUIComponent;

class ComponentItem
{
	public var sid:Number;
	public var comp:BaseUIComponent;
	
	public function ComponentItem(psid:Number, pcomp:BaseUIComponent)
	{
		sid = psid;
		comp = pcomp;
	}
}