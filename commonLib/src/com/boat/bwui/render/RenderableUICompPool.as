package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	import com.boat.bwui.components.BaseUISheet;
	import com.boat.bwui.events.UIEvent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Boen
	 */
	public class RenderableUICompPool 
	{
		private static var _instance:RenderableUICompPool;
		
		private var _pool:Dictionary;
		
		public function RenderableUICompPool() 
		{
			if (_instance)
			{
				throw new Error("Exist RenderableUICompPool Instance");
			}
			_pool = new Dictionary();
		}
		
		public static function get instance():RenderableUICompPool
		{
			if (!_instance)
			{
				_instance = new RenderableUICompPool();
			}
			return _instance;
		}
		
		public function init(rootComp:BaseUIComponent):void
		{
			rootComp.addEventListener(UIEvent.ADDED, onCompAdded);
			rootComp.addEventListener(UIEvent.REMOVED, onCompRemoved);
			addToPool(rootComp);
		}
		
		private function onCompAdded(e:UIEvent):void 
		{
			addToPool(e.component);
		}
		
		private function onCompRemoved(e:UIEvent):void 
		{
			removeFromPool(e.component);
		}
		
		private function addToPool(comp:BaseUIComponent):void
		{
			if (!comp || _pool[comp.name] != null)
			{
				return;
			}
			_pool[comp.name] = comp;
			comp.dispatchEvent(new UIEvent(UIEvent.ADDED_TO_STAGE, comp));
			var sheet:BaseUISheet = comp as BaseUISheet;
			if (sheet)
			{
				for (var i:int = 0; i < sheet.numChild; i++) 
				{
					addToPool(sheet.getChildByIndex(i));
				}
			}
		}
		
		private function removeFromPool(comp:BaseUIComponent):void
		{
			if (!comp || _pool[comp.name] == null)
			{
				return;
			}
			delete _pool[comp.name];
			comp.dispatchEvent(new UIEvent(UIEvent.REMOVED_FROM_STAGE, comp));
			var sheet:BaseUISheet = comp as BaseUISheet;
			if (sheet)
			{
				for (var i:int = 0; i < sheet.numChild; i++) 
				{
					removeFromPool(sheet.getChildByIndex(i));
				}
			}
		}
		
		public function isRenderable(comp:BaseUIComponent):Boolean
		{
			if (!comp)
			{
				return false;
			}
			return _pool[comp.name] != null;
		}
		
	}

}