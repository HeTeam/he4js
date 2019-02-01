package he.ai
{
	/**
	 * Net 网络，负责记忆所有的神经节点（Node），Net 包含 Node，而 Node 包含 Port（突触）。
	 * 
	 */
	public class Net
	{
		public function Net()
		{
		}
		private static var _instance:Net;

		public static function get inst():Net
		{
			if(_instance==null){
				_instance = new Net;
			}
			return _instance;
		}

		public function add(n:Node):void
		{
			this[n.id] = n;
		}
		public function get(id:String):Node
		{
			return this[id];
		}
	}
}