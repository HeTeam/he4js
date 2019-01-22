/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_TooltipsWin extends fairygui.GLabel
	{
		public var m_n1:GGraph;
		public var m_title:GTextField;

		public static const URL:String = "ui://3hcsjton8ymy3c";

		public static function createInstance():UI_TooltipsWin
		{
			return UI_TooltipsWin(UIPackage.createObject("Basic","TooltipsWin"));
		}

		public function UI_TooltipsWin()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_n1 = GGraph(this.getChild("n1"));
			m_title = GTextField(this.getChild("title"));
		}
	}
}