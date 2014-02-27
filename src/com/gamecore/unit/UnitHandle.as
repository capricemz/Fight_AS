package com.gamecore.unit
{
	import com.framework.ModuleControl;
	import com.framework.ModuleIds;
	import com.framework.MsgIds;
	import com.gamecore.engine.EngineConsts;
	
	/**
	 * 单位模块处理类
	 * @author Administrator
	 * 
	 */	
	public class UnitHandle
	{
		public function UnitHandle()
		{
			
		}
		/**构建一个生物*/
		public function building():void
		{
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			var basicBiology:BasicBiology = new BasicBiology();
			moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_ADD_KIND_UNIT,basicBiology);//将生物传入引擎并获得ID
			
			var basicStuffData:BasicUnitData = new BasicUnitData();
			basicStuffData.sex = 0;
			basicStuffData.mass = basicStuffData.sex ? 62 : 52;
			basicStuffData.volume = 1.015*basicStuffData.mass - 4.937;
			basicStuffData.barycenterOffset = 0;
			basicStuffData.power = 250;
			basicStuffData.data.push({type:0,x:60,y:60,shapeType:0,shapeWidth:EngineConsts.P2M*.5,shapeHeight:EngineConsts.P2M*.1,density:50});
			
			basicBiology.addOneStuff(basicStuffData);
		}
	}
}