/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_MainPanelBirdContainer extends fairygui.GComponent
	{
		public var m_bird:GGraph;

		public static const URL:String = "ui://3hcsjtonoorc3o";

		public static function createInstance():UI_MainPanelBirdContainer
		{
			return UI_MainPanelBirdContainer(UIPackage.createObject("Basic","MainPanelBirdContainer"));
		}

		public function UI_MainPanelBirdContainer()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_bird = GGraph(this.getChild("bird"));
		}
	}
}