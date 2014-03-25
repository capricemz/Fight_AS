package com.gamecore.engine
{
	import com.gamecore.engine.I_Fs.IUserData;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;

	/**
	 * Box2D世界及其他所有对象构造类
	 * @author Administrator
	 */	
	public class InitBox2D
	{
		private static var inst:InitBox2D;
		public static function getInst():InitBox2D
		{
			if(!inst)
				inst = new InitBox2D(hiddle);
			return inst;
		}
		private static function hiddle():void{}
		public function InitBox2D(fun:Function)
		{
			if(fun != hiddle)
				throw new Error("只能用getInst()来获取实例");
			gravity = new b2Vec2(0,0);
			doSleep = true;
			box2ds = new Dictionary();
			
		}
		
		/**重力向量*/
		private var gravity:b2Vec2;
		/**是否休眠*/
		private var doSleep:Boolean;
		/**物理世界*/
		private var _world:b2World;
		/**调试画布*/
		private var debugSprite:Sprite;
		/**Box2D对象集合*/
		private var box2ds:Dictionary;
		
		public function creatWorld():void
		{
			_world = new b2World(gravity,doSleep);
			_world.SetWarmStarting(true);//false时初始刚体不受重力影响，除非受力
			var contect:MyContact = new MyContact();//碰撞检测
			_world.SetContactListener(contect);
			createDebugDraw();
		}
		public function get world():b2World
		{
			return _world;
		}
		private function createDebugDraw():Sprite
		{
			//创建一个sprite，可以将测试几何物体放入其中
			debugSprite = new Sprite();
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(debugSprite);
			//设置边框厚度
			debugDraw.SetLineThickness(1.0);
			//边框透明度
			debugDraw.SetAlpha(1.0);
			//填充透明度
			debugDraw.SetFillAlpha(0.5);
			//设置显示对象
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit|b2DebugDraw.e_centerOfMassBit);
			//物理世界缩放
			debugDraw.SetDrawScale(EngineConsts.P2M);
			_world.SetDebugDraw(debugDraw);
			
			return debugSprite;
		}
		public function getDebugDraw():Sprite
		{
			return debugSprite;
		}
		/**
		 *Query the world for all fixtures that contain a point.
		 * @param callback callback a user implemented callback class. It should match signature function Callback(fixture:b2Fixture):Boolean
		 *  Return true to continue to the next fixture. 
		 * @param p
		 */		
		public function toQueryPoint(callback:Function,x:Number,y:Number):void
		{
			var b2v:b2Vec2 = new b2Vec2(x/EngineConsts.P2M,y/EngineConsts.P2M);
			_world.QueryPoint(callback,b2v);
		}
		/**
		 * 构建一个刚体
		 * @param userData 相关数据
		 * @return 一个刚体
		 */		
		public function createB2Body(userData:Object):b2Body
		{
			//2.刚体定义
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.userData = userData.id;
			bodyDef.type = userData.type == 0 ? b2Body.b2_dynamicBody : (userData.type == 1 ? b2Body.b2_kinematicBody :b2Body.b2_staticBody );//刚体类型
			bodyDef.position.Set(userData.x/EngineConsts.P2M, userData.y/EngineConsts.P2M);//刚体位置（注意刚体的注册中心都是在物体的中心位置）
			bodyDef.fixedRotation = userData.fixedRotation ? userData.fixedRotation : bodyDef.fixedRotation;
			bodyDef.allowSleep = userData.allowSleep ? userData.allowSleep : bodyDef.allowSleep;
			//4.创建墙形状
			var shape:b2Shape;
			switch(userData.shapeType)
			{
				case 0:
					shape = new b2PolygonShape();
					(shape as b2PolygonShape).SetAsBox(userData.shapeWidth/2/EngineConsts.P2M, userData.shapeHeight/2/EngineConsts.P2M);//此处参数为宽和高度的一半值
					break;
				case 1:
					shape = new b2PolygonShape();
					(shape as b2PolygonShape).SetAsArray(userData.shapeArray);
					break;
				case 2:
					shape = new b2CircleShape(userData.shapeRadius/2/EngineConsts.P2M);
					break;
			}
			//3.刚体修饰物定义
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density = userData.density ? userData.density : fixtureDef.density;//密度
			fixtureDef.friction = userData.friction ? userData.friction : fixtureDef.friction;//摩擦粗糙程度
			fixtureDef.restitution = userData.restitution ? userData.restitution : fixtureDef.restitution;//力度返回程度（弹性）
			fixtureDef.filter = userData.filter ? userData.filter : fixtureDef.filter;//碰撞过滤
			fixtureDef.isSensor = userData.isSensor ? userData.isSensor : fixtureDef.isSensor;//是否是传感器
			fixtureDef.shape = shape;//将形状添加到刚体修饰物
			
			/*var mass:b2MassData = new b2MassData();//质量应该通过密度控制，不然会影响刚体的转动
			mass.mass = 100;*/
			//1.需要创建的墙刚体,工厂模式创建刚体
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			/*body.SetMassData(mass);*/
			box2ds[userData.id] = body;
			return body;
		}
		/**
		 * 根据id取得对应的body<br>直接获取
		 * @param id
		 * @return 
		 */		
		public function getb2BodyInDic(id:int):b2Body
		{
			var b:b2Body = box2ds[id] as b2Body;
			return b;
		}
		/**
		 * 根据id取得对应的body<br>遍历获取
		 * @param id body的id
		 * @return body
		 */		
		public function getb2BodyInList(id:int):b2Body
		{
			var b:b2Body;
			for (b=_world.GetBodyList();b;b.GetNext())
			{
				var iUserData:IUserData = b.GetUserData();
				if(iUserData.id == id)
					return b;
			}
			return null;
		}
		/**
		 * 根据id摧毁对应的body
		 * @param id body的id
		 */		
		public function destroyB2Body(id:int):void
		{
			var b:b2Body = getb2BodyInDic(id);
			if(b)
				_world.DestroyBody(b);
		}
		/**创建鼠标关节*/
		public function createMouseJoint(body:b2Body,x:Number,y:Number):b2MouseJoint
		{
			var joint:b2MouseJoint,jointdef:b2MouseJointDef;
			jointdef = new b2MouseJointDef();
			jointdef.bodyA = _world.GetGroundBody();//设置鼠标关节的一个节点为空刚体，GetGroundBody()可以理解为空刚体
			jointdef.bodyB = body;//设置鼠标关节的另一个刚体为鼠标点击的刚体
			jointdef.collideConnected = true;
			jointdef.target.Set(x/EngineConsts.P2M,y/EngineConsts.P2M);//更新鼠标关节拖动的点
			jointdef.maxForce = 300.0 * body.GetMass();//设置鼠标可以施加的最大的力
			joint = _world.CreateJoint(jointdef) as b2MouseJoint;
			box2ds[EngineConsts.mouseJoint] = joint;
			return joint;
		}
		private var target:b2Vec2;
		/**设置鼠标关节目标*/
		public function setMouseJointTarget(x:Number,y:Number):void
		{
			var mouseJoint:b2MouseJoint = box2ds[EngineConsts.mouseJoint];
			if(mouseJoint)
			{
				if(!target)
				{
					target = new b2Vec2(x/EngineConsts.P2M,y/EngineConsts.P2M);
				}
				else
				{
					target.x = x/EngineConsts.P2M;
					target.y = y/EngineConsts.P2M;
				}
				mouseJoint.SetTarget(target);
			}
		}
		/**摧毁鼠标关节*/
		public function destroyMouseJoint():void
		{
			destroyJoint(EngineConsts.mouseJoint);
		}
		/**创建距离关节*/
		public function createDistanceJoint(bodyA:b2Body,bodyB:b2Body,localAnchorA:Point,localAnchorB:Point,length:Number):b2DistanceJoint
		{
			//需要创建的关节
			var joint:b2DistanceJoint,jointdef:b2DistanceJointDef;
			//关节定义
			jointdef = new b2DistanceJointDef();
			jointdef.collideConnected = false;
//			jointdef.bodyA = bodyA;
//			jointdef.bodyB = bodyB;
//			jointdef.localAnchorA = new b2Vec2(localAnchorA.x/Consts.PIXEL_TO_METER,localAnchorA.y/Consts.PIXEL_TO_METER);
//			jointdef.localAnchorB = new b2Vec2(localAnchorB.x/Consts.PIXEL_TO_METER,localAnchorB.y/Consts.PIXEL_TO_METER);
			jointdef.Initialize(bodyA,bodyB,new b2Vec2(localAnchorA.x/EngineConsts.P2M,localAnchorA.y/EngineConsts.P2M),
				new b2Vec2(localAnchorB.x/EngineConsts.P2M,localAnchorB.y/EngineConsts.P2M));
			jointdef.length = length/EngineConsts.P2M;
			joint = _world.CreateJoint(jointdef) as b2DistanceJoint;
			return joint;
		}
		/**创建转动关节*/
		public function createRevoluteJoint(bodyA:b2Body,bodyB:b2Body,localAnchorA:Point,localAnchorB:Point):b2RevoluteJoint
		{
			//需要创建转动关节
			var joint:b2RevoluteJoint;
			//关节定义
			var jointdef:b2RevoluteJointDef = new b2RevoluteJointDef();
			//用bodyA、bodyB和anchor节点初始化马达关节
			jointdef.bodyA = bodyA;
			jointdef.bodyB = bodyB;
			jointdef.localAnchorA = new b2Vec2(localAnchorA.x/EngineConsts.P2M,localAnchorA.y/EngineConsts.P2M);
			jointdef.localAnchorB = new b2Vec2(localAnchorB.x/EngineConsts.P2M,localAnchorB.y/EngineConsts.P2M);
//			jointdef.Initialize(bodyA,bodyB,new b2Vec2(localAnchorA.x/Consts.PIXEL_TO_METER,localAnchorA.y/Consts.PIXEL_TO_METER));
			//设置连接的两个刚体之间不进行碰撞检测
			jointdef.collideConnected = false;
			//开启马达
//			jointdef.enableMotor = true;
			//设置马达的最大角速度，单位为 弧度/秒，如设置为Math.PI，即每秒钟转180度
//			jointdef.motorSpeed = Math.PI;
			//设置最大的扭力值
			jointdef.maxMotorTorque = 500;
			//创建马达关节
			joint = _world.CreateJoint(jointdef) as b2RevoluteJoint;
			return joint;
		}
		/**摧毁关节*/
		public function destroyJoint(id:int):void
		{
			var joint:b2Joint = box2ds[id];
			if(!joint) return;
			_world.DestroyJoint(joint);
			delete box2ds[id];
		}
	}
}