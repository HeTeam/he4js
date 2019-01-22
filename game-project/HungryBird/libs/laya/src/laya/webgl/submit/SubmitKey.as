package laya.webgl.submit
{
	/**
	 * ...
	 * @author xie
	 */
	public class SubmitKey 
	{
		public var blendShader:int;
		public var submitType:int;
		public var other:int;
		
		public function SubmitKey() 
		{
			clear();
		}
		
		public function clear():void
		{
			submitType =-1;
			blendShader = other = 0;
			//alpha = 1;
		}
		
		//TODO:coverage
		public function copyFrom(src:SubmitKey):void
		{
			other = src.other;
			blendShader = src.blendShader;
			submitType = src.submitType;
			//alpha = src.alpha;
		}
		
		public function copyFrom2(src:SubmitKey,submitType:int,other:int):void
		{
			//this.blendShader = src.blendShader;
			//this.alpha = src.alpha;			
			this.other = other;
			this.submitType = submitType;
		}
		
		//�Ƚ�3�����ⲿ�ṩ2��
		//TODO:coverage
		public function equal3_2(next:SubmitKey,submitType:int,other:int):Boolean
		{
			return this.submitType === submitType && this.other === other && blendShader === next.blendShader;// && this.alpha === alpha;
		}
		
		//ȫ�Ƚϡ��ⲿ�ṩ2��
		//TODO:coverage
		public function equal4_2(next:SubmitKey,submitType:int,other:int):Boolean
		{
			return this.submitType === submitType && this.other === other && blendShader === next.blendShader;// && alpha === next.alpha;
		}
		
		//�Ƚ�3��
		//TODO:coverage
		public function equal_3(next:SubmitKey):Boolean
		{
			return submitType === next.submitType && blendShader === next.blendShader;// && alpha === next.alpha;
		}		
		//ȫ�Ƚϡ�4��
		//TODO:coverage
		public function equal(next:SubmitKey):Boolean
		{
			return other === next.other && submitType === next.submitType && blendShader === next.blendShader ;// && alpha === next.alpha;
		}
		
	}

}