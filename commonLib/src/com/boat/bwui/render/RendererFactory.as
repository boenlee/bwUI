package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	import com.boat.bwui.components.BaseUISheet;
	import com.boat.bwui.components.StyleUIComponent;
	import com.boat.bwui.utils.ClassUtils;
	/**
	 * ...
	 * @author Boen
	 */
	public class RendererFactory 
	{
		
		public function RendererFactory() 
		{
			
		}
		
		public function getRenderer(comp:BaseUIComponent):IRenderer
		{
			var clsName:String = ClassUtils.getOnlyClassName(comp);
			var renderer:IRenderer;
			switch(clsName)
			{
				case "UIStage":
					renderer = new BaseUISheetRenderer();
					break;
				default:
					if (comp as StyleUIComponent)
					{
						renderer = new StyleUICompRenderer();
					}
					else if (comp as BaseUISheet)
					{
						renderer = new BaseUISheetRenderer();
					}
					else
					{
						renderer = new BaseUICompRenderer();
					}
			}
			return renderer;
		}
	}

}