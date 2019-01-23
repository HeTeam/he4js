/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_NumericInput extends fairygui.GLabel
	{
		public var m_c1:Controller;
		public var m_grayed:Controller;
		public var m_holder:GGraph;

		public static const URL:String = "ui://3hcsjton8ymy2m";

		public static function createInstance():UI_NumericInput
		{
			return UI_NumericInput(UIPackage.createObject("Basic","NumericInput"));
		}

		public function UI_NumericInput()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_c1 = this.getControllerAt(0);
			m_grayed = this.getControllerAt(1);
			m_holder = GGraph(this.getChildAt(2));
		}
	}
}