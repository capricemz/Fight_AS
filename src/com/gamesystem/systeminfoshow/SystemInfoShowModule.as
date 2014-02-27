package com.gamesystem.systeminfoshow
{
	import com.framework.BasicModule;
	import com.framework.MsgIds;

	public class SystemInfoShowModule extends BasicModule
	{
		private var systemInfoShowHandle:SystemInfoShowHandle;
		
		override public function handle(msgId:int, msg:*):void
		{
			super.handle(msgId,msg);
			switch (msgId)
			{
				case MsgIds.SYSTEM_INFO_SHOW_SHOW:
					systemInfoShowHandle.show();
					break;
				case MsgIds.SYSTEM_INFO_SHOW_HIDE:
					systemInfoShowHandle.hide();
					break;
			}
		}
		
		override protected function init():void
		{
			systemInfoShowHandle = new SystemInfoShowHandle();
		}
		
		override protected function destroy():void
		{
			systemInfoShowHandle = null;
		}
	}
}