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
			super.handle(msgId,msg);
			switch (msgId)
			{
				case 0:
					break;
			}
		}
		
		override protected function init():void
		{
			
		}
		
		override protected function destroy():void
		{
			
		}
	}
}