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
			super.handle(msgId,msg);
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
				case MsgIds.CORE_ENGINE_START:
					box2dEngine.startEngine();
					break;
				case MsgIds.CORE_ENGINE_STOP:
					box2dEngine.stopEngine();
					break;
				case MsgIds.CORE_ENGINE_ADD_KIND_UNIT:
					box2dEngine.addKindUnit(msg);
					break;
				case MsgIds.CORE_ENGINE_DELETE_KIND_UNIT:
					box2dEngine.deleteKindUnit(msg);
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
				case MsgIds.CORE_ENGINE_SET_ANGLE:
					box2dEngine.SetAngle(msg);
					break;
				case MsgIds.CORE_ENGINE_SET_LINEAR_VELOCITY:
					box2dEngine.SetLinearVelocity(msg);
					break;
				case MsgIds.CORE_ENGINE_APPLY_FORCE:
					box2dEngine.ApplyForce(msg);
					break;
			}
		}
		
		override protected function init():void
		{
			box2dEngine = new Box2DEngine();
		}
		
		override protected function destroy():void
		{
			
		}
	}
}