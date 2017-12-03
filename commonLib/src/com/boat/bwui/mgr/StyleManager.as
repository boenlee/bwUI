package com.boat.bwui.mgr 
{
	import com.boat.bwui.style.IStyleSet;
	/**
	 * ...
	 * @author 
	 */
	public class StyleManager 
	{
		private static var mInstance:StyleManager;
		
		public function StyleManager() 
		{
			
		}
		
		public static function get instance():StyleManager
		{
			if (!mInstance) {
				mInstance = new StyleManager();
			}
			return mInstance;
		}
		
		public function getDefaultStyleSetter(compClassName:String):IStyleSet
		{
			return null;
		}
	}

}