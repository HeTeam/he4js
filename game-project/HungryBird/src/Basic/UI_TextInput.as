/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_TextInput extends fairygui.GLabel
	{
		public var m_grayed:Controller;
		public var m_n0:GImage;
		public var m_n4:GImage;
		public var m_title:GTextInput;

		public static const URL:String = "ui://3hcsjton8ymy2l";

		public static function createInstance():UI_TextInput
		{
			return UI_TextInput(UIPackage.createObject("Basic","TextInput"));
		}

		public function UI_TextInput()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_grayed = this.getController("grayed");
			m_n0 = GImage(this.getChild("n0"));
			m_n4 = GImage(this.getChild("n4"));
			m_title = GTextInput(this.getChild("title"));
		}
	}
}