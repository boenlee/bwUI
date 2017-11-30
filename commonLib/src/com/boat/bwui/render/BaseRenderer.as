package com.boat.bwui.render 
{
	import com.boat.bwui.components.BaseUIComponent;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Boen
	 */
	public class BaseRenderer extends Sprite implements IRenderer 
	{
		protected var _component:BaseUIComponent;
		
		protected var _renderFlags:Number = 0;
		
		public function BaseRenderer() 
		{
			super();
		}
		
		/* INTERFACE com.boat.bwui.render.IRenderer */
		
		public function set component(comp:BaseUIComponent):void 
		{
			_component = comp;
		}
		
		public function get component():BaseUIComponent
		{
			return _component;
		}
		
		public function setRenderFlag(renderFlag:Number):void
		{			
			_renderFlags |= renderFlag;
			RenderablePool.instance.addToRenderingPool(_component);
		}
		
		public function getRenderFlags():Number
		{
			return _renderFlags;
		}
		
		protected function removeRenderFlag(renderFlag:Number):Number
		{
			if ((_renderFlags & renderFlag) != 0)
			{
				_renderFlags ^= renderFlag;
				return renderFlag;
			}
			return 0;
		}
		
		protected function canRenderProp(flag:Number):Boolean
		{
			return (_renderFlags & RenderFlag.all) != 0 || (_renderFlags & flag) != 0;
		}
		
		public function render():void 
		{
			if (canRenderProp(RenderFlag.visible))
			{
				visible = _component.visible;
			}
			if (!visible)
			{
				return;
			}
			render_impl();
			_renderFlags = 0;
		}
		
		protected function render_impl():void
		{
			
		}
		
		protected function callSuperRenderImplExcludeSomeFlags(...flags):void
		{
			if (!(this is BaseRenderer))
			{
				//super
			}
		}
		
		public function dispose():void
		{
			_component = null;
			_renderFlags = 0;
		}
		
	}

}