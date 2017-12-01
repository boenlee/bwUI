package com.boat.bwui.components 
{
	import com.boat.bwui.render.IRenderer;
	/**
	 * ...
	 * @author Boen
	 */
	public class UIStage extends BaseUISheet 
	{
		private static var _instance:UIStage;
		
		public function UIStage() 
		{
			super("UIStage");
		}
		
		public static function get instance():UIStage
		{
			if (!_instance)
			{
				_instance = new UIStage();
			}
			return _instance;
		}
		
		public function init(renderer:IRenderer):void
		{
			setRenderer(renderer);
		}
		
		public function createLayer(nm:String, index:int):void
		{
			addChildAt(new BaseUISheet(nm), index);
		}
		
		public function getLayer(lyr:*):BaseUISheet
		{
			if (lyr is String)
			{
				return getChildByName(lyr as String) as BaseUISheet;
			}
			else if (lyr is Number)
			{
				return getChildByIndex(lyr) as BaseUISheet;
			}
			return null;
		}
		
		public function addChildToLayer(child:BaseUIComponent, ly:*):BaseUIComponent
		{
			if (child)
			{
				child.addTo(getLayer(ly));
			}
			return child;
		}
		
		public function addChildToLayerAt(child:BaseUIComponent, ly:*, index:int):BaseUIComponent
		{
			if (child)
			{
				child.addToAt(getLayer(ly), index);
			}
			return child
		}
	}

}