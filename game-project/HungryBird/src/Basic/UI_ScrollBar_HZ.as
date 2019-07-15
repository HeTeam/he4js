/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ScrollBar_HZ extends fairygui.GScrollBar
	{
		public var m_bar:GGraph;
		public var m_grip:GButton;
		public var m_arrow2:GButton;
		public var m_arrow1:GButton;

		public static const URL:String = "ui://3hcsjton8ymy31";

		public static function createInstance():UI_ScrollBar_HZ
		{
			return UI_ScrollBar_HZ(UIPackage.createObject("Basic","ScrollBar_HZ"));
		}

		public function UI_ScrollBar_HZ()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_bar = GGraph(this.getChild("bar"));
			m_grip = GButton(this.getChild("grip"));
			m_arrow2 = GButton(this.getChild("arrow2"));
			m_arrow1 = GButton(this.getChild("arrow1"));
		}
	}
}