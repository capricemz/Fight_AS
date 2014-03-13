package com.util.load
{
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getQualifiedClassName;

	/**
	 * 加载控制类
	 * @author Administrator
	 */	
	public class LoaderControl
	{
		private static var singleton:LoaderControl;
		public static function loaderControl():LoaderControl
		{
			if(singleton == null)
			{
				singleton = new LoaderControl(hidden);
			}
			return singleton;
		}
		private static function hidden():void{}
		public function LoaderControl(caller:Function=null)
		{
			if(caller != hidden)
			{
				throw new Error("只能用getInstance()来获取实例");
			}
			if(LoaderControl.singleton != null)
			{
				throw new Error("只能用getInstance()来获取实例");
			}
			init();
		}
		
		private var urlLoader:URLLoader,urlRequest:URLRequest,loader:Loader,loaderContext:LoaderContext;
		private var loaderDatas:Vector.<LoaderData>,currentLoaderData:LoaderData;

		private function init():void
		{
			urlLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,onHttpResponseStatus);
			urlLoader.addEventListener(ProgressEvent.PROGRESS,onProgress);
			urlLoader.addEventListener(Event.COMPLETE,onComplete);
			
			urlRequest = new URLRequest();
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			
			loaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
		}
		/**加载错误处理*/
		protected function onError(event:ErrorEvent):void
		{
			
		}
		/**加载请求处理*/
		protected function onHttpResponseStatus(event:HTTPStatusEvent):void
		{
			
		}
		/**加载进度处理*/
		protected function onProgress(event:ProgressEvent):void
		{
			
		}
		/**加载完成处理*/
		protected function onComplete(event:Event):void
		{
			if(currentLoaderData.callBack != null) currentLoaderData.callBack();//执行回调函数
			if(loaderDatas.length)//若有需要加载的链接
				doLoad();
		}
		/**
		 * 执行加载
		 * @param urls 链接地址数组
		 * @param type 加载方式，true使用Loader加载，false使用URLLoader加载
		 * @param callback 回调函数
		 * @param once 回调函数执行方式，true所有内容加载完成后调用一次，false每次加载完成都调用一次
		 */		
		public function load(loaderDatas:Vector.<LoaderData>):void
		{
			this.loaderDatas = loaderDatas;
			doLoad();
		}
		private function doLoad():void
		{
			currentLoaderData = loaderDatas.shift();
			urlRequest.url = currentLoaderData.url;
			if(currentLoaderData.type)
				loader.load(urlRequest,loaderContext);
			else
				urlLoader.load(urlRequest);
		}
	}
}