package he.ai
{
	/**
	 * Port 突触，负责连接节点，并记录连接强度。 
	 * 
	 */
	public class Port
	{
		public var node:Node;		//下级节点
		public var value:Number=0; 	//连接强度
		public var id:String;		//唯一标识
		public var parent:Node;		//上级节点
		public function Port(n:Node)
		{
			node = n;
			this.id = n.id;
		}
		
		public function dispose():void
		{
			node = null;
			//todo: return to pool;
		}
	}
}