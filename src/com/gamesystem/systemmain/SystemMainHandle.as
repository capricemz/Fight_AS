package com.gamesystem.systemmain
{
	import com.framework.ModuleControl;
	import com.framework.ModuleIds;
	import com.framework.MsgIds;
	import com.gamecore.unit.kindunit.UnitKindTypes;
	import com.util.layers.Layers;
	
	import flash.events.MouseEvent;

	/**
	 * 系统主模块处理类
	 * @author Administrator
	 */	
	public class SystemMainHandle
	{
		private var systemMain:SystemMain;
		
		public function SystemMainHandle()
		{
			systemMain = new SystemMain();
		}
		/**显示主界面*/
		public function show():void
		{
			if(!systemMain.hasEventListener(MouseEvent.CLICK))
				systemMain.addEventListener(MouseEvent.CLICK,onCick,true);
			if(!systemMain.parent)
				Layers.inst.layerMain.addChild(systemMain);
		}
		/**隐藏主界面*/
		public function hide():void
		{
			if(systemMain.hasEventListener(MouseEvent.CLICK))
				systemMain.removeEventListener(MouseEvent.CLICK,onCick,true);
			if(systemMain.parent)
				systemMain.parent.removeChild(systemMain);
		}
		public function onCick(event:MouseEvent):void
		{
			switch (event.target)
			{
				case systemMain.btn1:
					startGame();
					break;
				case systemMain.btn2:
					break;
				case systemMain.btn3:
					break;
			}
		}
		/**开始游戏*/
		public function startGame():void
		{
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			//游戏核心相关模块构建
			moduleCtrl.callModule(ModuleIds.CORE_SCENE,MsgIds.CORE_SCENE_BUILDING);
			trace("初始场景构建完成");
			moduleCtrl.callModule(ModuleIds.CORE_UNIT,MsgIds.CORE_UNIT_ADD_KIND_UNIT,UnitKindTypes.BASIC_UNIT);
			trace("初始生物构建完成");
			moduleCtrl.callModule(ModuleIds.CORE_UNIT,MsgIds.CORE_UNIT_ADD_ONE_UNIT,UnitKindTypes.BASIC_UNIT);
			moduleCtrl.callModule(ModuleIds.CORE_UNIT,MsgIds.CORE_UNIT_ADD_ONE_UNIT,UnitKindTypes.BASIC_UNIT);
			//游戏核心启动
			moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_START);
			trace("游戏启动完成");
			
			moduleCtrl.callModule(ModuleIds.SYSTEM_MAIN,MsgIds.SYSTEM_MAIN_HIDE);
			moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_MOUSE_JOINT_SWITCH,true);
		}
	}
}