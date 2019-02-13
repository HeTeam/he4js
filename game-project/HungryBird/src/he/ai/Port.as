package he.ai
{
	/**
	 * Port 突触，负责连接节点，并记录连接强度或运动落差。 
	 * 
	 * 规律：Port 总是成对出现，在一个节点下建立一个 Port，这个 Port 会指向另一个新的 Node，而这个新的 Node 也将拥有一个指回来的 Port。
	 */
	public class Port
	{
		public var value:Number=0; 	//连接强度，运动落差
		public var id:String;		//唯一标识
		public var parentNode:Node;	//上级节点
		public var childNode:Node;	//下级节点
		public var type:int;		//标注类型，只用于在思考时辨别 childNode 是因何而生的或指向什么样的节点，比如 "抽象"，代表 childNode 指向一个相对抽象节点， 或 "具象"，表示 childNode 指向一个相对具象的节点。
		public function Port(parent:Node,child:Node)
		{
			parentNode = parent;
			childNode = child;
			this.id = child.id;
		}
		
		public function get typeStr():String
		{
			return PortType.getStr(type);
		}

		public function dispose():void
		{
			childNode = null;
			parentNode = null;
			//todo: return to pool
			//todo: update ui
		}
	}
}