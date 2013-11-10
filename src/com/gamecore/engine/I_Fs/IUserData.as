package com.gamecore.engine.I_Fs
{
	/**
	 * 
	 * @author Administrator
	 */	
	public interface IUserData
	{
		/**取得id*/
		function get id():int;
		
		/**取得数据信息用于构建body*/
		function get data():Object;
	}
}