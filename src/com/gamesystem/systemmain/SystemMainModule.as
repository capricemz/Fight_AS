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
			super.handle(msgId,msg);
			switch (msgId)
			{
				case MsgIds.SYSTEM_MAIN_SHOW:
					systemMainHandle.show();
					break;
				case MsgIds.SYSTEM_MAIN_HIDE:
					systemMainHandle.hide();
					break;
			}
		}
		
		override protected function init():void
		{
			systemMainHandle = new SystemMainHandle();
		}
		
		override protected function destroy():void
		{
			systemMainHandle = null;
		}
	}
}