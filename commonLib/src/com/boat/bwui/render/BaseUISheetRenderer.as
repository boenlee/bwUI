package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	import com.boat.bwui.components.BaseUISheet;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Boen
	 */
	public class BaseUISheetRenderer extends BaseUICompRenderer 
	{
		protected var _childList:Array = [];
		
		public function BaseUISheetRenderer() 
		{
			super();
		}
		
		private function get uiSheet():BaseUISheet
		{
			return _component as BaseUISheet;
		}
		
		override protected function render_impl():void 
		{
			super.render_impl();
			
			if (canRenderProp(RenderFlag.childIndex))
			{
				refreshZIndex();
			}
		}
		
		private function refreshZIndex():void
		{
			removeAllChild();
			
			if (uiSheet)
			{
				var childComp:BaseUIComponent;
				var child:DisplayObject;
				for (var i:int = 0; i < uiSheet.numChild; i++) 
				{
					childComp = uiSheet.getChildByIndex(i);
					child = childComp.getRenderer() as DisplayObject;
					if (child)
					{
						addChild(child);
						_childList.push(child);
					}
				}
			}
		}
		
		private function removeAllChild():void
		{
			var child:DisplayObject;
			while (_childList.length > 0)
			{
				child = _childList.pop();
				removeChild(child);
			}
		}
	}

}