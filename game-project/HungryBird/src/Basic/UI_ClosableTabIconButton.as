/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ClosableTabIconButton extends fairygui.GButton
	{
		public var m_closeButton:GButton;

		public static const URL:String = "ui://3hcsjton8ymy39";

		public static function createInstance():UI_ClosableTabIconButton
		{
			return UI_ClosableTabIconButton(UIPackage.createObject("Basic","ClosableTabIconButton"));
		}

		public function UI_ClosableTabIconButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_closeButton = GButton(this.getChild("closeButton"));
		}
	}
}