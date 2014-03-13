package com.gamecore.unit
{
	import com.framework.ModuleControl;
	import com.framework.ModuleIds;
	import com.framework.MsgIds;
	import com.gamecore.engine.EngineConsts;
	import com.gamecore.engine.I_Fs.IUnit;
	import com.gamecore.unit.kindunit.BasicOgnzm;
	import com.gamecore.unit.kindunit.BasicUnit;
	import com.gamecore.unit.kindunit.UnitKindTypes;
	
	import flash.utils.Dictionary;
	
	/**
	 * 单位模块处理类
	 * @author Administrator
	 * 
	 */	
	public class UnitHandle
	{
		/**所有种类单位字典*/
		private var _kindUnits:Dictionary;
		
		public function UnitHandle()
		{
			_kindUnits = new Dictionary();
		}
		/**添加一种单位*/
		public function addKindUnit(type:int = 1):void
		{
			var unit:IUnit;
			switch(type)
			{
				case UnitKindTypes.BASIC_UNIT:
					unit = new BasicUnit(type);
					break;
				case UnitKindTypes.BASIC_OGNZM:
					unit = new BasicOgnzm(type);
					break;
			}
			_kindUnits[type] = unit;
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_ADD_KIND_UNIT,unit);//将该种单位传入引擎并取得其在引擎中的id
		}
		/**删除一种单位*/
		public function deleteKindUnit(type:int):void
		{
			var unit:IUnit = _kindUnits[type];
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_DELETE_KIND_UNIT,unit.id);
		}
		/**添加一个单位*/
		public function addOneUnit(type:int):void
		{
			var basicUnitData:BasicUnitData = new BasicUnitData();
			basicUnitData.sex = 0;
			basicUnitData.mass = basicUnitData.sex ? 62 : 52;
			basicUnitData.volume = 1.015*basicUnitData.mass - 4.937;
			basicUnitData.barycenterOffset = 0;
			basicUnitData.power = 250;
			basicUnitData.data.push({type:0,x:60,y:60,shapeType:0,shapeWidth:EngineConsts.P2M*.5,shapeHeight:EngineConsts.P2M*.1,density:50});
			
			(_kindUnits[type] as IUnit).addOneUnit(basicUnitData);
		}
		/**删除一个单位*/
		public function deleteOneUnit(type:int,id:int):void
		{
			(_kindUnits[type] as IUnit).deleteOneUnit(id);
		}
	}
}