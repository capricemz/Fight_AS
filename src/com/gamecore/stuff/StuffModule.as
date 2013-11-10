package com.gamecore.stuff
{
	import com.framework.IModule;
	import com.framework.MsgIds;
	
	import flash.utils.ByteArray;
	
	/**
	 * 事物模块接口类
	 * @author mz
	 */	
	public class StuffModule implements IModule
	{
		private var stuffHandle:StuffHandle;
		
		public function handle(msgId:int, msg:*):void
		{
			switch (msgId)
			{
				case MsgIds.CORE_STUFF_INIT:
					stuffHandle = new StuffHandle();
					break;
				case MsgIds.CORE_STUFF_BUILDING:
					stuffHandle.building();
					break;
			}
		}
	}
}