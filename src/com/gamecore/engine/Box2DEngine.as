package com.gamecore.engine
{
	import com.gamecore.engine.I_Fs.IUnit;
	import com.util.layers.Layers;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	
	/**
	 * Box2D引擎类
	 * @author Administrator
	 */	
	public class Box2DEngine
	{
		private var theBox2D:InitBox2D;
		/**刷新器*/
		private var timer:Timer;
		/**单位字典*/
		private var units:Vector.<IUnit>;
		
		public function Box2DEngine()
		{
			super();
			
			theBox2D = InitBox2D.getInst();
			theBox2D.creatWorld();
			if(EngineConsts.isDebugDrawShow)
				Layers.inst.layerMain.addChild(theBox2D.getDebugDraw());
			
			timer = new Timer(EngineConsts.ENGINE_DELAY);
			timer.addEventListener(TimerEvent.TIMER,handleTimer);
			
			units = new Vector.<IUnit>();
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
				trace("---------------------------------");
			}
			var unit:IUnit;
			for each (unit in units)
			{
				unit.update();//刷新
			}
			//刷新镜头
			if(EngineConsts.isDebugDrawShow)
			{
				var getDebugDraw:Sprite = theBox2D.getDebugDraw();
				var getb2BodyInDic:b2Body = theBox2D.getb2BodyInDic(units[0].bodyIds[0]);
				getDebugDraw.x = getDebugDraw.stage.stageWidth/2 - getb2BodyInDic.GetPosition().x*EngineConsts.P2M;
				getDebugDraw.y = getDebugDraw.stage.stageHeight/2 - getb2BodyInDic.GetPosition().y*EngineConsts.P2M;
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
		/**添加一种单位*/
		public function addKindUnit(unit:IUnit):void
		{
			unit.kindId = units.length+1;
			units.push(unit);
		}
		
		public function deleteKindUnit(id:int):void
		{
			units.splice(id,1);
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
		/**
		 * 设置刚体线速度
		 * @param msg 0:id,1:线速度
		 */		
		public function SetLinearVelocity(msg:Array):void
		{
			var body:b2Body = theBox2D.getb2BodyInDic(msg[0]);
			body.SetAwake(true);
			var angle:Number = body.GetAngle();
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			body.SetLinearVelocity(new b2Vec2(cos*msg[1],sin*msg[1]));
		}
		/**
		 * 设置刚体角度
		 * @param msg 0:id,1:角度（单位弧度）
		 */		
		public function SetAngle(msg:Array):void
		{
			var body:b2Body = theBox2D.getb2BodyInDic(msg[0]);
			/*body.SetAwake(true);*/
			body.SetAngle(msg[1]);
		}
		/**
		 * 设置刚体受力
		 * @param msg 0:id,1:力
		 */		
		public function ApplyForce(msg:Array):void
		{
			var body:b2Body = theBox2D.getb2BodyInDic(msg[0]);
			body.SetAwake(true);
			var angle:Number = body.GetAngle();
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			body.ApplyForce(new b2Vec2(cos*msg[1],sin*msg[1]),body.GetWorldCenter());
		}
	}
}