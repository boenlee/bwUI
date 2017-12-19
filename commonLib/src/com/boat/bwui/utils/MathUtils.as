package com.boat.bwui.utils 
{
	/**
	 * ...
	 * @author Boen
	 */
	public class MathUtils 
	{
		
		public static function angleToRadian(angle:Number):Number
		{
			return angle * Math.PI / 180;
		}
		
		public static function radianToAngle(radian:Number):Number
		{
			return radian * 180 / Math.PI;
		}
		
	}

}