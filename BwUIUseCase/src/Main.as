package
{
	import com.boat.bwui.components.UIStage;
	import com.boat.bwui.render.BaseRenderer;
	import com.boat.bwui.render.UIRenderEngine;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boen
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initView();
		}
		
		private function initView():void
		{
			var uiRootRender:BaseRenderer = new BaseRenderer();
			addChild(uiRootRender);
			UIStage.instance.x = 0;
			UIStage.instance.y = 0;
			UIStage.instance.width = stage.stageWidth;
			UIStage.instance.height = stage.stageHeight;
			UIStage.instance.init(uiRootRender);
			UIRenderEngine.instance.init(uiRootRender);
			
			UIStage.instance.createLayer("layer0", 0);
			UIStage.instance.createLayer("layer1", 1);
			
			trace(UIStage.instance);
		}
		
	}
	
}
