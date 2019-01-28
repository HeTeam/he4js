/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_Nut1 extends fairygui.GComponent
	{
		public var m_t0:Transition;

		public static const URL:String = "ui://3hcsjtonxuqg3t";

		public static function createInstance():UI_Nut1
		{
			return UI_Nut1(UIPackage.createObject("Basic","Nut1"));
		}

		public function UI_Nut1()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_t0 = this.getTransitionAt(0);
		}
	}
}