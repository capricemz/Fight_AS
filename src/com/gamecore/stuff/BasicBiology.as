package com.gamecore.stuff
{
	import com.framework.ModuleControl;
	import com.framework.ModuleIds;
	import com.framework.MsgIds;
	import com.gamecore.engine.I_Fs.IStuff;

	/**
	 * 世界基础生物类
	 * @author mz
	 */	
	public class BasicBiology implements IStuff
	{
		/**
		 * 力量
		 * 灵巧
		 * 敏捷
		 * 耐力
		 * 智力
		 * 精神
		 * 意志
		 * 魅力
		 * 感知
		 */
		private var _id:int;
		/**个体集合*/
		private var units:Vector.<BasicStuffData>;
		/**AI、动作*/
		private var basicAI:BasicAI,basicAction:BasicAction;
		
		public function BasicBiology()
		{
			units = new Vector.<BasicStuffData>();
			basicAI = new BasicAI();
			basicAction = new BasicAction();
		}
		public function set id(id:int):void
		{
			this._id = id;
		}
		public function get id():int
		{
			return _id;
		}
		public function addOneStuff(basicStuff:BasicStuffData):void
		{
			basicStuff.id = _id*100+units.length+1;
			units.push(basicStuff);
			//构建body
			var moduleCtrl:ModuleControl = ModuleControl.moduleCtrl();
			var i:int,data:Object;
			for (i=0;i<basicStuff.data.length;i++)
			{
				data = basicStuff.data[i];
				data.id = basicStuff.id*100+i+1;//设置body的id
				moduleCtrl.callModule(ModuleIds.CORE_ENGINE,MsgIds.CORE_ENGINE_CREATE_B2BODY,data);
			}
		}
		public function deleteOneStuff(id:int):void
		{
			units.splice(id,1);
		}
		public function update():void
		{
			var basicStuff:BasicStuffData;
			for each (basicStuff in units)
			{
				basicAI.think();
				basicAction.execute();
				/*trace("刷新一个生物，生物ID:"+basicStuff.data[0].id);*/
			}
		}
	}
}