package com.gamecore.scene
{
	import com.framework.BasicModule;
	import com.framework.ModuleIds;
	import com.framework.MsgIds;
	
	import flash.utils.ByteArray;
	
	/**
	 * 场景模块类
	 * @author mz
	 */	
	public class SceneModule extends BasicModule
	{
		private var model:SceneM,view:SceneV,ctrl:SceneC;
		
		override public function handle(msgId:int, msg:*):void
		{
			super.handle(msgId,msg);
			switch (msgId)
			{
				case 2:
					view.show();
					break;
			}
		}
		
		override protected function init():void
		{
			model = new SceneM();
			view = new SceneV(model);
			ctrl = new SceneC(model);
		}
		
		override protected function destroy():void
		{
			
		}
	}
}