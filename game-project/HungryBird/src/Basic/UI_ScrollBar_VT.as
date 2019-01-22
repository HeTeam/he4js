/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ScrollBar_VT extends fairygui.GScrollBar
	{
		public var m_n0:GImage;
		public var m_arrow1:UI_ScrollUpButton;
		public var m_arrow2:UI_ScrollDownButton;
		public var m_bar:GGraph;
		public var m_grip:UI_GripButton_VT;

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

			m_n0 = GImage(this.getChild("n0"));
			m_arrow1 = UI_ScrollUpButton(this.getChild("arrow1"));
			m_arrow2 = UI_ScrollDownButton(this.getChild("arrow2"));
			m_bar = GGraph(this.getChild("bar"));
			m_grip = UI_GripButton_VT(this.getChild("grip"));
		}
	}
}