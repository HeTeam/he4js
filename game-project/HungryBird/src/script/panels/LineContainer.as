package script.panels
{
	import Basic.UI_NodeContainer;
	
	public class NodeContainer extends UI_NodeContainer
	{
		public function NodeContainer()
		{
			super();
		}
		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);
			removeChildren();
		}
	}
}