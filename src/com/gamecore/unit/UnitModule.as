package com.gamecore.unit
{
	import com.framework.BasicModule;
	import com.framework.IModule;
	import com.framework.MsgIds;
	
	import flash.utils.ByteArray;
	
	/**
	 * 单位模块接口类
	 * @author mz
	 */	
	public class UnitModule extends BasicModule implements IModule
	{
		private var unitHandle:UnitHandle;
		
		override public function handle(msgId:int, msg:*):void
		{
			super.handle(msgId,msg);
			switch (msgId)
			{
				case MsgIds.CORE_UNIT_BUILDING:
					unitHandle.building();
					break;
			}
		}
		
		override protected function init():void
		{
			unitHandle = new UnitHandle();
		}
		
		override protected function destroy():void
		{
			unitHandle = null;
		}
	}
}