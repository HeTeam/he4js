/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_Mask extends fairygui.GComponent
	{
		public var m_bg:GGraph;

		public static const URL:String = "ui://3hcsjtonch2w3y";

		public static function createInstance():UI_Mask
		{
			return UI_Mask(UIPackage.createObject("Basic","Mask"));
		}

		public function UI_Mask()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_bg = GGraph(this.getChildAt(0));
		}
	}
}