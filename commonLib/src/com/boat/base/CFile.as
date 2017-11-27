package com.boat.base 
{
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author 
	 */
	public class CFile
	{
		public static const DIR:String = "dir";
		public static const FILE:String = "file";
		
		private var _file:File;
		
		private var _cType:*;
		
		public function CFile(f:File = null, t:* = null)
		{
			_file = f;
			_cType = t;
		}
		
		public function get cType():* 
		{
			return _cType;
		}
		
		public function set cType(value:*):void 
		{
			_cType = value;
		}
		
		public function get ext():String {
			return _file.extension.toLowerCase();
		}
		
		public function get file():File 
		{
			return _file;
		}
		
		public function set file(value:File):void 
		{
			_file = value;
		}
		
		public function toString():String 
		{
			return "[CFile cType=" + cType + " ext=" + ext + " file=" + file + " file.name=" + file.name + "]";
		}
	}

}