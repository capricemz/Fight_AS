package com.gamecore.unit.kindunit
{
	import com.framework.ModuleControl;
	import com.framework.ModuleIds;
	import com.framework.MsgIds;
	import com.gamecore.engine.I_Fs.IUnit;
	import com.gamecore.unit.BasicUnitData;

	/**
	 * 基础单位类
	 * @author mz
	 */	
	public class BasicUnit implements IUnit
	{
		/**单位种族id*/
		protected var _id:int;
		protected var _bodyIds:Vector.<int>;
		/**单位种族类型*/
		public var type:int;
		/**个体集合*/
		protected var units:Vector.<BasicUnitData>;
		
		public function BasicUnit(type:int)
		{
			this.type = type;
			units = new Vector.<BasicUnitData>();
			_bodyIds = new Vector.<int>();
		}
		/**添加一个单位*/
		public function addOneUnit(unitData:*):void
		{
			var basicUnitData:BasicUnitData = unitData as BasicUnitData;
			basicUnitData.id = type+(units.length+1)*1000;
			units.push(basicUnitData);
			//构建body
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			var i:int,data:Object;
			for (i=0;i<basicUnitData.data.length;i++)
			{
				data = basicUnitData.data[i];
				data.id = basicUnitData.id+i+1;//设置某个单位的某个body的id
				_bodyIds.push(data.id);
				moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_CREATE_B2BODY,data);
			}
		}
		/**删除一个单位*/
		public function deleteOneUnit(id:int):void
		{
			units.splice(id,1);
		}
		
		public function update():void
		{
			
		}
		public function set kindId(id:int):void
		{
			this._id = id;
		}
		public function get kindId():int
		{
			return _id;
		}
		public function get bodyIds():Vector.<int>
		{
			return _bodyIds;
		}
	}
}