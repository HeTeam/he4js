package he.ai
{
	public class Util
	{
		public static function getSortIDstr(n1:Node, n2:Node):String
		{
			if(n1.id > n2.id){
				return n1.id+"_"+n2.id;
			}else{
				return n2.id+"_"+n1.id;
			}
		}
		
		public static function sortKeyArr(arr:Array):Array {
			var newArr = arr.slice();
			newArr.sort(sortStrArrByIntDesc)
			return newArr;
		}
		
		//降序，大的在前，（更抽象的在前）
		public static function sortStrArrByIntDesc(a:String, b:String):int {
			if(a>b) return -1;
			if(a<b) return 1;
			return 0;
		}
	}
}