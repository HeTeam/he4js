/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_AutoSizeButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_grayed:Controller;
		public var m_n1:GImage;
		public var m_n2:GImage;
		public var m_n3:GImage;
		public var m_title:GTextField;

		public static const URL:String = "ui://3hcsjton8ymy7";

		public static function createInstance():UI_AutoSizeButton
		{
			return UI_AutoSizeButton(UIPackage.createObject("Basic","AutoSizeButton"));
		}

		public function UI_AutoSizeButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_grayed = this.getController("grayed");
			m_n1 = GImage(this.getChild("n1"));
			m_n2 = GImage(this.getChild("n2"));
			m_n3 = GImage(this.getChild("n3"));
			m_title = GTextField(this.getChild("title"));
		}
	}
}