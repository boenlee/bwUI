package com.boat.bwui.render 
{
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
		
		private var _rootRenderer:IRenderer;
		
		private var _rendererPool:Dictionary;
		
		private var _frameLooper:Sprite;
		
		public function UIRenderEngine() 
		{
			if (_instance)
			{
				throw new Error("Exist UIRenderEngine Instance");
			}
			_rendererPool = new Dictionary();
		}
		
		public static function get instance():UIRenderEngine
		{
			if (!_instance)
			{
				_instance = new UIRenderEngine();
			}
			return _instance;
		}
		
		public function init(rootRenderer:IRenderer):void
		{
			_rootRenderer = rootRenderer;
			
			_frameLooper = new Sprite();
			_frameLooper.addEventListener(Event.ENTER_FRAME, onFrameLoop);
		}
		
		public function addToRenderPool(renderer:IRenderer):void
		{
			if (renderer && renderer.component)
			{
				if (RenderableUICompPool.instance.isRenderable(renderer.component))
				{
					_rendererPool[renderer.component.name] = renderer;
				}
			}
		}
		
		public function removeFromRenderPool(renderer:IRenderer):void
		{
			if (renderer && renderer.component)
			{
				delete _rendererPool[renderer.component.name];
			}
		}
		
		private function onFrameLoop(e:Event):void 
		{
			render();
		}
		
		private function render():void
		{
			for each (var renderer:IRenderer in _rendererPool) 
			{
				
			}
		}
		
	}

}