package com.gamecore.engine.I_Fs
{
	/**
	 * 单位接口
	 * @author Administrator
	 */	
	public interface IUnit
	{
		/**单位更新*/
		function update():void;
		function set kindId(id:int):void;
		function get kindId():int;
		function get bodyIds():Vector.<int>;
		function addOneUnit(unitata:*):void;
		function deleteOneUnit(id:int):void;
	}
}