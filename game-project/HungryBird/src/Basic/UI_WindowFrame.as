/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_WindowFrame extends fairygui.GLabel
	{
		public var m_dragArea:GGraph;
		public var m_contentArea:GGraph;

		public static const URL:String = "ui://3hcsjton8ymy3g";

		public static function createInstance():UI_WindowFrame
		{
			return UI_WindowFrame(UIPackage.createObject("Basic","WindowFrame"));
		}

		public function UI_WindowFrame()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_dragArea = GGraph(this.getChild("dragArea"));
			m_contentArea = GGraph(this.getChild("contentArea"));
		}
	}
}