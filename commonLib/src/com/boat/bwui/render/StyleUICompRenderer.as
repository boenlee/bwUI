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
		protected var _canvas:Sprite;
		
		public function StyleUICompRenderer() 
		{
			super();
			_canvas = new Sprite();
			addChild(_canvas);
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
							styleFrame.setStyleTo(_canvas, _component.width, component.height);
						}
					}
					else
					{
						if (validateRenderFlag(RenderFlag.graphic))
						{							
							styleFrame.setStyleTo(_canvas, _component.width, component.height);
						}
						if (validateRenderFlag(RenderFlag.width))
						{						
							_canvas.width = _component.width;
						}
						if (validateRenderFlag(RenderFlag.height))
						{
							_canvas.height = _component.height;
						}
					}
				}
			}
		}
	}

}