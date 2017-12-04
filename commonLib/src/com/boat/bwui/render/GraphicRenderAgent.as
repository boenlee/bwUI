package com.boat.bwui.render 
{
	import com.boat.bwui.style.IStyleFrame;
	import com.boat.bwui.style.frames.PolygonStyleFrame;
	import com.boat.bwui.style.vo.IPolygonVo;
	import com.boat.bwui.style.vo.LineStyleVo;
	import com.boat.bwui.style.vo.RectanglePolygonVo;
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
			if (styleFrame is PolygonStyleFrame)
			{
				renderer.graphics.clear();
				
				var polygonStyleFrame:PolygonStyleFrame = styleFrame as PolygonStyleFrame;
				var polygonVo:IPolygonVo = polygonStyleFrame.polygonVo;
				var lineStyleVo:LineStyleVo = polygonStyleFrame.lineStyleVo;
				if (polygonVo is RectanglePolygonVo)
				{
					var rectangleVo:RectanglePolygonVo = polygonVo as RectanglePolygonVo;
					if (lineStyleVo)
					{
						renderer.graphics.lineStyle(lineStyleVo.thickness, lineStyleVo.color, lineStyleVo.alpha);
					}
					renderer.graphics.beginFill(rectangleVo.color, rectangleVo.alpha);
					renderer.graphics.drawRect(rectangleVo.x, rectangleVo.y, rectangleVo.width, rectangleVo.height);
					renderer.graphics.endFill();
				}
			}
		}
	}

}