/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_FlatIconButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_n7:GImage;
		public var m_icon:GLoader;

		public static const URL:String = "ui://3hcsjton8ymy5";

		public static function createInstance():UI_FlatIconButton
		{
			return UI_FlatIconButton(UIPackage.createObject("Basic","FlatIconButton"));
		}

		public function UI_FlatIconButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_n7 = GImage(this.getChild("n7"));
			m_icon = GLoader(this.getChild("icon"));
		}
	}
}