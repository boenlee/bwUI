package com.boat.base {
	import com.boat.utils.FileTools;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;	
	
	/**
	 * 	Boen
	 * 	@author 
	 * 
	 * 	InvokeEvent默认参数：
	 * 	@param:String	 资源文件夹		m_hasSource 决定是否存在
		@param:String	 保存文件夹		m_hasSave 决定是否存在
		@param:String	 配置文件		m_hasConfigFile 决定是否存在
		@param:Boolean	 是否自动开始
		@param:Boolean	 是否处理完毕自动关闭
		@param:Boolean	 是否处理完毕自动保存Log
		@param:Boolean	 是否遇到错误中断
	 */
	public class ToolsBaseView extends ToolsBaseUI 
	{
		private var m_invokePath:String = "";
		protected var m_sourceDir:String = "";
		protected var m_saveDir:String = "";
		protected var m_configPath:String = "";
		
		protected var m_autoStart:Boolean = false;
		protected var m_autoClose:Boolean = false;
		protected var m_autoSaveLog:Boolean = false;
		protected var m_breakWhenErr:Boolean = true;
		
		protected var m_defaultSaveFolderName:String = "__ExcutedFiles";
		
		protected var m_logSaveDir:String = "Log";
		protected var m_logFileName:String = "__log.txt";
		protected var m_errLogFileName:String = "__errLog.txt";
		
		protected var m_logArr:Array = [];
		protected var m_errLogArr:Array = [];
		protected var m_errCount:uint;
		protected var m_meetErr:Boolean = false;
		
		protected var m_inProcess:Boolean = false;
		protected var m_isBreak:Boolean = false;
		protected var m_isStopped:Boolean = false;
		
		protected var m_totalExcuteCount:uint;
		protected var m_timeoutID:uint = 0;
		protected var m_excuteFileList:Array;
		
		protected var m_autoContinueExcute:Boolean = true;
		
		private var m_logHtmlStr:String = "";
		
		public function ToolsBaseView(hasConfigFile:Boolean = false) 
		{
			m_hasConfigFile = hasConfigFile;
		}
		
		override protected function initViewData():void
		{
			clearLog();
			refreshController();
			setProcessStatusTxt("");
			init();
		}
		
		protected function init():void {
			
		}
		
		protected function getLogStr(logArr:Array):String {
			var str:String = logArr.join("\r\n");
			var now:Date = new Date();
			str = "最后记录时间：" + now.toLocaleString() + "\r\n" + str;
			if (m_errCount > 0) {
				str = "错误数量：" + m_errCount + "\r\n" + str;
			}
			return str;
		}
		
		protected function getLogDir():String {
			return m_saveDir + File.separator + m_logSaveDir;
		}
		
		protected function log(str:*= "", color:String = ""):void 
		{
			//trace(str.toString());
			if (color == "")
			{
				m_logHtmlStr += str + "\n";
			}
			else
			{
				m_logHtmlStr += "<font color='#" + color + "'>" + str + "</font>\n";
			}
			
			//m_logSbTxt.appendText(str.toString() + "\n");
			m_logSbTxt.htmlText = m_logHtmlStr;
			m_logArr.push(str.toString());
		}
		
		protected function saveLog():void {
			if (m_saveDir == "") {
				log("未选择保存路径");
				return;
			}
			FileTools.saveTxtFile(getLogStr(m_logArr), getLogDir() + File.separator + m_logFileName);
		}
		
		protected function logErr(str:*= "", isErr:Boolean = true):void {
			log(str, "FF0000");
			m_errLogSbTxt.appendText(str.toString() + "\n");
			m_errLogArr.push(str.toString());
			if (isErr) {
				m_errCount++;
				m_meetErr = true;
			}
			m_errTxt.text = "错误：" + m_errCount;
		}
		
		protected function saveErrLog():void {
			if (m_saveDir == "") {
				log("未选择保存路径");
				return;
			}
			if (m_errCount > 0) {
				FileTools.saveTxtFile(getLogStr(m_errLogArr), getLogDir() + File.separator + m_errLogFileName);
			}else {
				/*var f:File = new File(getLogDir() + "/" + m_errLogFileName);
				if (f.exists) {
					f.deleteFile();
				}*/
			}
		}
		
		protected function saveAllLogs():void {
			if (m_saveDir == "") {
				log("未选择保存路径");
				return;
			}
			saveLog();
			saveErrLog();
		}
		
		protected function clearLog():void {
			m_errCount = 0;
			m_errTxt.text = "";
			m_errLogSbTxt.text = "";
			m_errLogArr.splice(0);
			
			m_logHtmlStr = "";
			m_logSbTxt.text = "";
			m_logArr.splice(0);
		}
		
		final protected function getCrtExcuteIndex():uint {
			if (m_excuteFileList) {
				return m_totalExcuteCount - m_excuteFileList.length + 1;
			}
			return 1;
		}
		
		protected function refreshProcessTxt():void {
			
			var crtIndex:uint = getCrtExcuteIndex();
			m_processTxt.text = "进度：" + crtIndex + " / " + m_totalExcuteCount + " (" + Number(crtIndex * 100 / m_totalExcuteCount).toFixed(2) + "%)";
		}
		
		protected function setProcessStatusTxt(statusStr:String):void {
			m_processStatusTxt.text = statusStr;
		}
		
		protected function setCrtFileInfo(str:String):void {
			m_crtFileInfoTxt.text = "当前文件：" + str;
		}
		
		override protected function onInvokeEvent(e:InvokeEvent):void {
			trace("onInvokeEvent")
			m_invokePath = e.currentDirectory.nativePath;
			
			var argArr:Array = e.arguments.slice();
			if (argArr.length > 0) {
				var val:*;
				if (m_hasSource) {
					val = argArr.shift();
					if (argOk(val)) {
						setSourcePath(String(val));
					}
				}
				
				if (m_hasSave) {
					val = argArr.shift();
					if (argOk(val)) {
						setSavePath(String(val));
					}
				}
				
				if (m_hasConfigFile) {
					val = argArr.shift();
					if (argOk(val)) {
						setConfigPath(String(val));
					}
				}
				m_autoStart = Boolean(argArr.shift() == "true");
				m_autoClose = Boolean(argArr.shift() == "true");
				m_autoSaveLog = Boolean(argArr.shift() == "true");
				m_breakWhenErr = Boolean(argArr.shift() == "true");
				
				setExtendInvokeArgs(argArr);
			}
			
			m_closeWhenFinishCheck.selected = m_autoClose;
			m_autoSaveLogCheck.selected = m_autoSaveLog;
			m_breakWhenErrCheck.selected = m_breakWhenErr;
			
			initWithExtendInvokeArgs();
			
			if (m_autoStart) {
				onStartClick(null);
			}
		}
		
		final protected function argOk(val:*):Boolean {
			return val != undefined && val != null && val != "";
		}
		
		protected function setExtendInvokeArgs(argArr:Array):void {
			//example
			/*if (argArr.length > 0) {
				var val:*= argArr.shift();
				if (argOk(val)) {
					属性名 = val;
				}
			}*/
		}
		
		protected function initWithExtendInvokeArgs():void {
			//example
			//控件.属性 = 属性值;
		}
		
		protected function getConfigFileFilter():Array {
			return null;
		}
		
		override protected function onSourcePathSelClick(e:MouseEvent):void {
			var f:File = new File();
			f.browseForDirectory("选择资源文件夹");
			f.addEventListener(Event.SELECT, onSourcePathSelected);
		}
		
		override protected function onSavePathSelClick(e:MouseEvent):void {
			var f:File = new File();
			f.browseForDirectory("选择保存文件夹");
			f.addEventListener(Event.SELECT, onSavePathSelected);
		}
		
		override protected function onConfigFileSelClick(e:MouseEvent):void {
			var f:File = new File();
			f.browseForOpen("选择配置文件", getConfigFileFilter());
			f.addEventListener(Event.SELECT, onConfigFileSelected);
		}
		
		override protected function onSetDefaultSavePathClick(e:MouseEvent):void {
			setDefaultSavePath();
		}
		
		override protected function onClearConfigPathClick(e:MouseEvent):void {
			m_configPath = ""
			m_configPathTxt.text = m_configPath;
			onConfigPathSet();
		}
		
		protected function onSourcePathSelected(e:Event):void {
			setSourcePath((e.target as File).nativePath);
		}
		
		protected function onSavePathSelected(e:Event):void {
			setSavePath((e.target as File).nativePath);
		}
		
		protected function onConfigFileSelected(e:Event):void {
			setConfigPath((e.target as File).nativePath);
		}
		
		protected function setSourcePath(path:String):void {
			if (path == "-") {
				return;
			}
			m_sourceDir = FileTools.formatPath(path);
			if (m_invokePath != "") {
				m_sourceDir = new File(m_invokePath).resolvePath(m_sourceDir).nativePath;
			}
			m_sourcePathTxt.text = m_sourceDir;
		}
		
		protected function setSavePath(path:String):void {
			if (path == "-") {
				return;
			}
			m_saveDir = FileTools.formatPath(path);
			if (m_invokePath != "") {
				m_saveDir = new File(m_invokePath).resolvePath(m_saveDir).nativePath;
			}
			m_savePathTxt.text = m_saveDir;
		}
		
		protected function setDefaultSavePath():void {
			if (m_sourceDir != "") {
				setSavePath(m_sourceDir + File.separator + m_defaultSaveFolderName);
			}
		}
		
		protected function setConfigPath(path:String):void {
			if (path == "-") {
				return;
			}
			m_configPath = FileTools.formatPath(path);
			if (m_invokePath != "") {
				m_configPath = new File(m_invokePath).resolvePath(m_configPath).nativePath;
			}
			m_configPathTxt.text = m_configPath;
			onConfigPathSet();
		}
		
		protected function onConfigPathSet():void {
			
		}
		
		override protected function onStartClick(e:MouseEvent):void {
			m_isBreak = false;
			m_meetErr = false;
			if (!m_inProcess) {
				start();
			}else {
				setProcessStatusTxt("处理中");
				log("**********************  继续  **********************");
				excute();
			}
			refreshController();
		}
		
		override protected function onPauseClick(e:MouseEvent):void {
			breakProcess();
			clearTimeout(m_timeoutID);
			setProcessStatusTxt("中断");
			log("**********************  中断  **********************");
		}
		
		override protected function onStopClick(e:MouseEvent):void {
			m_inProcess = false;
			m_isBreak = false;
			m_isStopped = true;
			refreshController();
			m_excuteFileList = [];
			clearTimeout(m_timeoutID);
			setProcessStatusTxt("终止");
			log("********************** 已终止 **********************");
			log();
		}
		
		public function doStart():void {
			onStartClick(null);
		}
		
		public function doPause():void {
			onPauseClick(null);
		}
		
		public function doStop():void{
			onStopClick(null);
		}
		
		override protected function onSaveLogClick(e:MouseEvent):void {
			saveAllLogs();
		}
		
		override protected function onClearLogClick(e:MouseEvent):void {
			clearLog();
		}
		
		override protected function onCloseWhenFinishClick(e:MouseEvent):void {
			m_autoClose = m_closeWhenFinishCheck.selected;
		}
		
		override protected function onAutoSaveLogClick(e:MouseEvent):void {
			m_autoSaveLog = m_autoSaveLogCheck.selected;
		}
		
		override protected function onBreakWhenErrClick(e:MouseEvent):void {
			m_breakWhenErr = m_breakWhenErrCheck.selected;
		}
		
		override protected function onWindowClosing(e:Event):void 
		{
			e.preventDefault();
			if (m_meetErr) {
				NativeApplication.nativeApplication.exit(ToolsExitCode.ERROR);
			}else {
				NativeApplication.nativeApplication.exit(ToolsExitCode.NORMAL);
			}
		}
		
		protected function refreshController():void {
			if (m_inProcess) {
				m_stopBtn.enabled = true;
				if (m_isBreak) {
					m_startBtn.visible = true;
					m_startBtn.label = "继续处理";
					m_pauseBtn.visible = false;
				}else {
					m_startBtn.visible = false;
					m_pauseBtn.visible = true;
				}
				
			}else {
				m_startBtn.visible = true;
				m_startBtn.label = "开始处理";
				m_pauseBtn.visible = false;
				m_stopBtn.enabled = false;
			}
			if (m_hasSource) {
				m_sourcePathSelBtn.enabled = !m_inProcess;
			}
			if (m_hasSave) {
				m_savePathSelBtn.enabled = !m_inProcess;
				m_setDefaultSavePathBtn.enabled = !m_inProcess;
			}
			if (m_hasConfigFile) {
				m_configFileSelBtn.enabled = !m_inProcess;
				m_clearConfigPathBtn.enabled = !m_inProcess;
			}
		}
		
		private function start():void {
			if (!checkCanExcute()) {
				return;
			}
			
			if (m_hasSource) {
				log("@源路径：" + m_sourceDir);
			}
			if (m_hasSave) {
				log("@保存路径：" + m_saveDir);
			}
			if (m_hasSource || m_hasSave) {
				log();
			}
			
			m_inProcess = true;
			m_isStopped = false;
			
			m_excuteFileList = getExcuteList();
			if (m_excuteFileList != null) {
				m_totalExcuteCount = m_excuteFileList.length;
			}else {
				m_totalExcuteCount = 0;
			}
			
			log("文件总数：" + m_totalExcuteCount);
			
			if (m_totalExcuteCount > 0) {
				setProcessStatusTxt("处理中");
				log("**********************开始处理**********************");
				excuteStart()
				excute();
			}else {
				setProcessStatusTxt("");
				log("*****************没有文件可以处理！*****************");
				log();
				excuteFinished();
			}
		}
		
		protected function breakProcess():void {
			m_isBreak = true;
			refreshController();
		}
		
		private function checkCanExcute():Boolean {
			var f:File = new File();
			if (m_hasSource) {
				if (!m_sourceDir) {
					if (m_needSource) {
						log("请选择资源文件夹！");
						return false;
					}
				}else {
					f.nativePath = m_sourceDir;
					if (!f.exists) {
						log("资源文件夹不存在！");
						return false;
					}
				}
			}
			
			if (m_hasSave) {
				if (m_needSave && !m_saveDir) {
					log("请选择保存文件夹！");
					return false;
				}
			}
			
			if (m_hasConfigFile) {
				if (!m_configPath) {
					if (m_needConfigFile) {
						log("请选择配置文件！");
						return false;
					}
				}else {
					f.nativePath = m_configPath;
					if (!f.exists) {
						log("配置文件不存在！");
						return false;
					}
				}
			}
			if (!onCheckCanExcute()) {
				return false;
			}
			return true;
		}
		
		protected function onCheckCanExcute():Boolean {
			return true;
		}
		
		protected function excuteStart():void
		{
		}
		
		private function excute():void {
			refreshProcessTxt();
			var f:CFile = m_excuteFileList.shift();
			if (f && f.file) {
				if (f.file.exists) {
					excuteFile(f);
				}else {
					logErr("文件不存在：" + f.file.nativePath);
				}
			}
			if (m_autoContinueExcute) {
				continueExcute();
			}
		}
		
		final protected function continueExcute():void {
			if (m_excuteFileList.length == 0) {
				if (excuteEnd()) {
					finishExcution();
				}
			}else {
				if (!m_breakWhenErr || !m_meetErr) {
					if (m_inProcess && !m_isBreak) {
						clearTimeout(m_timeoutID);
						m_timeoutID = setTimeout(excute, m_excuteInterval);
					}
				}else {
					setProcessStatusTxt("报错中断");
					logErr("**********************报错中断**********************", false);
					breakProcess();
				}
			}
		}
		
		/**
		 * @return	如果返回false则需要另外调用finishExcution();
		 */
		protected function excuteEnd():Boolean {
			return true;
		}
		
		protected function finishExcution():void {
			setProcessStatusTxt("处理完毕");
			log("**********************处理完毕**********************");
			log();
			excuteFinished();
		}
		
		private function excuteFinished():void {
			m_inProcess = false;
			m_isBreak = false;
			m_excuteFileList = [];
			refreshController();
			if (m_autoSaveLog) {
				saveAllLogs();
			}
			if (!m_breakWhenErr || !m_meetErr) {
				if (m_autoClose) {
					if (m_meetErr) {
						NativeApplication.nativeApplication.exit(ToolsExitCode.ERROR);
					}else {
						NativeApplication.nativeApplication.exit(ToolsExitCode.AUTO);
					}
				}
			}
		}
		
		protected function getExcuteList():Array {
			throw new Error("setExcuteList需要重载");
		}
		
		protected function excuteFile(f:CFile):void {
			throw new Error("excuteFile需要重载");
		}
		
		final protected function getCFileList(dir:*, fileType:String, cType:*= null, extensions:String = "", findSub:Boolean = false, filter:* = null):Array {
			var list:Array;
			var cList:Array = [];
			if (dir is File) {
				if (fileType == CFile.FILE) {
					list = FileTools.getFiles(dir as File, extensions, findSub, filter);
				}else {
					list = FileTools.getFolders(dir as File, findSub, filter);
				}
			}else if (dir is String) {
				if (fileType == CFile.FILE) {
					list = FileTools.getFilesByPath(dir as String, extensions, findSub, filter);
				}else {
					list = FileTools.getFoldersByPath(dir as String, findSub, filter);
				}
			}
			if (list) {
				for (var i:int = 0; i < list.length; i++) 
				{
					cList.push(new CFile(list[i], cType));
				}
			}
			return cList;
		}
		
	}

}