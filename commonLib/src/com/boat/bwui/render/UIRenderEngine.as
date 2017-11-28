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
		
		private var _rootRender:IRenderer;
		
		public function UIRenderEngine() 
		{
			if (_instance)
			{
				throw new Error("Exist UIRenderEngine Instance");
			}
		}
		
		public static function get instance():UIRenderEngine
		{
			if (!_instance)
			{
				_instance = new UIRenderEngine();
			}
			return _instance;
		}
		
		public function init(rootRender:IRenderer):void
		{
			_rootRender = rootRender;
		}
		
		public function render():void
		{
			
		}
	}

}