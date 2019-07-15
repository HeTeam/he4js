/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_Button extends fairygui.GButton
	{
		public var m_grayed:Controller;

		public static const URL:String = "ui://3hcsjton8ymy1";

		public static function createInstance():UI_Button
		{
			return UI_Button(UIPackage.createObject("Basic","Button"));
		}

		public function UI_Button()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_grayed = this.getController("grayed");
		}
	}
}