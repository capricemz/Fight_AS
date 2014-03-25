package com.gamecore.unit.action
{
	import com.framework.ModuleControl;
	import com.framework.ModuleIds;
	import com.framework.MsgIds;
	import com.gamecore.engine.EngineConsts;
	import com.gamecore.engine.I_Fs.IUnit;
	import com.gamecore.unit.UnitConsts;

	/**
	 * 基础动作类
	 * @author Administrator
	 */	
	public class BasicAction
	{
		private var _unit:IUnit;
		
		public function BasicAction(unit:IUnit)
		{
			_unit = unit;
		}
		
		public function execute(towards:Number,status:int):void
		{
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_SET_ANGLE,[_unit.bodyIds[0],towards]);
			switch(status)
			{
				case UnitConsts.STATUS_MOVE:
					moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_SET_LINEAR_VELOCITY,[_unit.bodyIds[0],.001]);
					break;
				case UnitConsts.STATUS_STAY:
					moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_SET_LINEAR_VELOCITY,[_unit.bodyIds[0],0]);
					break;
			}
		}
		/**动作的速度*/
		public function speed(power:Number,strikingDistance:Number,mass:Number):Number
		{
			return Math.sqrt(power*strikingDistance/mass);
		}
		/**动作的冲量*/
		public function impulse(power:Number,strikingDistance:Number,mass:Number):Number
		{
			return Math.sqrt(power*strikingDistance*mass);
		}
		/**动作的范围*/
		public function range():Number
		{
			return 0;
		}
		/**动作的消耗*/
		public function cost(power:Number,strikingDistance:Number):Number
		{
			return power*strikingDistance;
		}
	}
}