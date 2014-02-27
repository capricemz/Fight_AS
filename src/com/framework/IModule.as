package com.framework
{
	/**
	 * 模块接口
	 * @author mz
	 */	
	public interface IModule
	{
		/**
		 * 消息处理<br>子类重构时需先调用父类的方法
		 * @param msgId 消息id
		 * @param msg 消息内容
		 */		
		function handle(msgId:int,msg:*):void
	}
}