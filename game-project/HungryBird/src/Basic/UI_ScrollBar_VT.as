/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ScrollBar_VT extends fairygui.GScrollBar
	{
		public var m_arrow1:GButton;
		public var m_arrow2:GButton;
		public var m_bar:GGraph;
		public var m_grip:GButton;

		public static const URL:String = "ui://3hcsjton8ymy2x";

		public static function createInstance():UI_ScrollBar_VT
		{
			return UI_ScrollBar_VT(UIPackage.createObject("Basic","ScrollBar_VT"));
		}

		public function UI_ScrollBar_VT()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_arrow1 = GButton(this.getChildAt(1));
			m_arrow2 = GButton(this.getChildAt(2));
			m_bar = GGraph(this.getChildAt(3));
			m_grip = GButton(this.getChildAt(4));
		}
	}
}