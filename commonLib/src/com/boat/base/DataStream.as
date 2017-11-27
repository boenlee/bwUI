package com.boat.base
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class DataStream
	{
		public static function writeUint(stream:ByteArray,data:uint):void
		{
			var ptr:int = stream.position+4;
			stream.writeUnsignedInt(data);
			stream.position	= ptr
		}
		
		public static function writeInt(stream:ByteArray,data:int):void
		{
			var ptr:int = stream.position + 4;
			stream.writeUnsignedInt(data);
			stream.position	= ptr
		}
		
		public static function writeString(stream:ByteArray,data:String,size:int):void
		{
			var ptr:int = stream.position + size;
			var tmp:String = data;
			if(data.length > size) {
				tmp = data.substr(0,size);
			}			
			stream.writeMultiByte(tmp, "utf-8");
			stream.length = ptr;
			stream.position = ptr;
		}
		
		public static function writeString1(stream:ByteArray,data:String ,size:int):void
		{
			var ptr:int = stream.position + size;
			var tmp:String = data;
			if(data.length > size) {
				tmp = data.substr(0,size);
			}
			stream.writeMultiByte(tmp,"gb2312");
			stream.length = ptr;
			stream.position = ptr;
		}
		
		public static function writeByte(stream:ByteArray,data:int):void
		{
			var ptr:int = stream.position + 1;
			stream.writeByte(data);
			stream.position = ptr;
			//tester
//			stream.position = ptr-1;
//			var tmp:uint = stream.readUnsignedByte();
//			trace(tmp);
		}
		
		public static function writeFloat(stream:ByteArray,data:Number):void	
		{
			var ptr:int= stream.position + 4;
			stream.writeFloat(data);
			stream.position = ptr;
		}
		
		public static function writeBoolean(stream:ByteArray,data:Boolean):void
		{
			var ptr:int = stream.position + 1;
			stream.writeBoolean(data);
			stream.position = ptr;
		}
		
		public static function writeVarString(stream:ByteArray, data:String, codeset:String = "utf-8"):void {
			var tempBa:ByteArray = new ByteArray();
			tempBa.endian = Endian.LITTLE_ENDIAN;
			tempBa.writeMultiByte(data, codeset);
			var len:uint = tempBa.length;
			stream.writeShort(len);
			stream.writeMultiByte(data, codeset);
		}
		
		public static function writeVarStringByProjType(stream:ByteArray, data:String, projType:int, maxLen:uint, codeset:String = "utf-8"):void {
			var str:String = data;
			if (projType == ProjType.PROJ_TYPE_SA) {
				str = str.substr(0, maxLen);
			}
			writeVarString(stream, str, codeset);
		}
	}
}