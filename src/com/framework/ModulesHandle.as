package com.framework
{
	import com.gamecore.engine.EngineModule;
	import com.gamecore.plot.PlotModule;
	import com.gamecore.scene.SceneModule;
	import com.gamecore.unit.UnitModule;
	import com.gamecore.time.TimeModule;
	import com.gamesystem.systeminfoshow.SystemInfoShowModule;
	import com.gamesystem.systemmain.SystemMainModule;
	

	/**
	 * 模块注册移除处理类<br>
	 * 用于对消息进行模块注册或删除
	 * @author mz
	 */	
	public class ModulesHandle
	{
		private var systemMainModule:SystemMainModule,
					systemInfoShowModule:SystemInfoShowModule;
		
		private var engineModule:EngineModule,
					timeModule:TimeModule,
					sceneModule:SceneModule,
					stuffModule:UnitModule,
					plotModule:PlotModule;

		public function ModulesHandle()
		{
			//游戏系统相关模块
			systemMainModule = new SystemMainModule();
			systemInfoShowModule = new SystemInfoShowModule();
			//游戏核心相关模块
			engineModule = new EngineModule();
			timeModule = new TimeModule();
			sceneModule = new SceneModule();
			stuffModule = new UnitModule();
			plotModule = new PlotModule();
			
		}
		/**
		 * 注册所有的模块
		 */		
		public function registerAll():void
		{
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			//游戏系统相关模块注册
			moduleCtrl.registrtModule(ModuleIds.SYSTEM_MAIN,systemMainModule);
			moduleCtrl.registrtModule(ModuleIds.SYSTEM_INFO_SHOW,systemInfoShowModule);
			//游戏核心相关模块注册
			moduleCtrl.registrtModule(ModuleIds.CORE_ENGINE,engineModule);
			moduleCtrl.registrtModule(ModuleIds.CORE_TIME,timeModule);
			moduleCtrl.registrtModule(ModuleIds.CORE_SCENE,sceneModule);
			moduleCtrl.registrtModule(ModuleIds.CORE_UNIT,stuffModule);
			moduleCtrl.registrtModule(ModuleIds.CORE_PLOT,plotModule);
		}
		/**反注册所有的模块*/
		public function unregisterAll():void
		{
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			//游戏系统相关模块注册
			moduleCtrl.removeModule(ModuleIds.SYSTEM_MAIN);
			systemMainModule = null;
			moduleCtrl.removeModule(ModuleIds.SYSTEM_INFO_SHOW);
			systemInfoShowModule = null;
			//游戏核心相关模块注册
			moduleCtrl.removeModule(ModuleIds.CORE_ENGINE);
			engineModule = null;
			moduleCtrl.removeModule(ModuleIds.CORE_TIME);
			timeModule = null;
			moduleCtrl.removeModule(ModuleIds.CORE_SCENE);
			sceneModule = null;
			moduleCtrl.removeModule(ModuleIds.CORE_UNIT);
			stuffModule = null;
			moduleCtrl.removeModule(ModuleIds.CORE_PLOT);
			plotModule = null;
		}
	}
}