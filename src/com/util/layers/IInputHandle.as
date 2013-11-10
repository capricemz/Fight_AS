package com.util.layers
{
	import flash.events.MouseEvent;

	/**
	 * 输入响应接口
	 * @author Administrator
	 */	
	public interface IInputHandle
	{
		/**
		 * 点击事件响应
		 * @param event
		 */		
		function onClick(event:MouseEvent):void;
	}
}