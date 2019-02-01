/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_NodePanel extends fairygui.GComponent
	{
		public var m_bg:GGraph;
		public var m_nodeContainer:UI_NodeContainer;
		public var m_help:GTextField;
		public var m_helpOver:GGraph;

		public static const URL:String = "ui://3hcsjtona4tz3k";

		public static function createInstance():UI_NodePanel
		{
			return UI_NodePanel(UIPackage.createObject("Basic","NodePanel"));
		}

		public function UI_NodePanel()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_bg = GGraph(this.getChildAt(0));
			m_nodeContainer = UI_NodeContainer(this.getChildAt(1));
			m_help = GTextField(this.getChildAt(2));
			m_helpOver = GGraph(this.getChildAt(3));
		}
	}
}