package com.boat.bwui.components 
{
	import com.boat.bwui.mgr.UIComponentManager;
	import com.boat.bwui.render.BaseRenderer;
	import com.boat.bwui.render.IRenderer;
	import com.boat.bwui.render.RenderFlag;
	import com.boat.bwui.utils.ClassUtils;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseUIComponent extends EventDispatcher 
	{
		protected var _parent:BaseUISheet;
		
		protected var _name:String;
		protected var _x:Number;
		protected var _y:Number;
		protected var _width:Number;
		protected var _height:Number;
		protected var _enabled:Boolean;
		
		protected var _renderer:IRenderer;
		
		public function BaseUIComponent(nm:String) 
		{
			super(this);
			_name = nm;
			_renderer = new BaseRenderer();
			_renderer.setComponent(this);
			UIComponentManager.instance.addComponent(this);
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
			setRenderInfo(RenderFlag.width);
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
			setRenderInfo(RenderFlag.height);
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
			setRenderInfo(RenderFlag.x);
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
			setRenderInfo(RenderFlag.y);
		}
		
		public function setSize(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}
		
		public function move(px:Number, py:Number):void
		{
			x = px;
			y = py;
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			setRenderInfo(RenderFlag.enabled);
		}
		
		public function get parent():BaseUISheet
		{
			return _parent;
		}
		
		internal function setParent(sheet:BaseUISheet):void
		{
			_parent = sheet;
		}
		
		public function addTo(parent:BaseUISheet):void
		{
			if (parent)
			{
				parent.addChild(this);
			}
		}
		
		public function addToAt(parent:BaseUISheet, index:int):void
		{
			if (parent)
			{
				parent.addChildAt(this, index);
			}
		}
		
		public function setRenderer(renderer:IRenderer):void
		{
			if (_renderer)
			{
				_renderer.dispose();
			}
			_renderer = renderer;
			if (_renderer)
			{
				_renderer.setComponent(this);
			}
		}
		
		public function getRenderer():IRenderer
		{
			return _renderer;
		}
		
		protected function setRenderInfo(renderFlag:Number):void
		{
			if (_renderer)
			{
				_renderer.setRenderInfo(renderFlag);
			}
		}
		
		override public function toString():String 
		{
			return "[" + ClassUtils.getOnlyClassName(this) + " name=" + name + "]";
		}
	}

}