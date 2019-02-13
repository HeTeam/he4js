package he.ai
{
	public class PortType
	{
		public static var none:int = 0; // 普通类型，并没有刻意做分类
		public static var abs:int = 1;  // 抽象
		public static var con:int = 2;  // 具象
		
		public static function getStr(type:int):String
		{
			switch(type){
				case abs:{
					return "抽象";
				}
				case con:{
					return "具象";
				}
			}
			return "普通";
		}
	}
}