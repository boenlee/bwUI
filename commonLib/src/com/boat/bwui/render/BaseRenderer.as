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
		
		protected var _renderFlags:Number = RenderFlag.all;
		protected var _invalidRenderFlags:Number = 0;
		
		public function BaseRenderer() 
		{
			super();
		}
		
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
		
		/*protected function removeRenderFlags(...flags):Number
		{
			var removedFlags:Number = 0;
			var flag:Number;
			for (var i:int = 0; i < flags.length; i++) 
			{
				flag = flags[i];
				if ((_renderFlags & flag) != 0)
				{
					_renderFlags ^= flag;
					removedFlags |= flag;
				}
			}
			
			return removedFlags;
		}*/
		
		protected function validateRenderFlag(flag:Number):Boolean
		{			
			return (_renderFlags & (RenderFlag.all | flag)) != 0 && (_invalidRenderFlags & flag) == 0;
		}
		
		public function render():void 
		{
			//print("render")
			
			//print(_renderFlags);
			
			if (validateRenderFlag(RenderFlag.visible))
			{
				visible = _component.visible;
			}
			if (!_component.displayVisible && !_component.isRenderInvisible)
			{
				return;
			}
			render_impl();
			_renderFlags = 0;
			_invalidRenderFlags = 0;
		}
		
		protected function render_impl():void
		{
			
		}
		
		protected function callSuperRenderImplWithInvalidFlags(superRenderImpl:Function, invalidFlags:Number):void
		{
			_invalidRenderFlags = invalidFlags;
			superRenderImpl();
			_invalidRenderFlags = 0;
		}
		
		public function dispose():void
		{
			_component = null;
			_renderFlags = 0;
		}
		
		protected function print(...strs):void
		{
			trace.apply(null, [_component.name].concat(strs));
		}
		
		protected function printProp(propName:String):void
		{
			if (hasOwnProperty(propName))
			{
				trace(_component.name, propName + "=" + this[propName]);
			}
			else
			{
				trace(_component.name, " 没有属性" + propName);
			}
		}
		
	}

}