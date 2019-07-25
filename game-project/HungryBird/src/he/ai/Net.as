package he.ai
{
	/**
	 * Net 网络存储器，负责记忆所有的神经节点（Node），Net 包含 Node，而 Node 包含 Port（突触）。
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
		public var patternDicForSearch:Object = {};
		public function add(n:Node):void
		{
			this[n.id] = n;
		}
		
		// 查询是否有相似 模式 的节点，可进行抽象。
		private function searchPattern(n:Node):Object {
			var keys:Array = n.patternKey;
			var len:int = keys.length;
			var dicNow:* = patternDicForSearch;
			var pattenNode:Node;
			for (var i:int = 0; i<len ; i++){
				var patternKey:int = keys[i];
				var next:* = dicNow[ patternKey ];
				if(next){
					return next;
				}
				next[n.id] = n;
				dicNow = next.nextPatterns;
			}
			return null;
		}
		private function saveByPattern(n:Node):void {
			var keys:Array = n.patternKey;
			var len:int = keys.length;
			var dicNow = patternDicForSearch;
			for (var i:int = 0; i<len ; i++){
				var patternKey:int = keys[i];
				var next = dicNow[ patternKey ];
				if(!next){
					dicNow[ patternKey ] = next = {nextPatterns:{}};
				}
				next[n.id] = n;
				dicNow = next.nextPatterns;
			}
		}
		
		public function remove(n:Node):void
		{
			delete this[n.id];
			delete this[n.patternKey];
		}
		public function getByID(id:String):Node
		{
			return this["id_"+id];
		}
		public function getByKey(key:String):Node
		{
			return this[key];
		}
	}
}