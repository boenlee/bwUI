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
			print("render_impl")
			
			super.render_impl();
			
			if (canRenderProp(RenderFlag.x))
			{
				x = _component.x;
				printProp("x");
			}
			
			if (canRenderProp(RenderFlag.y))
			{
				y = _component.y;
				printProp("y");
			}
			
			if (canRenderProp(RenderFlag.width))
			{
				width = _component.width;
				printProp("width");
			}
			
			if (canRenderProp(RenderFlag.height))
			{
				height = _component.height;
				printProp("height");
			}
			
		}		
		
	}

}