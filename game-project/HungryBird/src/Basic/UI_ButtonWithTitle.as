/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ButtonWithTitle extends fairygui.GButton
	{
		public var m_grayed:Controller;

		public static const URL:String = "ui://3hcsjtonf6tz40";

		public static function createInstance():UI_ButtonWithTitle
		{
			return UI_ButtonWithTitle(UIPackage.createObject("Basic","ButtonWithTitle"));
		}

		public function UI_ButtonWithTitle()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_grayed = this.getController("grayed");
		}
	}
}