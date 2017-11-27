package com.boat.utils {
	import com.adobe.images.PNGEncoder;
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * ...
	 * @author 
	 */
	public class FileTools 
	{
		public static function formatPath(path:String, separator:String = ""):String {
			if (path) {
				separator = separator || File.separator;
				if (separator == "/") {
					path = path.replace(/\\/g, separator);
				}else {
					path = path.replace(/\//g, separator);
				}
				return path;
			}
			return "";
		}
		
		public static function formatDirPath(path:String, separator:String = ""):String {
			if (path == "") {
				return "";
			}
			separator = separator || File.separator;
			return formatPath(path, separator).replace(new RegExp("\\" + separator + "$"), "") + separator;
		}
		
		public static function trimDirPathEndSeparator(path:String, separator:String = ""):String
		{
			if (path == "") {
				return "";
			}
			return path.replace(/\\$/, "").replace(/\/$/, "");
		}
		
		public static function formatRelativePath(path:String, separator:String = ""):String {
			separator = separator || File.separator;
			return formatPath(path, separator).replace(new RegExp("^\\" + separator), "");
		}
		
		public static function getFileNameByPath(path:String):String {
			return path.replace(/^.*[\\\/]/, "");
		}
		
		public static function getDirNameByPath(path:String):String {
			var reg:RegExp =/^(.*[\\\/]).*$/;
			if (path.search(reg) ==-1) {
				return "";
			}
			return path.replace(reg, "$1").replace(/\\$/, "").replace(/\/$/, "");
		}
		
		public static function getFileExt(fileName:String):String {
			var arr:Array = fileName.split(".");
			return arr.pop();
		}
		
		public static function getPureFileName(fileName:String):String {
			var arr:Array = fileName.split(".");
			if (arr.length > 1) {
				arr.pop();
				return arr.join(".");
			}
			return fileName;
		}
		
		public static function resolvePath(basePath:String, relativePath:String):String {
			var basefile:File = getLegalPathFile(basePath);
			if (!basefile) {
				return relativePath;
			}
			var f:File = basefile.resolvePath(relativePath);
			return f.nativePath;
		}
		
		public static function resolvePathToAppDir(relativePath:String):String {
			if (!relativePath) {
				return "";
			}
			return resolvePath(File.applicationDirectory.nativePath, relativePath);
		}
		
		public static function validateFilePath(path:String):Boolean {
			var f:File = new File();
			try {
				f.nativePath = path;
			}catch (e:Error) {
				return false;
			}
			return true;
		}
		
		public static function getLegalPathFile(path:String):File {
			var f:File = new File();
			try {
				f.nativePath = path;
			}catch (e:Error) {
				return null;
			}
			return f;
		}
		
		public static function getLegalURL(url:String):File {
			var f:File = new File();
			try {
				f.url = url;
			}catch (e:Error) {
				return null;
			}
			return f;
		}
		
		public static function createDirection(dirPath:String):void {
			var f:File = getLegalPathFile(dirPath);
			if (f) {
				f.createDirectory();
			}
		}
		
		public static function copyFile(sourcePath:String, targetPath:String, overwrite:Boolean = false):Boolean {
			var sf:File = getLegalPathFile(sourcePath);
			var tf:File = getLegalPathFile(targetPath);
			if (sf && tf && sf.exists) {
				try {
					sf.copyTo(tf, overwrite);
				}catch (e:Error) {
					return false;
				}
				return true;
			}
			return false;
		}
		
		public static function deleteFile(path:String, onErr:Function = null, deleteDirectoryContents:Boolean = true):Boolean {
			var f:File = getLegalPathFile(path);
			if (f) {
				try {
					if (f.isDirectory) {
						f.deleteDirectory(deleteDirectoryContents);
					}else {
						f.deleteFile();
					}
				}catch (e:Error) {
					if (onErr != null) {
						onErr(e);
					}
					return false;
				}
				return true;
			}
			return false;
		}
		
		public static function existFile(path:String):Boolean
		{
			var f:File = getLegalPathFile(path);
			if (f == null || !f.exists) {
				return false;
			}
			return true;
		}
		
		//运行时如果报错找不到 PNGEncoderOptions 或 JPEGEncoderOptions 请在编译参数中加入-swf-version=x (x>=16)
		public static function savePng(bmd:BitmapData, fileName:String, fastCompression:Boolean = false):void
		{
			/*var bytes:ByteArray = PNGEncoder.encode(bmd);
			saveBytesFile(bytes, fileName);*/
			if (!bmd) {
				return;
			}
			var bytes:ByteArray = new ByteArray();
			bmd.encode(new Rectangle(0, 0, bmd.width, bmd.height), new PNGEncoderOptions(fastCompression), bytes);
			saveBytesFile(bytes, fileName);
		}
		
		//使用这种方法生成jpg图片比用com.adobe.images.JPGEncoder快n倍  应该是底层实现的原因  JPGEncoder是as实现
		public static function saveJpg(bmd:BitmapData, fileName:String, quality:uint = 80):void {
			if (!bmd) {
				return;
			}
			var bytes:ByteArray = new ByteArray();
			bmd.encode(new Rectangle(0, 0, bmd.width, bmd.height), new JPEGEncoderOptions(quality), bytes);
			saveBytesFile(bytes, fileName);
		}
		
		public static function saveBytesFile(bytes:ByteArray, fileName:String):void
		{
			var f:File = getLegalPathFile(fileName);
			if (f) {
				var fs:FileStream = new FileStream();
				fs.open(f, FileMode.WRITE);
				fs.position = 0;
				fs.writeBytes(bytes);
				fs.close();
			}
		}
		
		public static function saveTxtFile(txt:String, fileName:String):void
		{
			var f:File = getLegalPathFile(fileName);
			if (f) {
				var fs:FileStream = new FileStream();
				fs.open(f, FileMode.WRITE);
				fs.position = 0;
				fs.writeUTFBytes(txt);
				fs.close();
			}
		}
		
		//这个函数写砸了  以后用到重写  异步打开之后马上就关闭明显傻逼的很 应该侦听事件发生后再关闭  具体事件查看as3帮助手册
		public static function saveAsyncTxtFile(txt:String, fileName:String):void
		{
			var f:File = getLegalPathFile(fileName);
			if (f) {
				var fs:FileStream = new FileStream();
				fs.openAsync(f, FileMode.WRITE);
				fs.position = 0;
				fs.writeUTFBytes(txt);
				fs.close();
			}
		}
		
		public static function appendTxtFile(txt:String, fileName:String):void
		{
			var f:File = getLegalPathFile(fileName);
			if (f) {
				var fs:FileStream = new FileStream();
				fs.open(f, FileMode.APPEND);
				fs.writeUTFBytes(txt);
				fs.close();
			}
		}
		
		public static function readBytesFile(f:File, endian:String = ""):ByteArray
		{
			if (endian == "") {
				endian = Endian.BIG_ENDIAN;
			}
			var bytes:ByteArray;
			if (f != null && f.exists) {
				bytes = new ByteArray();
				var fileStream:FileStream = new FileStream();
				fileStream.open(f, FileMode.READ);
				fileStream.readBytes(bytes, 0, fileStream.bytesAvailable);
				fileStream.close();
				
				bytes.endian = endian;
			}			
			return bytes;
		}
		
		public static function readTxtFile(f:File, chrSet:String = "utf-8"):String
		{
			if (f == null || !f.exists) {
				return "";
			}
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			var txt:String = fs.readMultiByte(fs.bytesAvailable, chrSet);
			fs.close();
			return txt;
		}
		
		/**
		 * edit jiangyi
		 * @param f
		 * @return 
		 * 
		 */		
		public static function readUTFTxtFile(f:File):String
		{
			if (f == null || !f.exists) {
				return "";
			}
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			var txt:String = fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			return txt;
		}
		
		public static function readBytesFileByPath(path:String, endian:String = ""):ByteArray {
			return readBytesFile(getLegalPathFile(path), endian);
		}
		
		public static function readTxtFileByPath(path:String, chrSet:String = "utf-8"):String {
			return readTxtFile(getLegalPathFile(path), chrSet);
		}
		
		/**
		 *edit jiangyi 
		 * @param path
		 * @return 
		 * 
		 */		
		public static function readUTFTxtFileByPath(path:String):String {
			return readUTFTxtFile(getLegalPathFile(path));
		}
		
		public static function getFilesByPath(path:String, extensions:String = "", findSub:Boolean = false, filter:* = null):Array {
			return getFiles(getLegalPathFile(path), extensions, findSub, filter);
		}
		
		public static function getFiles(dir:File, extensions:String = "", findSub:Boolean = false, filter:* = null):Array {
			var arr:Array = [];
			var extArr:Array;
			if (extensions) {
				extensions = extensions.replace(/\s/g, "");
				if (extensions != "") {
					extensions = extensions.toLowerCase();
					extArr = extensions.split(",");
				}
			}
			if (dir != null && dir.exists) {
				var fileList:Array = dir.getDirectoryListing();
				var f:File;
				for (var i:int = 0; i < fileList.length; i++) 
				{
					f = fileList[i];
					if (f.isDirectory && findSub) {
						if (doFileFilter(filter, f)) {
							arr = arr.concat(getFiles(f, extensions, findSub, filter));
						}
					}else {
						if (extArr == null || extArr.indexOf(FileTools.getFileExt(f.name.toLowerCase())) != -1) {
							if (doFileFilter(filter, f)) {
								arr.push(f);
							}
						}
					}
				}
			}
			return arr;
		}
		
		public static function getFoldersByPath(path:String, findSub:Boolean = false, filter:* = null):Array {
			return getFolders(getLegalPathFile(path), findSub, filter);
		}
		
		public static function getFolders(dir:File, findSub:Boolean = false, filter:* = null):Array {
			var arr:Array = [];
			if (dir != null && dir.exists) {
				var fileList:Array = dir.getDirectoryListing();
				var f:File;
				for (var i:int = 0; i < fileList.length; i++) 
				{
					f = fileList[i];
					if (f.isDirectory) {
						if (doFileFilter(filter, f)) {
							arr.push(f);
							if (findSub) {
								arr = arr.concat(getFolders(f, findSub, filter));
							}
						}
					}
				}
			}
			return arr;
		}
		
		private static function doFileFilter(filter:*, f:File):Boolean {
			
			if (filter) {
				if (filter is String)
				{
					if (filter == f.name)
					{
						return false;
					}
				}
				else if (filter is Array)
				{
					if (filter.indexOf(f.name) != -1) {
						return false;
					}
				}
				else if (filter is Function)
				{
					return filter(f);
				}
				else if (filter is FTFileFilter)
				{
					var fileFilter:FTFileFilter = filter as FTFileFilter;
					if (fileFilter.filterFunc != null)
					{
						var args:Array = [f].concat(fileFilter.filterFuncArgs || []);
						return fileFilter.filterFunc.apply(null, args);
					}
				}
			}
			
			return true;
		}
	}

}