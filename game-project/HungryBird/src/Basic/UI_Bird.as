/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_Bird extends fairygui.GComponent
	{
		public var m_birdReplaceHolder:GGraph;

		public static const URL:String = "ui://3hcsjtonopci42";

		public static function createInstance():UI_Bird
		{
			return UI_Bird(UIPackage.createObject("Basic","Bird"));
		}

		public function UI_Bird()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_birdReplaceHolder = GGraph(this.getChild("birdReplaceHolder"));
		}
	}
}