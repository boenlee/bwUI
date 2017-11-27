package com.boat.comp.mgr 
{
	import com.boat.utils.FileTools;
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	/**
	 * use for AIR
	 * @author boen
	 */
	public class DirectoryStructureManager 
	{
		private static var _instance:DirectoryStructureManager;
		
		private var _dirHash:Dictionary;
		
		private var _levelFirstDirs:Array;
		
		public function DirectoryStructureManager() 
		{
			_dirHash = new Dictionary();
		}
		
		public static function init():void
		{
			_instance = new DirectoryStructureManager();
		}
		
		public static function getInstance():DirectoryStructureManager
		{
			return _instance;
		}
		
		public function setLevelFirstDirs(dirs:Array):void
		{
			_levelFirstDirs = [];
			var f:File;
			for (var i:int = 0; i < dirs.length; i++) 
			{
				f = FileTools.getLegalPathFile(dirs[i]);
				if (f) {
					_levelFirstDirs.push(f);
				}
			}
		}
		
		public function getLevelFirstDirs():Array
		{
			return _levelFirstDirs;
		}
		
		public function getSubDirsByPath(path:String):Array
		{
			var arr:Array = _dirHash[path];
			if (!arr) {
				arr = FileTools.getFoldersByPath(path);
				_dirHash[path] = arr;
			}
			return arr;
		}
	}

}