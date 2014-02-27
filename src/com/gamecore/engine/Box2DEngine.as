package com.gamecore.engine
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	
	import com.gamecore.engine.I_Fs.IUnit;
	import com.util.layers.Layers;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Box2D引擎类
	 * @author Administrator
	 */	
	public class Box2DEngine
	{
		private var theBox2D:InitBox2D;
		/**刷新器*/
		private var timer:Timer;
		/**生物字典*/
		private var stuffs:Vector.<IUnit>;
		
		public function Box2DEngine()
		{
			super();
			
			theBox2D = InitBox2D.getInst();
			theBox2D.creatWorld();
			if(EngineConsts.isDebugDrawShow)
				Layers.inst.layerMain.addChild(theBox2D.getDebugDraw());
			
			timer = new Timer(EngineConsts.ENGINE_DELAY);
			timer.addEventListener(TimerEvent.TIMER,handleTimer);
			
			stuffs = new Vector.<IUnit>();
		}
		/**更新处理*/
		protected function handleTimer(event:TimerEvent):void
		{
			theBox2D.world.Step(1000/EngineConsts.ENGINE_DELAY,EngineConsts.velocityInterations,EngineConsts.positionIterations);
			theBox2D.world.ClearForces();//在2.1版本清除力，以提高效率
			if(EngineConsts.isDebugDrawShow)
				theBox2D.world.DrawDebugData();//绘制
			var b:b2Body = theBox2D.world.GetBodyList();
			while(b)
			{
				var _b:b2Body = b;
				b = b.GetNext();
				_b;//刷新摩擦力
				trace("---------------------------------");
				trace("线速度："+_b.GetLinearVelocity().Length());
				trace("角速度："+_b.GetAngularVelocity());
				trace("惯性："+_b.GetInertia());
				trace("---------------------------------");
			}
			var stuff:IUnit;
			for each (stuff in stuffs)
			{
				stuff.update();//刷新
			}
		}
		private var hasMouseJoint:Boolean;
		/**
		 * 鼠标控制刚体开关
		 * @param boolean 默认执行开启
		 */		
		public function mouseJointSwitch(boolean:Boolean = true):void
		{
			if(boolean)
			{
				Layers.inst.stage.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
				Layers.inst.stage.addEventListener(MouseEvent.MOUSE_UP,onUp);
			}
			else
			{
				Layers.inst.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onDown);
				Layers.inst.stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);
				Layers.inst.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			}
		}
		protected function onDown(event:MouseEvent):void
		{
			event.stopPropagation();
			if(hasMouseJoint)
				return;
			var fun:Function = function (fixture:b2Fixture):void
			{
				if(fixture)
				{
					theBox2D.createMouseJoint(fixture.GetBody(),event.stageX,event.stageY);
					Layers.inst.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
				}
			};
			theBox2D.toQueryPoint(fun,event.stageX,event.stageY);
			hasMouseJoint = true;
		}
		protected function onUp(event:MouseEvent):void
		{
			event.stopPropagation();
			if(!hasMouseJoint)
				return;
			Layers.inst.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			theBox2D.destroyMouseJoint();
			hasMouseJoint = false;
		}
		protected function onMove(event:MouseEvent):void
		{
			/*trace("鼠标正在拖动"+",x:"+event.stageX+",y:"+event.stageY);*/
			event.stopPropagation();
			if(hasMouseJoint)
				theBox2D.setMouseJointTarget(event.stageX,event.stageY);
		}
		/**启动引擎*/
		public function startEngine():void
		{
			timer.start();
		}
		/**暂停引擎*/
		public function stopEngine():void
		{
			timer.stop();
		}
		/**添加一种生物*/
		public function addKindStuff(stuff:IUnit):void
		{
			stuff.id = stuffs.length+1;
			stuffs.push(stuff);
		}
		public function deleteKindStuff(id:int):void
		{
			stuffs.splice(id,1);
		}
		/**创建b2Body*/
		public function createB2Body(userData:Object):void
		{
			theBox2D.createB2Body(userData);
		}
		public function destroyB2Body(id:int):void
		{
			theBox2D.destroyB2Body(id);
		}
	}
}