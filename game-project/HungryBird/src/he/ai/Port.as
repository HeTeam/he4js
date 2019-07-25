package he.ai
{
	/**
	 * Port 突触，负责连接节点，并记录连接强度或运动落差。 
	 * 
	 * 规律：突触是两个节点之间共享的，在 a 节点下建立一个突触，这个突触会指向 b 节点，a 和 b 共同拥有这个突触，在 a 和 b 的突触列表里都能找到这个突触。
	 */
	public class Port
	{
		public var a_value:Number=0; 	//连接强度，运动落差
		public var b_value:Number=0; 	//连接强度，运动落差
		public var id:String;		//唯一标识，由两个节点的 id 加上下划线构成（会经过排序，id 大的在前面）。
		public var a:Node;	// a 节点
		public var b:Node;	// b 节点
		public var a_type:int;		//标注类型，只用于在思考时辨别 childNode 是因何而生的或指向什么样的节点，比如 "抽象"，代表 childNode 指向一个相对抽象节点， 或 "具象"，表示 childNode 指向一个相对具象的节点。
		public var b_type:int;		//标注类型，只用于在思考时辨别 childNode 是因何而生的或指向什么样的节点，比如 "抽象"，代表 childNode 指向一个相对抽象节点， 或 "具象"，表示 childNode 指向一个相对具象的节点。
		public function Port(_a:Node,_b:Node)
		{
			a = _a;
			b = _b;
			this.id = Util.getSortIDstr(a,b);
			dic[this.id] = this;
		}
		public static var dic:Object = {};
		public static function has(n1:Node,n2:Node):*{
			var str:String = Util.getSortIDstr(n1,n2);
			return dic[str]? true:false;
		}
		public static function get(n1:Node,n2:Node):*{
			var str:String = Util.getSortIDstr(n1,n2);
			return dic[str];
		}
		public function get a_typeStr():String
		{
			return PortType.getStr(a_type);
		}
		public function getOtherID(a_or_b:Node):int
		{
			return a == a_or_b ? b.id : a.id;
		}
		public function getOther(a_or_b:Node):Node
		{
			return a_or_b.id == a.id ? b : a;
		}
		public function dispose():void
		{
			b = null;
			a = null;
			//todo: return to pool
			//todo: update ui
		}
	}
}