/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_IconListItem extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n0:GImage;
		public var m_n1:GImage;
		public var m_title:GTextField;
		public var m_icon:GLoader;

		public static const URL:String = "ui://3hcsjton8ymy2p";

		public static function createInstance():UI_IconListItem
		{
			return UI_IconListItem(UIPackage.createObject("Basic","IconListItem"));
		}

		public function UI_IconListItem()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n0 = GImage(this.getChild("n0"));
			m_n1 = GImage(this.getChild("n1"));
			m_title = GTextField(this.getChild("title"));
			m_icon = GLoader(this.getChild("icon"));
		}
	}
}