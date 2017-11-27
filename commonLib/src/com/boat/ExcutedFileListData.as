package com.boat 
{
	/**
	 * ...
	 * @author 
	 */
	public class ExcutedFileListData 
	{
		private var mRootPath:String;
		private var mFilePathList:Array;
		
		public function ExcutedFileListData() 
		{
			reset();
		}
		
		public function setRootPath(path:String):void {
			mRootPath = path;
		}
		
		public function getRootPath():String {
			return mRootPath;
		}
		
		public function addFilePath(path:String):void {
			mFilePathList.push(path);
		}
		
		public function reset():void {
			mRootPath = null;
			mFilePathList = [];
		}
		
		public function getXML():XML {
			var xml:XML =<root><queue rootPath={mRootPath||""}/></root>;
			var listNode:XML = xml.queue[0];
			for (var i:int = 0; i < mFilePathList.length; i++) 
			{
				listNode.appendChild(<item path={mFilePathList[i]}/>);
			}
			return xml;
		}
	}

}