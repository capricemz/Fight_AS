package com.framework
{
	/**
	 * 模块内消息id类
	 * @author mz
	 */	
	public class MsgIds
	{
		public static const MODULE_INIT:int = 1;
		public static const MODULE_DESTROY:int = 99999;
		//系统主界面模块
		public static const SYSTEM_MAIN_SHOW:int = 11001;
		public static const SYSTEM_MAIN_HIDE:int = 11002;
		//系统信息显示模块
		public static const SYSTEM_INFO_SHOW_SHOW:int = 12001;
		public static const SYSTEM_INFO_SHOW_HIDE:int = 12002;
		
		//核心引擎模块
		public static const CORE_ENGINE_START:int = 21001;
		public static const CORE_ENGINE_STOP:int = 21002;
		public static const CORE_ENGINE_ADD_KIND_UNIT:int = 21003;
		public static const CORE_ENGINE_DELETE_KIND_UNIT:int = 21004;
		public static const CORE_ENGINE_CREATE_B2BODY:int = 21005;
		public static const CORE_ENGINE_DESTROY_B2BODY:int = 21006;
		public static const CORE_ENGINE_MOUSE_JOINT_SWITCH:int = 21007;
		public static const CORE_ENGINE_SET_LINEAR_VELOCITY:int = 21008;
		public static const CORE_ENGINE_SET_ANGLE:int = 21009;
		
		//核心时间模块
		
		//核心场景模块
		public static const CORE_SCENE_BUILDING:int = 23001;
		public static const CORE_SCENE_RELEASE:int = 23002;
		
		//核心单位模块
		public static const CORE_UNIT_ADD_KIND_UNIT:int = 24001;
		public static const CORE_UNIT_DELETE_KIND_UNIT:int = 24002;
		public static const CORE_UNIT_ADD_ONE_UNIT:int = 24003;
		public static const CORE_UNIT_DELETE_ONE_UNIT:int = 24004;
		public static const CORE_UNIT_RELEASE:int = 24005;
		
		//核心剧情模块
	}
}