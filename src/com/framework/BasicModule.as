package com.framework
{
	/**
	 * 基础模块接口实现类
	 * @author mz
	 */	
	public class BasicModule implements IModule
	{
		public function handle(msgId:int, msg:*):void
		{
			switch(msgId)
			{
				case MsgIds.MODULE_INIT:
					init();
					break;
				case MsgIds.MODULE_DESTROY:
					destroy();
					break;
			}
		}
		
		protected function init():void
		{
			
		}
		
		protected function destroy():void
		{
			
		}
	}
}