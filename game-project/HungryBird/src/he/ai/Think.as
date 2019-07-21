package he.ai
{
	/**
	 * Think 思维控制器，负责对记忆数据进行循环控制、推理、更新。让静态的记忆活起来的关键。
	 * 
	 * 详情请看如下链接：
	 * 
	 * AGI 思考控制器
	 * http://blog.poerlang.com/blog/index.php/2019/02/10/ctrl.html
	 * 
	 * AGI 树算
	 * http://poerlang.com/blog/index.php/2019/02/24/ai-tree-1.html
	 * 
	 * AGI 价值评估
	 * http://poerlang.com/blog/index.php/2019/02/25/agi-value.html
	 * 
	 * AI 树运行效果
	 * https://www.bilibili.com/video/av44645818
	 * 
	 * AGI 小鸟实验实施方案：
	 * 
	 * ★ 第一阶段，领悟距离。
	 * 将坚果和距离改变，捆绑关联到搬运动画，动画时，思维控制器可以静默 1 秒。
	 * 将物体、近距离，捆绑到吃动画，并可以获得奖励。
	 * 添加饥饿按钮
	 * 小鸟饥饿后会做出吃东西的动作。
	 * 乱投（远距离投放无壳坚果），直投（近距离投放无壳坚果）。
	 * 吃不到，吃到，吃不到，吃到。
	 * 比较二者有什么不同，推导出距离。
	 * 距离小到一定程度，才能吃到。
	 * 构建优化网络，当观众点击饥饿按钮时，
	 * 小鸟不再做出吃东西的动作，而是运行优化网络。
	 * 满足下面的情况，才做出吃的动作：
	 * 有破壳的坚果，距离近。
	 * 如果距离不够近，则移动。
	 * 注意力聚焦。
	 * 调速。
	 * 打印面板，显示小鸟内心独白。
	 * 
	 * ★ 第二阶段，领悟破壳坚果和有壳坚果的不同。
	 * 
	 * ★ 第三阶段，领悟导致破壳的原因。
	 * 
	 * ★ 第四阶段，做出主动破壳的行为。
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
			Net.inst.add(node);
		}
		
		//专注列表，此列表中的节点，会被大脑集中计算，其它节点有可能会被忽略。
		public var focusList:Vector.<Node> = new Vector.<Node>();
		
		/**
		 * 将 node 加入专注列表
		 * @param node
		 */
		public function on( node: Node ):void {
			var index:int = focusList.indexOf(node);
			if( index < 0 ){
				focusList.push(node);
			}
		}
		
		/**
		 * 将 node 从专注列表中移除
		 * @param node
		 */
		public function off( node: Node ):void {
			var index:int = focusList.indexOf(node);
			if( index >= 0 ){
				focusList.splice(index,1);
			}
		}
	}
}
