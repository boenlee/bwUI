package com.boat.bwui.render 
{
	import com.boat.bwui.components.StyleUIComponent;
	import com.boat.bwui.style.IStyleFrame;
	/**
	 * ...
	 * @author Boen
	 */
	public class StyleUICompRenderer extends BaseUISheetRenderer 
	{
		protected var _graphicRenderAgent:GraphicRenderAgent;
		
		public function StyleUICompRenderer() 
		{
			super();
			//_graphicRenderAgent = new GraphicRenderAgent();
			
			graphics.beginFill(0xFF00FF, 1);
			graphics.drawRect(10, 10, 50, 50);
			graphics.endFill();
			
			width = 100;
			height = 100;
		}
		
		private function get styleUI():StyleUIComponent
		{
			return _component as StyleUIComponent;
		}
		
		override protected function render_impl():void 
		{			
			//callSuperRenderImplWithInvalidFlags(super.render_impl, RenderFlag.width | RenderFlag.height);
			
			if (!styleUI)
			{
				var styleFrame:IStyleFrame = styleUI.getStyleFrame();
				if (styleFrame.redrawOnResize)
				{
					if (validateRenderFlag(RenderFlag.width) || validateRenderFlag(RenderFlag.height) || validateRenderFlag(RenderFlag.graphic))
					{
						_graphicRenderAgent.redraw(this, _component.width, _component.height, styleFrame);
					}
				}
				else
				{
					if (validateRenderFlag(RenderFlag.graphic))
					{
						_graphicRenderAgent.redraw(this, _component.width, _component.height, styleFrame);
					}
					if (validateRenderFlag(RenderFlag.width))
					{						
						//width = _component.width;
					}
					if (validateRenderFlag(RenderFlag.height))
					{
						//height = _component.height;
					}
				}
			}
		}
	}

}