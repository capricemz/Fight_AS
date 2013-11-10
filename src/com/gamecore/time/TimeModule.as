package com.gamecore.time
{
	import com.framework.BasicModule;
	import com.framework.MsgIds;
	
	import flash.utils.ByteArray;
	
	/**
	 * 时间模块接口类
	 * @author mz
	 */	
	public class TimeModule extends BasicModule
	{
		override public function handle(msgId:int, msg:*):void
		{
			switch (msgId)
			{
				case MsgIds.CORE_TIME_INIT:
					break;
			}
		}
	}
}