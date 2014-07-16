package
{
	import com.util.layers.Layers;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	
	[SWF(frameRate="30",width="800",height="600")]
	public class Main extends Sprite
	{
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP;
			stage.quality = StageQuality.BEST;
			stage.stageFocusRect = false;
			//初始化显示层
			Layers.inst.setStage(this);
			//进行游戏相关初始化
			var mainHandle:MainHandle = new MainHandle();
			mainHandle.loadres();
		}
	}
}