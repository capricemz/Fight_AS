package com.framework
{
	/**
	 * 模块内消息id类
	 * @author mz
	 */	
	public class MsgIds
	{
		//系统主界面模块
		public static const SYSTEM_MAIN_INIT:int = 11000;
		public static const SYSTEM_MAIN_SHOW:int = 11001;
		public static const SYSTEM_MAIN_HIDE:int = 11002;
		//系统信息显示模块
		public static const SYSTEM_INFO_SHOW_INIT:int = 12000;
		public static const SYSTEM_INFO_SHOW_SHOW:int = 12001;
		public static const SYSTEM_INFO_SHOW_HIDE:int = 12002;
		
		//核心引擎模块
		public static const CORE_ENGINE_INIT:int = 21000;
		public static const CORE_ENGINE_START:int = 21001;
		public static const CORE_ENGINE_STOP:int = 21002;
		public static const CORE_ENGINE_ADD_KIND_STUFF:int = 21003;
		public static const CORE_ENGINE_DELETE_KIND_STUFF:int = 21004;
		public static const CORE_ENGINE_CREATE_B2BODY:int = 21005;
		public static const CORE_ENGINE_DESTROY_B2BODY:int = 21006;
		public static const CORE_ENGINE_MOUSE_JOINT_SWITCH:int = 21007;
		
		//核心时间模块
		public static const CORE_TIME_INIT:int = 22000;
		
		//核心场景模块
		public static const CORE_SCENE_INIT:int = 23000;
		public static const CORE_SCENE_BUILDING:int = 23001;
		public static const CORE_SCENE_RELEASE:int = 23002;
		
		//核心生物模块
		public static const CORE_STUFF_INIT:int = 24000;
		public static const CORE_STUFF_BUILDING:int = 24001;
		public static const CORE_STUFF_RELEASE:int = 24002;
		
		//核心剧情模块
		public static const CORE_PLOT_INIT:int = 25000;
	}
}