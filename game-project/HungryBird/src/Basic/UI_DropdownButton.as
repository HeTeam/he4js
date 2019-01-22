/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_DropdownButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n1:GImage;
		public var m_n2:GImage;
		public var m_n3:GImage;
		public var m_n5:GImage;
		public var m_title:GTextField;

		public static const URL:String = "ui://3hcsjton8ymyj";

		public static function createInstance():UI_DropdownButton
		{
			return UI_DropdownButton(UIPackage.createObject("Basic","DropdownButton"));
		}

		public function UI_DropdownButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n1 = GImage(this.getChild("n1"));
			m_n2 = GImage(this.getChild("n2"));
			m_n3 = GImage(this.getChild("n3"));
			m_n5 = GImage(this.getChild("n5"));
			m_title = GTextField(this.getChild("title"));
		}
	}
}