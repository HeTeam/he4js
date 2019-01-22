/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_IconButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n7:GImage;
		public var m_n5:GImage;
		public var m_n6:GImage;
		public var m_icon:GLoader;

		public static const URL:String = "ui://3hcsjton8ymy6";

		public static function createInstance():UI_IconButton
		{
			return UI_IconButton(UIPackage.createObject("Basic","IconButton"));
		}

		public function UI_IconButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n7 = GImage(this.getChild("n7"));
			m_n5 = GImage(this.getChild("n5"));
			m_n6 = GImage(this.getChild("n6"));
			m_icon = GLoader(this.getChild("icon"));
		}
	}
}