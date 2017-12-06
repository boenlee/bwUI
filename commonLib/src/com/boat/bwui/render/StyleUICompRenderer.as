package com.boat.bwui.render 
{
	import com.boat.bwui.components.StyleUIComponent;
	import com.boat.bwui.style.IStyleFrame;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Boen
	 */
	public class StyleUICompRenderer extends BaseUISheetRenderer 
	{
		protected var _graphicRenderAgent:GraphicRenderAgent;
		
		protected var _styleChild:Sprite;
		
		public function StyleUICompRenderer() 
		{
			super();
			_graphicRenderAgent = new GraphicRenderAgent();
			_styleChild = new Sprite();
			addChild(_styleChild);
		}
		
		private function get styleUI():StyleUIComponent
		{
			return _component as StyleUIComponent;
		}
		
		override protected function render_impl():void 
		{			
			callSuperRenderImplWithInvalidFlags(super.render_impl, RenderFlag.width | RenderFlag.height);
			
			if (styleUI)
			{
				var styleFrame:IStyleFrame = styleUI.getStyleFrame();
				if (styleFrame)
				{
					if (styleFrame.redrawOnResize)
					{
						if (validateRenderFlag(RenderFlag.width) || validateRenderFlag(RenderFlag.height) || validateRenderFlag(RenderFlag.graphic))
						{
							//_graphicRenderAgent.redraw(this, _component.width, _component.height, styleFrame);
							
							styleFrame.setStyleTo(_styleChild, _component.width, component.height);
						}
					}
					else
					{
						if (validateRenderFlag(RenderFlag.graphic))
						{
							//_graphicRenderAgent.redraw(this, _component.width, _component.height, styleFrame);
							
							styleFrame.setStyleTo(_styleChild, _component.width, component.height);
						}
						if (validateRenderFlag(RenderFlag.width))
						{						
							_styleChild.width = _component.width;
						}
						if (validateRenderFlag(RenderFlag.height))
						{
							_styleChild.height = _component.height;
						}
					}
				}
			}
		}
	}

}