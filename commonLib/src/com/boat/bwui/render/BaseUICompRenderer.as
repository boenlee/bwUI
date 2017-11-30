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
			
			if (canRenderProp(RenderFlag.x))
			{
				x = _component.x;
			}
			
			if (canRenderProp(RenderFlag.y))
			{
				y = _component.y;
			}
			
			if (canRenderProp(RenderFlag.width))
			{
				width = _component.width;
			}
			
			if (canRenderProp(RenderFlag.height))
			{
				height = _component.height;
			}
			
		}
		
	}

}