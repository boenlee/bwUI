package com.boat.utils 
{
	import com.boat.utils.FileTools;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author 
	 */
	public class ExternalProgramUtils 
	{
		
		public static function callExternalProgram(programName:String, args:Array):NativeProcess
		{
			var excuteFile:File = new File(FileTools.resolvePathToAppDir(programName));
			var argsVec:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < args.length; i++) 
			{
				argsVec[i] = String(args[i]);
			}
			
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable = excuteFile;
			nativeProcessStartupInfo.arguments = argsVec;
			
			var process:NativeProcess = new NativeProcess();
			process.start(nativeProcessStartupInfo);
			return process;
		}
	}

}