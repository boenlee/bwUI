package com.boat.utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class FTFileFilter 
	{
		public var filterFunc:Function;
		public var filterFuncArgs:Array;
		
		public function FTFileFilter(func:Function, args:Array = null) 
		{
			filterFunc = func;
			filterFuncArgs = args;
		}
		
	}

}