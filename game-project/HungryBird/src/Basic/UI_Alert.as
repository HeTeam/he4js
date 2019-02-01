/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_Alert extends fairygui.GComponent
	{
		public var m_c1:Controller;
		public var m_frame:UI_WindowFrame_with_close_btn;
		public var m_title:GTextField;
		public var m_txt:GTextField;
		public var m_btnOK:UI_Button;
		public var m_btnNO:UI_Button;
		public var m_input_bg:GGraph;
		public var m_input:GTextInput;

		public static const URL:String = "ui://3hcsjtonch2w3x";

		public static function createInstance():UI_Alert
		{
			return UI_Alert(UIPackage.createObject("Basic","Alert"));
		}

		public function UI_Alert()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_c1 = this.getControllerAt(0);
			m_frame = UI_WindowFrame_with_close_btn(this.getChildAt(0));
			m_title = GTextField(this.getChildAt(1));
			m_txt = GTextField(this.getChildAt(2));
			m_btnOK = UI_Button(this.getChildAt(3));
			m_btnNO = UI_Button(this.getChildAt(4));
			m_input_bg = GGraph(this.getChildAt(5));
			m_input = GTextInput(this.getChildAt(6));
		}
	}
}