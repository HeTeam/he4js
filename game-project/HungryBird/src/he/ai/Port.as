package he.ai
{
	public class Port
	{
		public var node:Node;
		public var value:Number=0;
		public var id:String;
		public var parent:Node;
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