/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_MainPanel extends fairygui.GComponent
	{
		public var m_selnut:Controller;
		public var m_frame:UI_WindowFrame_with_close_btn_and_resizer;
		public var m_container:UI_MainPanelBirdContainer;
		public var m_title:GTextField;
		public var m_btn_nut0:UI_ButtonWithTitleAndIcon;
		public var m_btn_nut1:UI_ButtonWithTitleAndIcon;

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

			m_selnut = this.getControllerAt(0);
			m_frame = UI_WindowFrame_with_close_btn_and_resizer(this.getChildAt(0));
			m_container = UI_MainPanelBirdContainer(this.getChildAt(1));
			m_title = GTextField(this.getChildAt(2));
			m_btn_nut0 = UI_ButtonWithTitleAndIcon(this.getChildAt(3));
			m_btn_nut1 = UI_ButtonWithTitleAndIcon(this.getChildAt(4));
		}
	}
}