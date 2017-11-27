package com.boat.utils 
{
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author 
	 */
	public class ClassUtils 
	{
		public static function declareRuntimeClass(...classes):void
		{
			//do nothing
		}
		
		public static function getClassByName(className:String):Class
		{
			var cls:Class;
			try
			{
				cls = getDefinitionByName(className) as Class;
			}
			catch (e:Error)
			{
				
			}
			return cls;
		}
	}

}