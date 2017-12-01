package com.boat.bwui.render 
{
	import com.boat.bwui.components.StyleUIComponent;
	/**
	 * ...
	 * @author Boen
	 */
	public class StyleUICompRenderer extends BaseUISheetRenderer 
	{
		
		public function StyleUICompRenderer() 
		{
			super();
		}
		
		private function get styleUI():StyleUIComponent
		{
			return _component as StyleUIComponent;
		}
		
		override protected function render_impl():void 
		{
			/*var tempRenderFlags:Number = 0;
			
			tempRenderFlags |= removeRenderFlag(RenderFlag.width);
			tempRenderFlags |= removeRenderFlag(RenderFlag.height);
			
			super.render_impl();
			
			_renderFlags |= tempRenderFlags;*/
			
			if (canRenderProp(RenderFlag.width) || canRenderProp(RenderFlag.height))
			{
				/*if (styleUI)
				{
					addChild(styleUI.getCurrentGraphic());
				}*/
				
				trace(this, "wh");
			}
			
			
		}
	}

}