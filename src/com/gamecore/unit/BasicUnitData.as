package com.gamecore.unit
{
	import flash.geom.Point;

	/**
	 * 单位数据类
	 * @author Administrator
	 */	
	public class BasicUnitData
	{
		public var id:int;
		/**性别*/
		public var sex:int;
		/**质量*/
		public var mass:Number;
		/**体积*/
		public var volume:Number;
		/**重心偏移值*/
		public var barycenterOffset:Number;
		/**力量*/
		public var power:Number;
		/**耐力*/
		public var endurance:Number;
		/**恢复*/
		private var recovery:Number;
		/**固定值动作的距离（受体积影响）*/
		private var strikingDistance:Number;
		/**位置*/
		private var postion:Point;
		/**body数据*/
		public var data:Vector.<Object>;
		
		public function BasicUnitData()
		{
			postion = new Point();
			data = new Vector.<Object>();
		}
	}
}