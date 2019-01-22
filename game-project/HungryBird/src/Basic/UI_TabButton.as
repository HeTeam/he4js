/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_TabButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n4:GImage;
		public var m_n5:GImage;
		public var m_title:GTextField;

		public static const URL:String = "ui://3hcsjton8ymy37";

		public static function createInstance():UI_TabButton
		{
			return UI_TabButton(UIPackage.createObject("Basic","TabButton"));
		}

		public function UI_TabButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n4 = GImage(this.getChild("n4"));
			m_n5 = GImage(this.getChild("n5"));
			m_title = GTextField(this.getChild("title"));
		}
	}
}