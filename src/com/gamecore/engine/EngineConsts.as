package com.gamecore.engine
{
	/**
	 * 引擎常量定义类
	 * @author Administrator
	 */	
	public class EngineConsts
	{
		/**box2d初始化相关<br>ENGINE_DELAY:引擎刷新时间<br>velocityInterations<br>positionIterations*/
		public static const ENGINE_DELAY:Number = 33,velocityInterations:int = 10,positionIterations:int = 10;;
		public static const isDebugDrawShow:Boolean = true;
		
		public static const P2M:int = 50;
		
		public static const categotybits_1:uint = 1<<0;
		public static const categotybits_2:uint = 1<<1;
		//……
		
		public static const maskbits_1:uint = categotybits_1 + categotybits_2;
		public static const maskbits_2:uint = categotybits_1;
		
		/**鼠标关节id*/
		public static const mouseJoint:int = 1315211905;
	}
}