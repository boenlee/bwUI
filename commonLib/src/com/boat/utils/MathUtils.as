package com.boat.utils
{
	/**
	 * ...
	 * @author 
	 */
	public class MathUtils 
	{
		public static function restrictNumberInScope(num:Number, min:Number, max:Number):Number {
			return Math.max(min, Math.min(max, num));
		}
	}

}