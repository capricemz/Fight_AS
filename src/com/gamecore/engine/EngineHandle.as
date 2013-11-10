package com.gamecore.engine
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 引擎处理类
	 * @author Administrator
	 */	
	public class EngineHandle
	{
		private var timer:Timer;
		private var stuffs:Vector.<IStuff>;
		
		public function EngineHandle()
		{
			timer = new Timer(EngineConsts.ENGINE_DELAY);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			stuffs = new Vector.<IStuff>();
		}
		/**引擎刷新处理*/		
		protected function onTimer(event:TimerEvent):void
		{
			var stuff:IStuff
			for each(stuff in stuffs)
			{
				stuff.update();
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
		public function addOneStuff(stuff:IStuff):void
		{
			stuff.id = stuffs.length;
			stuffs.push(stuff);
			trace("添加了一个生物，生物ID:"+stuff.id);
		}
		/**删除一个生物*/
		public function delOneStuff(id:int):void
		{
			stuffs.splice(id,1);
		}
	}
}