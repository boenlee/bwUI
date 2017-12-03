package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Boen
	 */
	public class UIRenderEngine 
	{
		private static var _instance:UIRenderEngine;
		
		private var _frameLooper:Sprite;
		
		private var _rendererFactory:RendererFactory;
		
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
		
		public function init():void
		{			
			_frameLooper = new Sprite();
			_frameLooper.addEventListener(Event.ENTER_FRAME, onFrameLoop);
			
			_rendererFactory = new RendererFactory();
		}		
		
		private function onFrameLoop(e:Event):void 
		{
			render();
		}
		
		private function render():void
		{
			var renderingPool:Dictionary = RenderablePool.instance.getRenderingPool();
			var comp:BaseUIComponent;
			var renderer:IRenderer;
			for each (comp in renderingPool)
			{
				renderer = comp.getRenderer();
				if (!renderer)
				{
					renderer = _rendererFactory.getRenderer(comp);
					comp.setRenderer(renderer);
				}
			}
			
			for each (comp in renderingPool) 
			{
				renderer = comp.getRenderer();
				renderer.render();
				RenderablePool.instance.removeFromRenderingPool(comp);
			}
		}
		
	}

}