package com.boat.bwui.render 
{
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.frames.PolygonStyleFrame;
	import com.boat.bwui.style.frames.setters.IFillSetter;
	import com.boat.bwui.style.frames.setters.IPolygonSetter;
	import com.boat.bwui.style.frames.setters.SolidLineSetter;
	import com.boat.bwui.style.frames.setters.RectangleSetter;
	import com.boat.bwui.style.frames.setters.SolidColorSetter;
	/**
	 * ...
	 * @author boen
	 */
	public class GraphicRenderAgent 
	{
		
		public function GraphicRenderAgent() 
		{
			
		}
		
		public function redraw(renderer:BaseRenderer, width:Number, height:Number, styleFrame:IStyleFrame):void
		{
			/*if (styleFrame is PolygonStyleFrame)
			{
				renderer.graphics.clear();
				
				var polygonStyleFrame:PolygonStyleFrame = styleFrame as PolygonStyleFrame;
				var polygonVo:IPolygonSetter = polygonStyleFrame.polygonVo;
				var fillVo:SolidColorSetter = polygonStyleFrame.polygonFillVo as SolidColorSetter;
				var lineStyleVo:SolidLineSetter = polygonStyleFrame.lineStyleVo;
				if (polygonVo is RectangleSetter)
				{
					var rectangleVo:RectangleSetter = polygonVo as RectangleSetter;
					if (lineStyleVo)
					{
						renderer.graphics.lineStyle(lineStyleVo.thickness, lineStyleVo.color, lineStyleVo.alpha);
					}
					if (fillVo)
					{
						renderer.graphics.beginFill(fillVo.color, fillVo.alpha);
					}
					renderer.graphics.drawRect(0, 0, width,height);
					renderer.graphics.endFill();
				}
			}*/
		}
	}

}