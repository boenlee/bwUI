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
	public class RenderablePool 
	{
		private static var _instance:RenderablePool;
		
		private var _renderablePool:Dictionary;
		
		private var _renderingPool:Dictionary;
		
		public function RenderablePool() 
		{
			if (_instance)
			{
				throw new Error("Exist RenderableUICompPool Instance");
			}
			_renderablePool = new Dictionary();
			_renderingPool = new Dictionary();
		}
		
		public static function get instance():RenderablePool
		{
			if (!_instance)
			{
				_instance = new RenderablePool();
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
			if (!comp || _renderablePool[comp.name] != null)
			{
				return;
			}
			_renderablePool[comp.name] = comp;
			_renderingPool[comp.name] = comp;
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
			if (!comp || _renderablePool[comp.name] == null)
			{
				return;
			}
			delete _renderablePool[comp.name];
			delete _renderingPool[comp.name];
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
		
		public function addToRenderingPool(comp:BaseUIComponent):void
		{
			if (comp)
			{
				if (isRenderable(comp))
				{
					_renderingPool[comp.name] = comp;
				}
			}
		}
		
		public function removeFromRenderingPool(comp:BaseUIComponent):void
		{
			if (comp)
			{
				delete _renderingPool[comp.name];
			}
		}
		
		public function isRenderable(comp:BaseUIComponent):Boolean
		{
			if (!comp)
			{
				return false;
			}
			return _renderablePool[comp.name] != null;
		}
		
		public function getRenderingPool():Dictionary
		{
			return _renderingPool;
		}
		
	}

}