/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_AutoSizeButton extends fairygui.GButton
	{
		public var m_grayed:Controller;

		public static const URL:String = "ui://3hcsjton8ymy7";

		public static function createInstance():UI_AutoSizeButton
		{
			return UI_AutoSizeButton(UIPackage.createObject("Basic","AutoSizeButton"));
		}

		public function UI_AutoSizeButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_grayed = this.getControllerAt(1);
		}
	}
}