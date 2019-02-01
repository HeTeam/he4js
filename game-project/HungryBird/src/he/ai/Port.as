package he.ai
{
	/**
	 * Port 突触，负责连接节点，并记录连接强度或运动落差。 
	 * 
	 */
	public class Port
	{
		public var value:Number=0; 	//连接强度，运动落差
		public var id:String;		//唯一标识
		public var parentNode:Node;	//上级节点
		public var childNode:Node;	//下级节点
		public function Port(parent:Node,child:Node)
		{
			parentNode = parent;
			childNode = child;
			this.id = child.id;
		}
		
		public function dispose():void
		{
			childNode = null;
			parentNode = null;
			//todo: return to pool;
		}
	}
}