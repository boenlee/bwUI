package com.boat.bwui.style.frames 
{
	import com.boat.bwui.style.IStyleFrame;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author boen
	 */
	public class BaseStyleFrame implements IStyleFrame 
	{
		protected var _redrawOnResize:Boolean;
		
		public function BaseStyleFrame(rdrwOnRsz:Boolean = false) 
		{
			_redrawOnResize = rdrwOnRsz;
		}
		
		/* INTERFACE com.boat.bwui.style.IStyleFrame */
		
		public function get redrawOnResize():Boolean 
		{
			return _redrawOnResize;
		}
		
		public function set redrawOnResize(value:Boolean):void 
		{
			_redrawOnResize = value;
		}
		
		public function setStyleTo(sprite:Sprite, width:Number, height:Number):void 
		{
			
		}
		
	}

}