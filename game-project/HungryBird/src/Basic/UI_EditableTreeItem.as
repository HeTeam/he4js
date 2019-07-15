/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

package Basic
{
	import fairygui.*;

	public class UI_EditableTreeItem extends fairygui.GButton
	{
		public var m_c1:Controller;
		public var m_indent:GGraph;
		public var m_input:GTextInput;
		public var m_expandButton:GButton;
		public var m_sign:GLoader;

		public static const URL:String = "ui://3hcsjton8ymy3f";

		public static function createInstance():UI_EditableTreeItem
		{
			return UI_EditableTreeItem(UIPackage.createObject("Basic","EditableTreeItem"));
		}

		public function UI_EditableTreeItem()
		{
		}

		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);

			m_c1 = this.getController("c1");
			m_indent = GGraph(this.getChild("indent"));
			m_input = GTextInput(this.getChild("input"));
			m_expandButton = GButton(this.getChild("expandButton"));
			m_sign = GLoader(this.getChild("sign"));
		}
	}
}