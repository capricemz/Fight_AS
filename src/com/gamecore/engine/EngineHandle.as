package com.gamecore.engine
{
	import com.gamecore.engine.I_Fs.IUnit;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 引擎处理类
	 * @author Administrator
	 */	
	public class EngineHandle
	{
		private var timer:Timer;
		private var units:Vector.<IUnit>;
		
		public function EngineHandle()
		{
			timer = new Timer(EngineConsts.ENGINE_DELAY);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			units = new Vector.<IUnit>();
		}
		/**引擎刷新处理*/		
		protected function onTimer(event:TimerEvent):void
		{
			var unit:IUnit
			for each(unit in units)
			{
				unit.update();
			}
		}
		/**启动*/
		public function start():void
		{
			timer.start();
		}
		/**停止*/
		public function stop():void
		{
			timer.stop();
		}
		/**添加一个生物*/
		public function addOneStuff(unit:IUnit):void
		{
			unit.id = units.length;
			units.push(unit);
			trace("添加了一个生物，生物ID:"+unit.id);
		}
		/**删除一个生物*/
		public function delOneStuff(id:int):void
		{
			units.splice(id,1);
		}
	}
}