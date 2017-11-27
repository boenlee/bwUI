package com.boat.comp.ui 
{
	import com.boat.comp.mgr.DirectoryStructureManager;
	import fl.controls.ComboBox;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.text.TextFormat;
	
	/**
	 * use for AIR
	 * @author boen
	 */
	public class DirectoryCascadingMenu extends Sprite 
	{
		private var _defaultSelectIndex:int;
		
		private var _cbbList:Array;
		private var _cbbStorage:Array;
		
		private var _currentPath:String;
		private var _isShowAll:Boolean;
		
		public function DirectoryCascadingMenu(defaultSelIdx:int = 1) 
		{
			_defaultSelectIndex = defaultSelIdx;
		}
		
		public function init():void
		{
			_cbbList = [];
			_cbbStorage = [];
			
			setCbbDataByIndex(0, DirectoryStructureManager.getInstance().getLevelFirstDirs());
			checkShowAll();
		}
		
		private function setCbbDataByIndex(index:int, dirList:Array):void
		{
			if (!dirList || dirList.length == 0) {
				return;
			}
			
			var cbb:ComboBox = addCbb(index);
			cbb.addItem( { label:"--不含子文件夹--", data:0 } );
			cbb.addItem( { label:"--全部--", data:1 } );
			
			var dir:File;
			for (var i:int = 0; i < dirList.length; i++) 
			{
				dir = dirList[i];
				cbb.addItem( { label:dir.name, data:dir.nativePath } );
			}
			cbb.selectedIndex = _defaultSelectIndex;
			cbb.drawNow();
		}
		
		private function addCbb(index:int):ComboBox
		{
			var cbb:ComboBox = _cbbStorage.pop();
			if (!cbb) {
				cbb = createCbb(160, 22);
			}
			cbb.x = index * 165;
			cbb.y = 0;
			_cbbList[index] = cbb;
			cbb.addEventListener(Event.CHANGE, onCbbChange);
			addChild(cbb);
			return cbb;
		}
		
		private function createCbb(pw:Number, ph:Number):ComboBox
		{
			var cbb:ComboBox = new ComboBox();
			cbb.width = pw;
			cbb.height = ph;
			cbb.rowCount = 10;
			var tfm:TextFormat = new TextFormat();
			tfm.size = 12;
			tfm.indent = 3;
			cbb.textField.setStyle("textFormat", tfm);
			var disabledTfm:TextFormat = new TextFormat();
			disabledTfm.size = 12;
			disabledTfm.color = 0x999999;
			disabledTfm.indent = 3;
			cbb.textField.setStyle("disabledTextFormat", disabledTfm);
			cbb.setStyle("textPadding", 1);
			cbb.focusEnabled = false;
			return cbb;
		}
		
		private function clearCbbAfterIndex(index:int):void {
			var cbb:ComboBox;
			while (_cbbList.length > index + 1) {
				cbb = _cbbList.pop();
				cbb.removeEventListener(Event.CHANGE, onCbbChange);
				cbb.removeAll();
				_cbbStorage.unshift(cbb);
				if (contains(cbb)) {
					removeChild(cbb);
				}
			}
		}
		
		private function onCbbChange(e:Event):void 
		{
			var cbb:ComboBox = e.target as ComboBox;
			var index:int = _cbbList.indexOf(cbb);
			if (index >= 0) {
				clearCbbAfterIndex(index);
				if (cbb.selectedIndex <= 1) {
					if (index == 0) {
						_currentPath = null;	
					}else {
						var preCbb:ComboBox = _cbbList[index - 1];
						if (preCbb) {
							_currentPath = preCbb.selectedItem.data;
						}
					}
					if (cbb.selectedIndex == 1) {
						_isShowAll = true;
					}
				}else {
					_currentPath = cbb.selectedItem.data;
					setCbbDataByIndex(index + 1, DirectoryStructureManager.getInstance().getSubDirsByPath(_currentPath));
				}
				checkShowAll();
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		private function checkShowAll():void
		{
			var cbb:ComboBox = _cbbList[_cbbList.length - 1];
			if (cbb) {
				_isShowAll = (cbb.selectedItem.data == 1);
			}else {
				_isShowAll = false;
			}
		}
		
		public function get currentPath():String 
		{
			return _currentPath;
		}
		
		public function get isShowAll():Boolean 
		{
			return _isShowAll;
		}
		
		public function set defaultSelectIndex(value:int):void 
		{
			_defaultSelectIndex = value;
		}
		
	}

}