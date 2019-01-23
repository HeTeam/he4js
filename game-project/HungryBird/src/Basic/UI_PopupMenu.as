/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_PopupMenu extends fairygui.GComponent
	{
		public var m_list:GList;

		public static const URL:String = "ui://3hcsjton8ymy2u";

		public static function createInstance():UI_PopupMenu
		{
			return UI_PopupMenu(UIPackage.createObject("Basic","PopupMenu"));
		}

		public function UI_PopupMenu()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_list = GList(this.getChildAt(1));
		}
	}
}