/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_ProgressBar extends fairygui.GProgressBar
	{
		public var m_n0:GImage;
		public var m_bar:GImage;

		public static const URL:String = "ui://3hcsjton8ymy2v";

		public static function createInstance():UI_ProgressBar
		{
			return UI_ProgressBar(UIPackage.createObject("Basic","ProgressBar"));
		}

		public function UI_ProgressBar()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_n0 = GImage(this.getChild("n0"));
			m_bar = GImage(this.getChild("bar"));
		}
	}
}