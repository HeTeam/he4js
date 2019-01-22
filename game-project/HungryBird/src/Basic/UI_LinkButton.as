/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_LinkButton extends fairygui.GButton
	{
		public var m_button:Controller;
		public var m_title:GTextField;

		public static const URL:String = "ui://3hcsjton8ymy8";

		public static function createInstance():UI_LinkButton
		{
			return UI_LinkButton(UIPackage.createObject("Basic","LinkButton"));
		}

		public function UI_LinkButton()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_button = this.getController("button");
			m_title = GTextField(this.getChild("title"));
		}
	}
}