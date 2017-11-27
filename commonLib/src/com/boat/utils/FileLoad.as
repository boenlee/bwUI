package com.boat.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * 
	 * @author jiangyi
	 * 
	 */	
	public class FileLoad
	{
		private static var _loader:Loader;//加载 SWF 文件或图像（JPG、PNG 或 GIF）文件
		private static var _urlLoad:URLLoader;//文本、二进制数据或 URL 编码变量的形式从 URL 下载数据
		private static var _urlDataLoader:UrlDataLoader;
		
		private static var _url:String;
		
		public static function fileLoadText(url:String,complete:Function):void
		{
			_url = url
			_urlLoad = new URLLoader();
			_urlLoad.load(new URLRequest(url));
			_urlLoad.addEventListener(IOErrorEvent.IO_ERROR,IOError);
			_urlLoad.addEventListener(Event.COMPLETE, complete);
		}
		
		public static function fileLoadXML(url:String,complete:Function,data:String = ""):void
		{
			_urlDataLoader = new UrlDataLoader();
			_urlDataLoader.load(new URLRequest(url));
			_urlDataLoader.content = data;
			_url = url
			//trace(url);
			_urlDataLoader.addEventListener(IOErrorEvent.IO_ERROR,IOError);
			_urlDataLoader.addEventListener(Event.COMPLETE, complete);
		}
		
		public static function fileLoadImage(url:String,complete:Function):void
		{
			_loader = new Loader();
			_loader.load(new URLRequest(url));
			_url = url
			//trace(url);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,IOError);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
		}
		
		public static function IOError(e:IOErrorEvent):void{
			trace("文件加载出错= "+_url);
		}
		
	}
}