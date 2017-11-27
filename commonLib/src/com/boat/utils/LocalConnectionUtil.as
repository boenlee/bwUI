package com.boat.utils 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;

	/**
	 * 两个SWF连接
	 * @author jiangyi
	 * 
	 */	
	public class LocalConnectionUtil
	{
		private var conn:LocalConnection;
		
		private var state:Function;
		private var error:Function;
		private var handle:Function;
		
		public function LocalConnectionUtil(connectName:String,state:Function,error:Function,handle:Function)
		{
			this.state = state;
			this.error = error;
			this.handle = handle;
			conn = new LocalConnection();
			conn.allowDomain("*");
			conn.addEventListener(StatusEvent.STATUS, onStatus);
			conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onAsyncError);
			conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			
			try {
				conn.client = this;
				conn.connect(connectName);
			} catch (error:ArgumentError) {
				/*if(conn){
					conn.connect(connectName);
				}*/
				trace("Can't connect...the connection name is already being used by another SWF");
			}
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			if(error != null){
				error("Error1")
			}
		}
		
		protected function onAsyncError(event:AsyncErrorEvent):void
		{
			if(error != null){
				error("Error2")
			}
		}
		
		private function onStatus(event:StatusEvent):void {
			switch (event.level) {
				case "status":
					state(true);
					break;
				case "error":
					state(false);
					break;
			}
		}
		
		/**
		 * 
		 * @param targetHost  需要连接的应用程序
		 * @param method 应用程序响应函数
		 * @param content     发送的内容
		 * @param fromHost    哪个应用发送过来的
		 * 
		 */		
		public function sendMessage(targetHost:String,method:String,content:String,fromHost:String = "",operate:String = ""):void{
			conn.send(targetHost, method, content,fromHost,operate);
		}
		
		public function receiveMessage(msg:String = "",hostAdd:String = "",operate:String = ""):void{
			if(handle != null){
				handle(msg,hostAdd,operate);
			}
		}
	}
}