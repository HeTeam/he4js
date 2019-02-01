/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_NodeContainer extends fairygui.GComponent
	{
		public var m_tmp:GGraph;

		public static const URL:String = "ui://3hcsjtonch2w3w";

		public static function createInstance():UI_NodeContainer
		{
			return UI_NodeContainer(UIPackage.createObject("Basic","NodeContainer"));
		}

		public function UI_NodeContainer()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_tmp = GGraph(this.getChildAt(0));
		}
	}
}