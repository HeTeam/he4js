/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_MainPanel extends fairygui.GComponent
	{
		public var m_frame:UI_WindowFrame_with_close_btn_and_resizer;

		public static const URL:String = "ui://3hcsjton8ymy3i";

		public static function createInstance():UI_MainPanel
		{
			return UI_MainPanel(UIPackage.createObject("Basic","MainPanel"));
		}

		public function UI_MainPanel()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_frame = UI_WindowFrame_with_close_btn_and_resizer(this.getChildAt(0));
		}
	}
}