/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_WindowCloseButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n1:GImage;
		public var m_n2:GImage;
		public var m_n3:GImage;

		public static const URL:String = "ui://3hcsjton8ymy3h";

		public static function createInstance():UI_WindowCloseButton
		{
			return UI_WindowCloseButton(UIPackage.createObject("Basic","WindowCloseButton"));
		}

		public function UI_WindowCloseButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n1 = GImage(this.getChild("n1"));
			m_n2 = GImage(this.getChild("n2"));
			m_n3 = GImage(this.getChild("n3"));
		}
	}
}