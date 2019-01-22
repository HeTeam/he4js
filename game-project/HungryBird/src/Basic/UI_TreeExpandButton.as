/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_TreeExpandButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n1:GImage;
		public var m_n2:GImage;

		public static const URL:String = "ui://3hcsjton8ymy3e";

		public static function createInstance():UI_TreeExpandButton
		{
			return UI_TreeExpandButton(UIPackage.createObject("Basic","TreeExpandButton"));
		}

		public function UI_TreeExpandButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n1 = GImage(this.getChild("n1"));
			m_n2 = GImage(this.getChild("n2"));
		}
	}
}