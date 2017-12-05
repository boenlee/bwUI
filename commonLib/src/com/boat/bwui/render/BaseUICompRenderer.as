package com.boat.bwui.render 
{
	/**
	 * ...
	 * @author Boen
	 */
	public class BaseUICompRenderer extends BaseRenderer 
	{
		
		public function BaseUICompRenderer() 
		{
			super();
		}
		
		override protected function render_impl():void 
		{
			super.render_impl();
			
			if (validateRenderFlag(RenderFlag.x))
			{
				x = _component.x;
				//printProp("x");
			}
			
			if (validateRenderFlag(RenderFlag.y))
			{
				y = _component.y;
				//printProp("y");
			}
			
			/*if (validateRenderFlag(RenderFlag.width))
			{
				width = _component.width;
				//printProp("width");
			}
			
			if (validateRenderFlag(RenderFlag.height))
			{
				height = _component.height;
				//printProp("height");
			}*/
			
		}
		
	}

}