package com.util.load
{
	/**
	 * 加载链接数据类
	 * @author Administrator
	 */	
	public class LoaderData
	{
		/**链接地址*/
		public var url:String;
		/**加载方式，true使用Loader加载，false使用URLLoader加载*/
		public var type:Boolean;
		/**回调函数*/
		public var callBack:Function;
		
		public function LoaderData()
		{
			type = true;
			callBack = null;
		}
	}
}