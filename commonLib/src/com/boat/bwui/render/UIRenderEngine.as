package com.boat.bwui.render 
{
	import com.boat.bwui.components.UIStage;
	/**
	 * ...
	 * @author Boen
	 */
	public class UIRenderEngine 
	{
		private static var _instance:UIRenderEngine;
		
		public function UIRenderEngine() 
		{
			if (_instance)
			{
				throw new Error("Exist UIRenderEngine Instance");
			}
			super();
		}
		
		public static function get instance():UIRenderEngine
		{
			if (!_instance)
			{
				_instance = new UIRenderEngine();
			}
			return _instance;
		}
		
		public function init():void
		{
			
		}
		
		public function render():void
		{
			UIStage.instance.getRenderer().render();
		}
	}

}