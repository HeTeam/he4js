package laya.webgl.shader.d2 {
	import laya.webgl.shader.ShaderDefinesBase;
	public class ShaderDefines2D extends ShaderDefinesBase {
		public static const TEXTURE2D:int = 0x01;
		public static const PRIMITIVE:int = 0x04;
		public static const FILTERGLOW:int = 0x08;
		public static const FILTERBLUR:int = 0x10;
		public static const FILTERCOLOR:int = 0x20;
		public static const COLORADD:int = 0x40;
		
		public static const WORLDMAT:int = 0x80;
		public static const FILLTEXTURE:int = 0x100;
		public static const SKINMESH:int = 0x200;
		public static const SHADERDEFINE_FSHIGHPRECISION:int = 0x400;
		public static const MVP3D:int = 0x800;
		
		public static const NOOPTMASK:int = FILTERGLOW|FILTERBLUR|FILTERCOLOR|FILLTEXTURE;	//有这些定义的不要优化。见submittexture
		
		private static var __name2int:Object = {};
		private static var __int2name:Array = [];
		private static var __int2nameMap:Array = [];
		
		public static function __init__():void {
			reg("TEXTURE2D", TEXTURE2D);
			reg("PRIMITIVE", PRIMITIVE);
			
			reg("GLOW_FILTER", FILTERGLOW);
			reg("BLUR_FILTER", FILTERBLUR);
			reg("COLOR_FILTER", FILTERCOLOR);
			reg("COLOR_ADD", COLORADD);
			
			reg("WORLDMAT", WORLDMAT);
			reg("FILLTEXTURE", FILLTEXTURE);
			reg("FSHIGHPRECISION", SHADERDEFINE_FSHIGHPRECISION);
			reg('MVP3D', MVP3D);
		}
		
		public function ShaderDefines2D() {
			super(__name2int, __int2name, __int2nameMap);
		}
		
		public static function reg(name:String, value:int):void {
			_reg(name, value, __name2int, __int2name);
		}
		
		//TODO:coverage
		public static function toText(value:int, int2name:Array, int2nameMap:Object):* {
			return _toText(value, int2name, int2nameMap);
		}
		
		//TODO:coverage
		public static function toInt(names:String):int {
			return _toInt(names, __name2int);
		}
	}

}