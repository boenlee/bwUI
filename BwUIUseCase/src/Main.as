package
{
	import com.boat.bwui.components.UIStage;
	import com.boat.bwui.mgr.GlobalUnitHub;
	import com.boat.bwui.mgr.UIComponentManager;
	import com.boat.bwui.render.BaseRenderer;
	import com.boat.bwui.render.BaseUISheetRenderer;
	import com.boat.bwui.render.RenderablePool;
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
			var uiRootRenderer:BaseUISheetRenderer = new BaseUISheetRenderer();
			addChild(uiRootRenderer);
			UIStage.instance.move(0, 0);
			UIStage.instance.setSize(stage.stageWidth, stage.stageHeight);
			UIStage.instance.init(uiRootRenderer);
			UIRenderEngine.instance.init();
			
			UIStage.instance.createLayer("layer0", 0);
			UIStage.instance.createLayer("layer1", 1);
			
			RenderablePool.instance.init(UIStage.instance);
			
			GlobalUnitHub.uiStage = UIStage.instance;
			GlobalUnitHub.uiComponentManager = UIComponentManager.instance;
			GlobalUnitHub.uiRenderEngine = UIRenderEngine.instance;
			GlobalUnitHub.renderablePool = RenderablePool.instance;
			
			UIStage.instance.getLayer(0).width = 100;
			UIStage.instance.getLayer(0).height = 100;
			
		}
		
	}
	
}
