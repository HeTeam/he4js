/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ComboBoxItem extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n2:GGraph;
		public var m_title:GTextField;

		public static const URL:String = "ui://3hcsjton8ymyi";

		public static function createInstance():UI_ComboBoxItem
		{
			return UI_ComboBoxItem(UIPackage.createObject("Basic","ComboBoxItem"));
		}

		public function UI_ComboBoxItem()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n2 = GGraph(this.getChild("n2"));
			m_title = GTextField(this.getChild("title"));
		}
	}
}