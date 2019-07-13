package he.ai
{
	public class Util
	{
		public static function getSortIDs(n1:Node,n2:Node):String
		{
			if(n1.id > n2.id){
				return n1.id+"_"+n2.id;
			}else{
				return n2.id+"_"+n1.id;
			}
		}
	}
}