/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_NodePanel extends fairygui.GComponent
	{
		public var m_frame:UI_WindowFrame_with_close_btn_and_resizer;

		public static const URL:String = "ui://3hcsjtona4tz3k";

		public static function createInstance():UI_NodePanel
		{
			return UI_NodePanel(UIPackage.createObject("Basic","NodePanel"));
		}

		public function UI_NodePanel()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_frame = UI_WindowFrame_with_close_btn_and_resizer(this.getChildAt(0));
		}
	}
}