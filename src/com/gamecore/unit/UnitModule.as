package com.gamecore.unit
{
	import com.framework.BasicModule;
	import com.framework.IModule;
	import com.framework.MsgIds;
	
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
				case MsgIds.CORE_UNIT_ADD_KIND_UNIT:
					unitHandle.addKindUnit(msg);
					break;
				case MsgIds.CORE_UNIT_DELETE_KIND_UNIT:
					unitHandle.deleteKindUnit(msg);
					break;
				case MsgIds.CORE_UNIT_ADD_ONE_UNIT:
					unitHandle.addOneUnit(msg);
					break;
				case MsgIds.CORE_UNIT_DELETE_ONE_UNIT:
					unitHandle.deleteOneUnit(msg[0],msg[1]);
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