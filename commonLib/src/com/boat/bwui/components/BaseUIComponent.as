package com.boat.bwui.components 
{
	import com.boat.bwui.mgr.UIComponentManager;
	import com.boat.bwui.render.BaseRenderer;
	import com.boat.bwui.render.IRenderer;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseUIComponent extends EventDispatcher 
	{
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
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
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
		
		public function get enabled():Number 
		{
			return _enabled;
		}
		
		public function set enabled(value:Number):void 
		{
			_enabled = value;
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
	}

}