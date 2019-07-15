/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_TreeItem extends fairygui.GButton
	{
		public var m_indent:GGraph;
		public var m_expandButton:GButton;
		public var m_sign:GLoader;

		public static const URL:String = "ui://3hcsjton8ymy3d";

		public static function createInstance():UI_TreeItem
		{
			return UI_TreeItem(UIPackage.createObject("Basic","TreeItem"));
		}

		public function UI_TreeItem()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_indent = GGraph(this.getChild("indent"));
			m_expandButton = GButton(this.getChild("expandButton"));
			m_sign = GLoader(this.getChild("sign"));
		}
	}
}