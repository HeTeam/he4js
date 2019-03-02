/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_LineContainer extends fairygui.GComponent
	{
		public var m_tmp:GGraph;

		public static const URL:String = "ui://3hcsjtontzto3z";

		public static function createInstance():UI_LineContainer
		{
			return UI_LineContainer(UIPackage.createObject("Basic","LineContainer"));
		}

		public function UI_LineContainer()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_tmp = GGraph(this.getChildAt(0));
		}
	}
}