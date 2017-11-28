package com.boat.bwui.utils 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Boen
	 */
	public class ClassUtils 
	{
		
		public static function getOnlyClassName(value:*):String
		{
			var clsName:String = getQualifiedClassName(value);
			return clsName.replace(/^.+::(.+)$/, "$1");
		}
		
	}

}