/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ClosableTabButton extends fairygui.GButton
	{
		public var m_closeButton:GButton;

		public static const URL:String = "ui://3hcsjton8ymy36";

		public static function createInstance():UI_ClosableTabButton
		{
			return UI_ClosableTabButton(UIPackage.createObject("Basic","ClosableTabButton"));
		}

		public function UI_ClosableTabButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_closeButton = GButton(this.getChild("closeButton"));
		}
	}
}