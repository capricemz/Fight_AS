package com.gamesystem.systeminfoshow
{
	import com.framework.BasicModule;
	import com.framework.MsgIds;

	public class SystemInfoShowModule extends BasicModule
	{
		private var systemInfoShowHandle:SystemInfoShowHandle;
		
		override public function handle(msgId:int, msg:*):void
		{
			switch (msgId)
			{
				case MsgIds.SYSTEM_INFO_SHOW_INIT:
					
					break;
				case MsgIds.SYSTEM_INFO_SHOW_SHOW:
					if(!systemInfoShowHandle)
						systemInfoShowHandle = new SystemInfoShowHandle();
					systemInfoShowHandle.show();
					break;
				case MsgIds.SYSTEM_INFO_SHOW_HIDE:
					systemInfoShowHandle.hide();
					systemInfoShowHandle = null;
					break;
			}
		}
	}
}