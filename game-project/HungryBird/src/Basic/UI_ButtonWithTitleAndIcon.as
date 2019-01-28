/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ButtonWithTitleAndIcon extends fairygui.GButton
	{
		public var m_grayed:Controller;

		public static const URL:String = "ui://3hcsjtonxuqg3v";

		public static function createInstance():UI_ButtonWithTitleAndIcon
		{
			return UI_ButtonWithTitleAndIcon(UIPackage.createObject("Basic","ButtonWithTitleAndIcon"));
		}

		public function UI_ButtonWithTitleAndIcon()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_grayed = this.getControllerAt(1);
		}
	}
}