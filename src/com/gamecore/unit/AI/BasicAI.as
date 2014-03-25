package com.gamecore.unit.AI
{
	import com.gamecore.engine.I_Fs.IUnit;
	import com.gamecore.unit.UnitConsts;
	
	import flash.utils.getTimer;

	/**
	 * 基础AI类
	 * @author Administrator
	 */	
	public class BasicAI
	{
		private var _unit:IUnit;
		/**思考间隔*/
		private var thinkIntv:int = 3000;
		private var lastThinkTime:int;
		private var _status:int,_towards:Number = 0;
		
		public function BasicAI(unit:IUnit)
		{
			_unit = unit;
		}
		
		public function think():void
		{
			var crntThinkTime:int = getTimer();
			if(crntThinkTime - lastThinkTime > thinkIntv)
			{
				_towards = (Math.random()*2 - 1)*Math.PI;
				_status = Math.random()*UnitConsts.NUM_TOTAL_STATUS;
				trace("朝向："+_towards+"\n状态："+_status);
				lastThinkTime = crntThinkTime;
			}
		}
		/**单位状态*/		
		public function get status():int
		{
			return _status;
		}
		/**单位朝向*/
		public function get towards():Number
		{
			return _towards;
		}
	}
}