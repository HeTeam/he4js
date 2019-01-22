package laya.utils {
	
	/**
	 * <p> <code>Pool</code> 是对象池类，用于对象的存储、重复使用。</p>
	 * <p>合理使用对象池，可以有效减少对象创建的开销，避免频繁的垃圾回收，从而优化游戏流畅度。</p>
	 */
	public class Pool {
		/**@private */
		private static const POOLSIGN:String = "__InPool";
		/**@private  对象存放池。*/
		private static var _poolDic:Object = {};
		
		/**
		 * 根据对象类型标识字符，获取对象池。
		 * @param sign 对象类型标识字符。
		 * @return 对象池。
		 */
		public static function getPoolBySign(sign:String):Array {
			return _poolDic[sign] || (_poolDic[sign] = []);
		}
		
		/**
		 * 清除对象池的对象。
		 * @param sign 对象类型标识字符。
		 */
		public static function clearBySign(sign:String):void {
			if (_poolDic[sign]) _poolDic[sign].length = 0;
		}
		
		/**
		 * 将对象放到对应类型标识的对象池中。
		 * @param sign 对象类型标识字符。
		 * @param item 对象。
		 */
		public static function recover(sign:String, item:Object):void {
			if (item[POOLSIGN]) return;
			item[POOLSIGN] = true;
			getPoolBySign(sign).push(item);
		}
		
		/**
		 * 根据类名进行回收，如果类有类名才进行回收，没有则不回收
		 * @param	instance 类的具体实例
		 */
		public static function recoverByClass(instance:*):void {
			if (instance) {
				var className:String = instance["__className"] || instance.constructor._$gid;
				if (className) recover(className, instance);
			}
		}
		
		/**
		 * 返回类的唯一标识
		 */
		private static function _getClassSign(cla:Class):String {
			var className:String = cla["__className"] || cla["_$gid"];
			if (!className) {
				cla["_$gid"] = className = Utils.getGID() + "";
			}
			return className;
		}
		
		/**
		 * 根据类名回收类的实例
		 * @param	instance 类的具体实例
		 */
		public static function createByClass(cls:Class):* {
			return getItemByClass(_getClassSign(cls), cls);
		}
		
		/**
		 * <p>根据传入的对象类型标识字符，获取对象池中此类型标识的一个对象实例。</p>
		 * <p>当对象池中无此类型标识的对象时，则根据传入的类型，创建一个新的对象返回。</p>
		 * @param sign 对象类型标识字符。
		 * @param cls 用于创建该类型对象的类。
		 * @return 此类型标识的一个对象。
		 */
		public static function getItemByClass(sign:String, cls:Class):* {
			if (!_poolDic[sign]) return new cls();
			
			var pool:Array = getPoolBySign(sign);
			if (pool.length) {
				var rst:Object = pool.pop();
				rst[POOLSIGN] = false;
			} else {
				rst = new cls();
			}
			return rst;
		}
		
		/**
		 * <p>根据传入的对象类型标识字符，获取对象池中此类型标识的一个对象实例。</p>
		 * <p>当对象池中无此类型标识的对象时，则使用传入的创建此类型对象的函数，新建一个对象返回。</p>
		 * @param sign 对象类型标识字符。
		 * @param createFun 用于创建该类型对象的方法。
		 * @param caller this对象
		 * @return 此类型标识的一个对象。
		 */
		public static function getItemByCreateFun(sign:String, createFun:Function,caller:*=null):* {
			var pool:Array = getPoolBySign(sign);
			var rst:Object = pool.length ? pool.pop() : createFun.call(caller);
			rst[POOLSIGN] = false;
			return rst;
		}
		
		/**
		 * 根据传入的对象类型标识字符，获取对象池中已存储的此类型的一个对象，如果对象池中无此类型的对象，则返回 null 。
		 * @param sign 对象类型标识字符。
		 * @return 对象池中此类型的一个对象，如果对象池中无此类型的对象，则返回 null 。
		 */
		public static function getItem(sign:String):* {
			var pool:Array = getPoolBySign(sign);
			var rst:Object = pool.length ? pool.pop() : null;
			if (rst) {
				rst[POOLSIGN] = false;
			}
			return rst;
		}
	
	}

}