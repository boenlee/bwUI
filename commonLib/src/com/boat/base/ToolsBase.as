package com.boat.base 
{
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import fl.controls.UIScrollBar;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 
	 */
	public class ToolsBase extends Sprite 
	{
		protected var m_initTextFormat:TextFormat = new TextFormat(null, 12, 0xFFFFFF, null, null, null, null, null, null, null, null, null, 1);
		protected var m_initDisabledTextFormat:TextFormat = new TextFormat(null, 12, 0x999999, null, null, null, null, null, null, null, null, null, 1);
		
		public function ToolsBase() 
		{
			super();
		}
		
		protected function createButton(px:Number, py:Number, pw:Number, ph:Number, text:String, clickCB:Function):Button {
			var btn:Button = new Button();
			btn.x = px;
			btn.y = py;
			btn.width = pw;
			btn.height = ph;
			btn.label = text;
			btn.emphasized = false;
			btn.setStyle("textFormat", m_initTextFormat);
			btn.setStyle("disabledTextFormat", m_initDisabledTextFormat);
			if (clickCB != null) {
				btn.addEventListener(MouseEvent.CLICK, clickCB);
			}
			return btn;
		}
		
		protected function createCheckBox(px:Number, py:Number, pw:Number, ph:Number, text:String, clickCB:Function):CheckBox {
			var ckb:CheckBox = new CheckBox();
			ckb.x = px;
			ckb.y = py;
			ckb.width = pw;
			ckb.height = ph;
			ckb.label = text;			
			ckb.setStyle("textFormat", m_initTextFormat);
			ckb.setStyle("disabledTextFormat", m_initDisabledTextFormat);
			if (clickCB != null) {
				ckb.addEventListener(MouseEvent.CLICK, clickCB);
			}
			return ckb;
		}
		
		protected function createRadioButton(px:Number, py:Number, pw:Number, ph:Number, text:String, data:*):RadioButton {
			var rbtn:RadioButton = new RadioButton();
			rbtn.x = px;
			rbtn.y = py;
			rbtn.width = pw;
			rbtn.height = ph;
			rbtn.label = text;
			rbtn.value = data;
			rbtn.setStyle("textFormat", m_initTextFormat);
			rbtn.setStyle("disabledTextFormat", m_initDisabledTextFormat);
			return rbtn;
		}
		
		protected function createRadioButtonGroup(pname:String, radioButtons:Array, changeCB:Function):RadioButtonGroup {
			var group:RadioButtonGroup = new RadioButtonGroup(pname);
			if (radioButtons) {
				for (var i:int = 0; i < radioButtons.length; i++) {
					group.addRadioButton(radioButtons[i]);
				}
			}
			if (changeCB != null) {
				group.addEventListener(Event.CHANGE, changeCB);
			}
			return group;
		}
		
		protected function createScrollBar(targetTF:TextField):UIScrollBar {
			var sb:UIScrollBar = new UIScrollBar();
			sb.x = targetTF.x + targetTF.width - sb.width;
			sb.y = targetTF.y;
			sb.height = targetTF.height;
			sb.scrollTarget = targetTF;
			return sb;
		}
		
		protected function createTextField(px:Number, py:Number, pw:Number, ph:Number, color:uint, multiline:Boolean, background:Boolean = true, backgroundColor:uint = 0x252525):TextField {
			var tf:TextField = new TextField();
			tf.x = px;
			tf.y = py;
			tf.width = pw;
			tf.height = ph;
			tf.textColor = color;
			tf.background = background;
			if (background) {
				tf.backgroundColor = backgroundColor;
			}
			tf.multiline = multiline;
			tf.wordWrap = true;
			return tf;
		}
		
		protected function createComboBox(px:Number, py:Number, pw:Number, ph:Number):ComboBox {
			var cbb:ComboBox = new ComboBox();
			cbb.x = px;
			cbb.y = py;
			cbb.width = pw;
			cbb.height = ph;
			var tfm:TextFormat = cloneTextFormat(m_initTextFormat);
			tfm.indent = 3;
			cbb.textField.setStyle("textFormat", tfm);
			var disabledTfm:TextFormat = cloneTextFormat(m_initDisabledTextFormat);
			disabledTfm.indent = 3;
			cbb.textField.setStyle("disabledTextFormat", disabledTfm);
			cbb.setStyle("textPadding", 1);
			return cbb;
		}
		
		protected function createDivLine(py:Number, width:uint = 170, color:uint = 0x555555):Shape {
			var line:Shape = new Shape();
			line.graphics.lineStyle(1, color);
			line.graphics.moveTo(0, 0);
			line.graphics.lineTo(width, 0);
			line.y = py;
			return line;
		}
		
		protected function cloneTextFormat(sourceTfm:TextFormat):TextFormat {
			var tfm:TextFormat = new TextFormat();
			tfm.align = sourceTfm.align;
			tfm.blockIndent = sourceTfm.blockIndent;
			tfm.bold = sourceTfm.bold;
			tfm.bullet = sourceTfm.bullet;
			tfm.color = sourceTfm.color;
			tfm.font = sourceTfm.font;
			tfm.indent = sourceTfm.indent;
			tfm.italic = sourceTfm.italic;
			tfm.kerning = sourceTfm.kerning;
			tfm.leading = sourceTfm.leading;
			tfm.leftMargin = sourceTfm.leftMargin;
			tfm.letterSpacing = sourceTfm.letterSpacing;
			tfm.rightMargin = sourceTfm.rightMargin;
			tfm.size = sourceTfm.size;
			tfm.tabStops = sourceTfm.tabStops;
			tfm.target = sourceTfm.target;
			tfm.underline = sourceTfm.underline;
			tfm.url = sourceTfm.url;
			return tfm;
		}
	}

}