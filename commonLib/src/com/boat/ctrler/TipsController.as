package com.boat.ctrler
{
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.clearTimeout;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author 
	 */
	public class TipsController 
	{
		private static const TipsOffset:Point = new Point(0, 25);
		
		private static var mStage:Stage;
		
		private static var mInteractiveObjDic:Dictionary;
		private static var mTipsDic:Dictionary;
		
		private static var mTipsPanel:Sprite;
		private static var mTipsBg:Shape;
		private static var mTipsTxt:TextField;
		
		private static var mTimeOutID:int = 0;
		
		public function TipsController() 
		{
			
		}
		
		public static function init(stage:Stage):void {
			mStage = stage;
			mInteractiveObjDic = new Dictionary();
			mTipsDic = new Dictionary();
		}
		
		public static function addTipsOn(interactiveObj:InteractiveObject, tips:String):void {
			if (!interactiveObj) {
				return;
			}
			if (!mInteractiveObjDic[interactiveObj]) {
				mInteractiveObjDic[interactiveObj] = interactiveObj;
				interactiveObj.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
			mTipsDic[interactiveObj] = tips;
		}
		
		public static function removeTipsObj(interactiveObj:InteractiveObject):void {
			if (!interactiveObj) {
				return;
			}
			if (mInteractiveObjDic[interactiveObj]) {
				interactiveObj.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				delete mInteractiveObjDic[interactiveObj];
				delete mTipsDic[interactiveObj];
			}
		}
		
		static private function onMouseOver(e:MouseEvent):void 
		{
			var interactiveObj:InteractiveObject = e.currentTarget as InteractiveObject;
			interactiveObj.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			clearTimeout(mTimeOutID);
			mTimeOutID = setTimeout(showTips, 500, interactiveObj);
		}
		
		static private function onMouseOut(e:MouseEvent):void 
		{
			clearTimeout(mTimeOutID);
			var interactiveObj:InteractiveObject = e.currentTarget as InteractiveObject;
			interactiveObj.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			interactiveObj.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			hideTips();
		}
		
		static private function onMouseMove(e:MouseEvent):void 
		{
			updateTipsPosition();
		}
		
		static private function showTips(interactiveObj:InteractiveObject):void {
			if (!mTipsPanel) {
				mTipsPanel = new Sprite();
				mTipsPanel.mouseEnabled = mTipsPanel.mouseChildren = false;
				
				mTipsBg = new Shape();
				mTipsPanel.addChild(mTipsBg);
				
				mTipsTxt = new TextField();
				mTipsTxt.x = 2;
				mTipsTxt.y = 0;
				mTipsTxt.autoSize = TextFieldAutoSize.LEFT;
				mTipsTxt.width = 500;
				mTipsTxt.border = false;
				mTipsTxt.multiline = mTipsTxt.wordWrap = true;
				mTipsPanel.addChild(mTipsTxt);
			}
			mTipsTxt.htmlText = mTipsDic[interactiveObj] || "";
			mTipsBg.graphics.clear();
			mTipsBg.graphics.beginFill(0xFFFFCC);
			mTipsBg.graphics.lineStyle(1, 0x000000, 1);
			mTipsBg.graphics.drawRect(0, 0, mTipsTxt.textWidth + 6, mTipsTxt.textHeight + 4);
			mTipsBg.graphics.endFill();
			
			mStage.addChild(mTipsPanel);
			
			updateTipsPosition();
			
			interactiveObj.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		static private function updateTipsPosition():void {
			
			var px:Number = mStage.mouseX;
			var py:Number = mStage.mouseY;
			
			if ((px + mTipsBg.width + TipsOffset.x) > mStage.stageWidth) {
				px = mStage.stageWidth - mTipsBg.width - TipsOffset.x;
			}
			if ((py + mTipsBg.height + TipsOffset.y) > mStage.stageHeight) {
				py -= mTipsBg.height + TipsOffset.y;
			}
			
			mTipsPanel.x = px + TipsOffset.x;
			mTipsPanel.y = py + TipsOffset.y;
		}
		
		static private function hideTips():void {
			if (mTipsPanel && mStage.contains(mTipsPanel)) {
				mStage.removeChild(mTipsPanel);
			}
		}
	}

}