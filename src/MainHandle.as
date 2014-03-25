package
{
	import com.framework.ModuleControl;
	import com.framework.ModuleIds;
	import com.framework.ModulesHandle;
	import com.framework.MsgIds;
	import com.util.load.LoaderControl;
	import com.util.load.LoaderData;

	/**
	 * 启动相关处理类
	 * @author mz
	 */	
	public class MainHandle
	{
		/**模块初始化*/
		public function MainHandle():void
		{
			
		}
		public function loadres():void
		{
			//加载游戏资源
			var loaderControl:LoaderControl = LoaderControl.loaderControl();
			var loaderData:LoaderData = new LoaderData();
			loaderData.url = "../res/res_system_main.swf";
			loaderData.callBack = function():void
			{
				registerAllModules();
				initAllModules();
				showSystemMainUI();
			};
			var vector:Vector.<LoaderData> = new Vector.<LoaderData>();
			vector.push(loaderData);
			loaderControl.load(vector);
		}
		public function registerAllModules():void
		{
			//注册模块
			var moduleHandle:ModulesHandle = new ModulesHandle();
			moduleHandle.registerAll();
		}
		public function initAllModules():void
		{
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			//游戏系统相关模块初始化
			moduleCtrl.callModule(ModuleIds.SYSTEM_MAIN,MsgIds.MODULE_INIT);
			//游戏核心相关模块初始化
			moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.MODULE_INIT);
			trace("引擎模块初始化完成");
			moduleCtrl.callModule(ModuleIds.CORE_TIME,MsgIds.MODULE_INIT);
			trace("时间模块初始化完成");
			moduleCtrl.callModule(ModuleIds.CORE_SCENE,MsgIds.MODULE_INIT);
			trace("场景模块初始化完成");
			moduleCtrl.callModule(ModuleIds.CORE_UNIT,MsgIds.MODULE_INIT);
			trace("生物模块初始化完成");
			moduleCtrl.callModule(ModuleIds.CORE_PLOT,MsgIds.MODULE_INIT);
			trace("剧情模块初始化完成");
		}
		/**显示系统系统主模块界面*/
		public function showSystemMainUI():void
		{
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			moduleCtrl.callModule(ModuleIds.SYSTEM_MAIN,MsgIds.SYSTEM_MAIN_SHOW);
		}
	}
}