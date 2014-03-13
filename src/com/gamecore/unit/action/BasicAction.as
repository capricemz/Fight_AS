package com.gamecore.unit.action
{
	/**
	 * 基础动作类
	 * @author Administrator
	 */	
	public class BasicAction
	{
		public function BasicAction()
		{
			
		}
		public function execute():void
		{
			
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