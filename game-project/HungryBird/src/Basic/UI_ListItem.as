/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ListItem extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n0:GImage;
		public var m_n1:GImage;
		public var m_title:GTextField;

		public static const URL:String = "ui://3hcsjton8ymy2o";

		public static function createInstance():UI_ListItem
		{
			return UI_ListItem(UIPackage.createObject("Basic","ListItem"));
		}

		public function UI_ListItem()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n0 = GImage(this.getChild("n0"));
			m_n1 = GImage(this.getChild("n1"));
			m_title = GTextField(this.getChild("title"));
		}
	}
}