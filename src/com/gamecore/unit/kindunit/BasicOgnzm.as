package com.gamecore.unit.kindunit
{
	import com.gamecore.unit.AI.BasicAI;
	import com.gamecore.unit.BasicUnitData;
	import com.gamecore.unit.action.BasicAction;

	/**
	 * 基础生物类
	 * @author Administrator
	 */	
	public class BasicOgnzm extends BasicUnit
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
		/**AI、动作*/
		private var basicAI:BasicAI,basicAction:BasicAction;
		
		public function BasicOgnzm(type:int)
		{
			super(type);
			basicAI = new BasicAI(this);
			basicAction = new BasicAction(this);
		}
		
		override public function update():void
		{
			var basicUnitData:BasicUnitData;
			for each (basicUnitData in units)		
			{
				basicAI.think();
				basicAction.execute(basicAI.towards,basicAI.status);
				/*trace("刷新一个生物，生物ID:"+basicStuff.data[0].id);*/
			}
		}
	}
}