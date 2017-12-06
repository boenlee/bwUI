package
{
	import com.boat.bwui.components.StyleUIComponent;
	import com.boat.bwui.components.UIStage;
	import com.boat.bwui.mgr.GlobalUnitHub;
	import com.boat.bwui.mgr.UIComponentManager;
	import com.boat.bwui.render.BaseRenderer;
	import com.boat.bwui.render.BaseUISheetRenderer;
	import com.boat.bwui.render.RenderablePool;
	import com.boat.bwui.render.UIRenderEngine;
	import com.boat.bwui.style.ImageStyleSet;
	import com.boat.bwui.style.frames.PolygonStyleFrame;
	import com.boat.bwui.style.frames.setters.SolidLineSetter;
	import com.boat.bwui.style.frames.setters.RectangleSetter;
	import com.boat.bwui.style.frames.setters.SolidColorSetter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
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
			
			UIStage.instance.getLayer(0).width = 1000;
			UIStage.instance.getLayer(0).height = 1000;
			
			
			var imageStyleSet:ImageStyleSet = new ImageStyleSet();
			imageStyleSet.setStyleFrame(new PolygonStyleFrame(new RectangleSetter(), new SolidColorSetter(0xFF00FF, 1), new SolidLineSetter(1, 0, 0.4), false));
			
			var rectangleComp:StyleUIComponent = new StyleUIComponent("testComp1");
			UIStage.instance.getLayer(0).addChild(rectangleComp);
			
			rectangleComp.x = 10;
			rectangleComp.y = 10;
			rectangleComp.width = 50;
			rectangleComp.height = 50;
			rectangleComp.setStyleSet(imageStyleSet);
			
			
			setTimeout(function():void {
				rectangleComp.width = 600;
				rectangleComp.height = 500;
			}, 3000);
		}
		
	}
	
}
