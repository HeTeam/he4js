/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_CheckIconListItem extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n4:GImage;
		public var m_n8:GImage;
		public var m_title:GTextField;
		public var m_icon:GLoader;

		public static const URL:String = "ui://3hcsjton8ymy2q";

		public static function createInstance():UI_CheckIconListItem
		{
			return UI_CheckIconListItem(UIPackage.createObject("Basic","CheckIconListItem"));
		}

		public function UI_CheckIconListItem()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n4 = GImage(this.getChild("n4"));
			m_n8 = GImage(this.getChild("n8"));
			m_title = GTextField(this.getChild("title"));
			m_icon = GLoader(this.getChild("icon"));
		}
	}
}