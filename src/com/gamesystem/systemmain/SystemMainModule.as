package com.gamesystem.systemmain
{
	import com.framework.BasicModule;
	import com.framework.MsgIds;
	
	/**
	 * 系统主界面模块类
	 * @author Administrator
	 */	
	public class SystemMainModule extends BasicModule
	{
		private var systemMainHandle:SystemMainHandle;
		
		override public function handle(msgId:int, msg:*):void
		{
			switch (msgId)
			{
				case MsgIds.SYSTEM_MAIN_INIT:
					
					break;
				case MsgIds.SYSTEM_MAIN_SHOW:
					if(!systemMainHandle)
						systemMainHandle = new SystemMainHandle();
					systemMainHandle.show();
					break;
				case MsgIds.SYSTEM_MAIN_HIDE:
					systemMainHandle.hide();
					systemMainHandle = null;
					break;
			}
		}
	}
}