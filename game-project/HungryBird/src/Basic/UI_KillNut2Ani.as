/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_KillNut2Ani extends fairygui.GComponent
	{
		public var m_t1:Transition;

		public static const URL:String = "ui://3hcsjtonlb7q41";

		public static function createInstance():UI_KillNut2Ani
		{
			return UI_KillNut2Ani(UIPackage.createObject("Basic","KillNut2Ani"));
		}

		public function UI_KillNut2Ani()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_t1 = this.getTransition("t1");
		}
	}
}