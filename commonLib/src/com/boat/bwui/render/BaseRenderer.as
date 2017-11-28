package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	import com.boat.bwui.components.BaseUISheet;
	import com.boat.bwui.components.StyleUIComponent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Boen
	 */
	public class BaseRenderer extends Sprite implements IRenderer 
	{
		private var _component:BaseUIComponent;
		
		private var _renderFlags:Number = 0;
		
		public function BaseRenderer() 
		{
			super();
			
		}
		
		/* INTERFACE com.boat.bwui.render.IRenderer */
		
		public function setComponent(comp:BaseUIComponent):void 
		{
			_component = comp;
		}
		
		public function setRenderInfo(renderFlag:Number):void
		{
			_renderFlags |= renderFlag;
		}
		
		public function render():void 
		{
			var styleUI:StyleUIComponent = _component as StyleUIComponent;
			if (styleUI)
			{
				addChild(styleUI.getCurrentGraphic());
			}
			
			x = _component.x;
			y = _component.y;
			width = _component.width;
			height = _component.height;
			
			var renderer:IRenderer;
			var uiSheet:BaseUISheet = _component as BaseUISheet;
			var child:BaseUIComponent;
			if (uiSheet)
			{
				for (var i:int = 0; i < uiSheet.numChild; i++) 
				{
					child = uiSheet.getChildByIndex(i);
					renderer = child.getRenderer();
					if (!renderer)
					{
						renderer = new BaseRenderer();
						child.setRenderer(renderer);
					}
					//renderer.render();
					addChild(renderer as DisplayObject);
				}
			}
		}
		
		public function refreshZIndex():void
		{
			removeAllChild();
			var uiSheet:BaseUISheet = _component as BaseUISheet;
			if (uiSheet)
			{
				var renderer:IRenderer;
				var child:BaseUIComponent;
				
				for (var i:int = 0; i < uiSheet.numChild; i++) 
				{					
					addChild(renderer as DisplayObject);
				}
			}
		}
		
		public function removeAllChild():void
		{
			while (numChildren > 1)
			{
				removeChildAt(1);
			}
		}
		
		public function dispose():void
		{
			removeAllChild();
			_component = null;
		}
		
	}

}