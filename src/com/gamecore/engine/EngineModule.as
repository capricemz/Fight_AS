package com.gamecore.engine
{
	import com.framework.BasicModule;
	import com.framework.MsgIds;
	
	/**
	 * 引擎模块接口类
	 * @author mz
	 */	
	public class EngineModule extends BasicModule
	{

		/*private var engineHandle:EngineHandle;*/
		private var box2dEngine:Box2DEngine;
		
		override public function handle(msgId:int, msg:*):void
		{
			switch (msgId)
			{
				/*case MsgIds.CORE_ENGINE_INIT:
					engineHandle = new EngineHandle();
					break;
				case MsgIds.CORE_ENGINE_START:
					engineHandle.start();
					break;
				case MsgIds.CORE_ENGINE_STOP:
					engineHandle.stop();
					break;
				case MsgIds.CORE_ENGINE_ADD_STUFF:
					engineHandle.addOneStuff(msg as IStuff);
					break;
				case MsgIds.CORE_ENGINE_DELETE_STUFF:
					engineHandle.delOneStuff(msg);
					break;*/
				case MsgIds.CORE_ENGINE_INIT:
					box2dEngine = new Box2DEngine();
					break;
				case MsgIds.CORE_ENGINE_START:
					box2dEngine.startEngine();
					break;
				case MsgIds.CORE_ENGINE_STOP:
					box2dEngine.stopEngine();
					break;
				case MsgIds.CORE_ENGINE_ADD_KIND_STUFF:
					box2dEngine.addKindStuff(msg);
					break;
				case MsgIds.CORE_ENGINE_DELETE_KIND_STUFF:
					box2dEngine.deleteKindStuff(msg);
					break;
				case MsgIds.CORE_ENGINE_CREATE_B2BODY:
					box2dEngine.createB2Body(msg);
					break;
				case MsgIds.CORE_ENGINE_DESTROY_B2BODY:
					box2dEngine.destroyB2Body(msg);
					break;
				case MsgIds.CORE_ENGINE_MOUSE_JOINT_SWITCH:
					box2dEngine.mouseJointSwitch(msg);
					break;
			}
		}
	}
}