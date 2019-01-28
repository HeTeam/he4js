/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_Nut2 extends fairygui.GComponent
	{
		public var m_t0:Transition;

		public static const URL:String = "ui://3hcsjtonxuqg3u";

		public static function createInstance():UI_Nut2
		{
			return UI_Nut2(UIPackage.createObject("Basic","Nut2"));
		}

		public function UI_Nut2()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_t0 = this.getTransitionAt(0);
		}
	}
}