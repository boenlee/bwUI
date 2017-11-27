package com.boat.base
{
	
	import com.boat.agent.layout.DisplayAlignAgent;
	import com.boat.agent.layout.DisplayAlignType;
	import com.boat.agent.ui.ScrollBarTextFieldAgent;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	

	public class ToolsBaseUI extends ToolsBase
	{
		protected var m_pathSelContainer:SectionContainer;
		protected var m_processDisplayContainer:SectionContainer;
		protected var m_controllerContainer:SectionContainer;
		protected var m_extendControllerContainer:SectionContainer;
		
		protected var m_sourcePathSelBtn:Button;
		protected var m_sourcePathTxt:TextField;
		
		protected var m_savePathSelBtn:Button;
		protected var m_savePathTxt:TextField;
		protected var m_setDefaultSavePathBtn:Button;
		
		protected var m_configFileSelBtn:Button;
		protected var m_configPathTxt:TextField;
		protected var m_clearConfigPathBtn:Button;
		
		protected var m_processStatusTxt:TextField;
		protected var m_processTxt:TextField;
		protected var m_errTxt:TextField;
		protected var m_crtFileInfoTxt:TextField;
		protected var m_logSbTxt:ScrollBarTextFieldAgent;
		protected var m_errLogSbTxt:ScrollBarTextFieldAgent;
		
		protected var m_startBtn:Button;
		protected var m_pauseBtn:Button;
		protected var m_stopBtn:Button;
		protected var m_saveLogBtn:Button;
		protected var m_clearLogBtn:Button;
		
		protected var m_closeWhenFinishCheck:CheckBox;
		protected var m_autoSaveLogCheck:CheckBox;
		protected var m_breakWhenErrCheck:CheckBox;
		
		protected var m_singleLineHeight:uint = 22;
		protected var m_excuteInterval:uint = 10;
		protected var m_logWidth:Number = 790;
		
		protected var m_hasSource:Boolean = true;
		protected var m_needSource:Boolean = true;
		protected var m_hasSave:Boolean = true;
		protected var m_needSave:Boolean = true;
		protected var m_hasConfigFile:Boolean = false;
		protected var m_needConfigFile:Boolean = false;
		
		protected var mDisplayAlignAgent:DisplayAlignAgent;
		
		public function ToolsBaseUI()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener(Event.RESIZE, onStageResize);
			stage.nativeWindow.addEventListener(Event.CLOSING, onWindowClosing);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvokeEvent);
			baseInit();
			initViewData();
		}
		
		private function baseInit():void {
			
			m_pathSelContainer = new SectionContainer();
			m_pathSelContainer.x = 5;
			addChild(m_pathSelContainer);
			
			m_processDisplayContainer = new SectionContainer();
			m_processDisplayContainer.x = 5;
			addChild(m_processDisplayContainer);
			
			m_controllerContainer = new SectionContainer();
			m_controllerContainer.x = 815;
			addChild(m_controllerContainer);
			
			m_extendControllerContainer = new SectionContainer();
			m_extendControllerContainer.x = 815;
			addChild(m_extendControllerContainer);
			
			/**
			 * 路径选择界面初始化
			 */
			var posY:uint = 5;
			m_pathSelContainer.y = posY;
			
			var subPosY:uint = 0;
			if (m_hasSource) {
				m_sourcePathSelBtn = createButton(0, subPosY, 100, m_singleLineHeight, "选择资源路径", onSourcePathSelClick);
				m_pathSelContainer.addChild(m_sourcePathSelBtn);
				
				m_sourcePathTxt = createTextField(105, subPosY, 685, m_singleLineHeight, 0xFFFFFF, false);
				m_pathSelContainer.addChildWidthAlign(m_sourcePathTxt, DisplayAlignType.HORZ_JUSTIFY);
				
				subPosY += m_singleLineHeight + 5;
			}
			
			if (m_hasSave) {
				m_savePathSelBtn = createButton(0, subPosY, 100, m_singleLineHeight, "选择保存路径", onSavePathSelClick);
				m_pathSelContainer.addChild(m_savePathSelBtn);
				
				m_savePathTxt = createTextField(105, subPosY, 580, m_singleLineHeight, 0xFFFFFF, false);
				m_pathSelContainer.addChildWidthAlign(m_savePathTxt, DisplayAlignType.HORZ_JUSTIFY);
				
				m_setDefaultSavePathBtn = createButton(690, subPosY, 100, m_singleLineHeight, "使用默认值", onSetDefaultSavePathClick);
				m_pathSelContainer.addChildWidthAlign(m_setDefaultSavePathBtn, DisplayAlignType.RIGHT);
				
				subPosY += m_singleLineHeight + 5;
			}
			
			if (m_hasConfigFile) {
				m_configFileSelBtn = createButton(0, subPosY, 100, m_singleLineHeight, "选择配置文件", onConfigFileSelClick);
				m_pathSelContainer.addChild(m_configFileSelBtn);
				
				m_configPathTxt = createTextField(105, subPosY, 580, m_singleLineHeight, 0xFFFFFF, false);
				m_pathSelContainer.addChildWidthAlign(m_configPathTxt, DisplayAlignType.HORZ_JUSTIFY);
				
				m_clearConfigPathBtn = createButton(690, subPosY, 100, m_singleLineHeight, "清空配置文件", onClearConfigPathClick);
				m_pathSelContainer.addChildWidthAlign(m_clearConfigPathBtn, DisplayAlignType.RIGHT);
				
				subPosY += m_singleLineHeight + 5;
			}
			
			/**
			 * 处理过程信息界面初始化
			 */
			posY += subPosY;
			m_processDisplayContainer.y = posY;
			
			subPosY = 0;
			m_processStatusTxt = createTextField(0, subPosY, 100, m_singleLineHeight, 0xFF00FF, false);
			m_processDisplayContainer.addChild(m_processStatusTxt);
			
			m_processTxt = createTextField(105, subPosY, 200, m_singleLineHeight, 0x00FF00, false);
			m_processDisplayContainer.addChild(m_processTxt);
			
			m_errTxt = createTextField(310, subPosY, 200, m_singleLineHeight, 0xFF0000, false);
			m_processDisplayContainer.addChild(m_errTxt);
			
			subPosY += m_singleLineHeight + 5;
			m_crtFileInfoTxt = createTextField(0, subPosY, 790, m_singleLineHeight, 0xFFFFFF, false);
			m_processDisplayContainer.addChildWidthAlign(m_crtFileInfoTxt, DisplayAlignType.HORZ_JUSTIFY);
			
			subPosY += m_singleLineHeight + 5;
			var errLogHeight:Number = 135;
			var logHeight:Number = 600 - (m_processDisplayContainer.y + m_crtFileInfoTxt.y + m_crtFileInfoTxt.height + errLogHeight + 15);
			var logBottomPercent:Number = 70;
			
			m_logSbTxt = new ScrollBarTextFieldAgent(createTextField(0, subPosY, m_logWidth, logHeight, 0xEEDD44, true), true);
			m_logSbTxt.isAlwaysScrollToEnd = true;
			m_processDisplayContainer.addChildWidthAlign(m_logSbTxt, DisplayAlignType.HORZ_JUSTIFY | DisplayAlignType.VERT_JUSTIFY, [null, null, null, logBottomPercent + "%-2"]);
			
			subPosY = m_logSbTxt.y + m_logSbTxt.height + 5;			
			m_errLogSbTxt = new ScrollBarTextFieldAgent(createTextField(0, subPosY, m_logWidth, errLogHeight, 0xEE0000, true), true);
			m_errLogSbTxt.isAlwaysScrollToEnd = true;
			m_processDisplayContainer.addChildWidthAlign(m_errLogSbTxt, DisplayAlignType.HORZ_JUSTIFY | DisplayAlignType.VERT_JUSTIFY, [null, logBottomPercent + "%+3", null, null]);
			
			/**
			 * 初始化控制界面
			 */
			posY = 5;
			m_controllerContainer.y = posY;
			
			subPosY = 0;
			m_startBtn = createButton(0, subPosY, 100, m_singleLineHeight, "开始处理", onStartClick);
			m_controllerContainer.addChild(m_startBtn);
			
			m_pauseBtn = createButton(0, subPosY, 100, m_singleLineHeight, "中断处理", onPauseClick);
			m_pauseBtn.visible = false;
			m_controllerContainer.addChild(m_pauseBtn);
			
			subPosY += m_singleLineHeight + 10;
			m_stopBtn = createButton(0, subPosY, 100, m_singleLineHeight, "终止处理", onStopClick);
			m_controllerContainer.addChild(m_stopBtn);
			
			subPosY += m_singleLineHeight + 20;
			m_closeWhenFinishCheck = createCheckBox(-5, subPosY, 150, m_singleLineHeight, "处理结束自动关闭", onCloseWhenFinishClick);
			m_controllerContainer.addChild(m_closeWhenFinishCheck);
			
			subPosY += m_singleLineHeight + 5;
			m_autoSaveLogCheck = createCheckBox(-5, subPosY, 150, m_singleLineHeight, "完毕自动保存Log", onAutoSaveLogClick);
			m_controllerContainer.addChild(m_autoSaveLogCheck);
			
			subPosY += m_singleLineHeight + 5;
			m_breakWhenErrCheck = createCheckBox(-5, subPosY, 150, m_singleLineHeight, "遇错中断", onBreakWhenErrClick);
			m_controllerContainer.addChild(m_breakWhenErrCheck);
			
			subPosY += m_singleLineHeight + 20;
			m_saveLogBtn = createButton(0, subPosY, 100, m_singleLineHeight, "保存Log文件", onSaveLogClick);
			m_controllerContainer.addChild(m_saveLogBtn);
			
			subPosY += m_singleLineHeight + 5;
			m_clearLogBtn = createButton(0, subPosY, 100, m_singleLineHeight, "清空Log", onClearLogClick);
			m_controllerContainer.addChild(m_clearLogBtn);
			
			posY += m_clearLogBtn.y + m_clearLogBtn.height + 30;
			m_extendControllerContainer.y = posY;
			
			initViewData();
			
			m_pathSelContainer.InitSize();
			m_processDisplayContainer.InitSize();
			m_controllerContainer.InitSize();
			m_extendControllerContainer.InitSize();
			
			mDisplayAlignAgent = new DisplayAlignAgent(1000, 600);
			mDisplayAlignAgent.addAgentItem(m_pathSelContainer, DisplayAlignType.HORZ_JUSTIFY);
			mDisplayAlignAgent.addAgentItem(m_processDisplayContainer, DisplayAlignType.HORZ_JUSTIFY | DisplayAlignType.VERT_JUSTIFY);
			mDisplayAlignAgent.addAgentItem(m_controllerContainer, DisplayAlignType.RIGHT);
			mDisplayAlignAgent.addAgentItem(m_extendControllerContainer, DisplayAlignType.RIGHT | DisplayAlignType.VERT_JUSTIFY);
		}
		
		protected function addExtendController(comp:DisplayObject):void {
			if (m_extendControllerContainer && comp) {
				m_extendControllerContainer.addChild(comp);
			}
		}
		
		protected function onStageResize(e:Event):void 
		{
			mDisplayAlignAgent.refreshAlign(stage.stageWidth, stage.stageHeight);
		}
		
		protected function onAutoSaveLogClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onBreakWhenErrClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onClearConfigPathClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onClearLogClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onCloseWhenFinishClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onConfigFileSelClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onPauseClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onSaveLogClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onSavePathSelClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onSetDefaultSavePathClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onSourcePathSelClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onStartClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function onStopClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function initViewData():void
		{
			// TODO Auto Generated method stub
		}
		
		protected function onInvokeEvent(event:InvokeEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onWindowClosing(e:Event):void 
		{
			
		}
		
	}
}
import com.boat.agent.layout.DisplayAlignAgent;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

class SectionContainer extends Sprite
{
	private var mChildAlignList:Array = [];
	private var mChildMarginList:Array = [];
	private var mDisplayAlignAgent:DisplayAlignAgent;
	
	private var mDisplayWidth:Number = 0;
	private var mDisplayHeight:Number = 0;
	
	public function SectionContainer()
	{
		mDisplayAlignAgent = new DisplayAlignAgent(0, 0);
	}
	
	override public function get width():Number 
	{
		return mDisplayWidth;
	}
	
	override public function set width(value:Number):void 
	{
		mDisplayWidth = value;
		onResize();
	}
	
	override public function get height():Number 
	{
		return mDisplayHeight;
	}
	
	override public function set height(value:Number):void 
	{
		mDisplayHeight = value;
		onResize();
	}
	
	public function addChildWidthAlign(child:DisplayObject, align:int, margin:Array = null):DisplayObject
	{
		mChildAlignList[numChildren] = align;
		mChildMarginList[numChildren] = margin;
		return addChild(child);
	}
	
	private function onResize():void
	{
		mDisplayAlignAgent.refreshAlign(mDisplayWidth, mDisplayHeight);
	}
	
	public function InitSize():void
	{
		var child:DisplayObject;
		var i:int = 0;
		/*
		var unionRect:Rectangle = new Rectangle();
		while (i < numChildren) {
			child = getChildAt(i++);
			unionRect = unionRect.union(child.getBounds(this));
		}
		mDisplayWidth = unionRect.width;
		mDisplayHeight = unionRect.height;
		*/
		mDisplayWidth = super.width;
		mDisplayHeight = super.height;
		mDisplayAlignAgent.initParentSize(mDisplayWidth, mDisplayHeight);
		
		i = 0;
		while (i < numChildren) {
			child = getChildAt(i);
			if (mChildAlignList[i] != undefined) {
				mDisplayAlignAgent.addAgentItem(child, mChildAlignList[i], mChildMarginList[i]);
			}
			i++;
		}
	}
}