/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_WindowFrame_with_close_btn_and_resizer extends fairygui.GLabel
	{
		public var m_dragArea:GGraph;
		public var m_contentArea:GGraph;
		public var m_closeButton:GButton;
		public var m_resizer:GComponent;

		public static const URL:String = "ui://3hcsjton8ymy3j";

		public static function createInstance():UI_WindowFrame_with_close_btn_and_resizer
		{
			return UI_WindowFrame_with_close_btn_and_resizer(UIPackage.createObject("Basic","WindowFrame_with_close_btn_and_resizer"));
		}

		public function UI_WindowFrame_with_close_btn_and_resizer()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_dragArea = GGraph(this.getChildAt(1));
			m_contentArea = GGraph(this.getChildAt(2));
			m_closeButton = GButton(this.getChildAt(3));
			m_resizer = GComponent(this.getChildAt(4));
		}
	}
}