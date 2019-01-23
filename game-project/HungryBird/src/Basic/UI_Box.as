/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_Box extends fairygui.GComponent
	{
		public var m_bg:GGraph;
		public var m_blink:GGraph;
		public var m_blinkMV:Transition;

		public static const URL:String = "ui://3hcsjtonifv90";

		public static function createInstance():UI_Box
		{
			return UI_Box(UIPackage.createObject("Basic","Box"));
		}

		public function UI_Box()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_bg = GGraph(this.getChildAt(0));
			m_blink = GGraph(this.getChildAt(1));
			m_blinkMV = this.getTransitionAt(0);
		}
	}
}