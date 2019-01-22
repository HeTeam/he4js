/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ClosableTabButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n5:GImage;
		public var m_n4:GImage;
		public var m_title:GTextField;
		public var m_closeButton:UI_TabCloseButton;

		public static const URL:String = "ui://3hcsjton8ymy36";

		public static function createInstance():UI_ClosableTabButton
		{
			return UI_ClosableTabButton(UIPackage.createObject("Basic","ClosableTabButton"));
		}

		public function UI_ClosableTabButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n5 = GImage(this.getChild("n5"));
			m_n4 = GImage(this.getChild("n4"));
			m_title = GTextField(this.getChild("title"));
			m_closeButton = UI_TabCloseButton(this.getChild("closeButton"));
		}
	}
}