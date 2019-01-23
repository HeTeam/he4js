/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_FileTabButton extends fairygui.GButton
	{
		public var m_closeButton:GButton;

		public static const URL:String = "ui://3hcsjton8ymy3a";

		public static function createInstance():UI_FileTabButton
		{
			return UI_FileTabButton(UIPackage.createObject("Basic","FileTabButton"));
		}

		public function UI_FileTabButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_closeButton = GButton(this.getChildAt(3));
		}
	}
}