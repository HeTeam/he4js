package he.ai
{
	/**
	 * Think 思维控制器，负责对记忆数据进行循环控制、推理、更新。让静态的记忆活起来的关键。
	 * 
	 * 详情请看如下链接：
	 * http://blog.poerlang.com/project/public/2019/02/10/agi-think.html
	 */
	public class Think
	{
		public function Think()
		{
			// todo
		}
		private static var _instance:Think;

		public static function get inst():Think
		{
			if(_instance==null){
				_instance = new Think;
			}
			return _instance;
		}
		public function dataIn(node:Node):void
		{
			// todo
		}
	}
}