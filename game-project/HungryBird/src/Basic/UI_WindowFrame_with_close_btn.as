/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_WindowFrame_with_close_btn extends fairygui.GLabel
	{
		public var m_dragArea:GGraph;
		public var m_contentArea:GGraph;
		public var m_closeButton:GButton;

		public static const URL:String = "ui://3hcsjtona4tz3m";

		public static function createInstance():UI_WindowFrame_with_close_btn
		{
			return UI_WindowFrame_with_close_btn(UIPackage.createObject("Basic","WindowFrame_with_close_btn"));
		}

		public function UI_WindowFrame_with_close_btn()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_dragArea = GGraph(this.getChild("dragArea"));
			m_contentArea = GGraph(this.getChild("contentArea"));
			m_closeButton = GButton(this.getChild("closeButton"));
		}
	}
}