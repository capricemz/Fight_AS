package com.util.layers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	/**
	 * 显示层类
	 * @author mz
	 */	
	public class Layers
	{
		private static var _inst:Layers;
		public static function get inst():Layers
		{
			if(!_inst)
				_inst = new Layers(hiddle);
			return _inst
		}
		private static function hiddle():void{};
		
		public function Layers(fun:Function)
		{
			super();
			if(fun != hiddle)
				throw new Error("只能用getInst()来获取实例");
		}
		public var stage:Stage;
		//AS项目中使用
		/**主显示层*/
		public var layerMain:Sprite;
		/**工具提示层*/
		public var layerToolTips:Sprite;
		/**弹出提示框层*/
		public var layerTipBox:Sprite;
		//flex项目中使用
//		/**主显示层*/
//		public var layerMain:UIComponent;
//		/**工具提示层*/
//		public var layerToolTips:UIComponent;
//		/**弹出提示框层*/
//		public var layerTipBox:UIComponent;
		
		public function setStage(displayObjectContainer:DisplayObjectContainer):void
		{
			this.stage = displayObjectContainer.stage;
			layerMain = new Sprite();
			layerMain.mouseEnabled = false;
			layerMain.tabEnabled = false;
			stage.addChild(layerMain);
			
			layerToolTips = new Sprite();
			layerToolTips.mouseEnabled = false;
			layerToolTips.tabEnabled = false;
			stage.addChild(layerToolTips);
			
			layerTipBox = new Sprite();
			layerTipBox.mouseEnabled = false;
			layerTipBox.tabEnabled = false;
			stage.addChild(layerTipBox);
			
//			layerMain = new UIComponent();
//			layerMain.mouseEnabled = false;
//			layerMain.tabEnabled = false;
//			displayObjectContainer.addChild(layerMain);
//			
//			layerToolTips = new UIComponent();
//			layerToolTips.mouseEnabled = false;
//			layerToolTips.tabEnabled = false;
//			displayObjectContainer.addChild(layerToolTips);
//			
//			layerTipBox = new UIComponent();
//			layerTipBox.mouseEnabled = false;
//			layerTipBox.tabEnabled = false;
//			displayObjectContainer.addChild(layerTipBox);
		}
		/**开关输入控制*/
		public function switchInputCtrl(boolean:Boolean):void
		{
			stage.mouseChildren = boolean;
		}
	}
}