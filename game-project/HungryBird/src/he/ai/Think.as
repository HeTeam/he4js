package he.ai
{
import he.ai.Node;

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
			Laya.timer.loop(thinkLoopTimeInterval,this,loop)
		}
		
		/**
		 * 思考循环
		 */
		private function loop():void {
			
			// focus 模式，暂时用于教育模式，排除其它一切不相关噪音。
			var theList = inFocus? focusList: shortList;
			
			//todo: “快乐” 是否应该用 <紧急>和<重要> 替代，后者是否是更深层次的节点？ AGI 是否需要<快乐>和<痛苦>？
			var happyNode:Node = searchByPattern(theList,NodeType.Happy);
			
			if(happyNode){
				// todo: 如果找到上帝（人类）设定的 “快乐” 节点 ，则将快乐节点附近（发生时间接近）的节点与快乐节点关联（抽象加强）
				// todo: 再从记忆中找出之前与 “快乐” 节点关联的节点，检查是否需要有抑制的节点。（抽象抑制）
				// todo：尝试进行抽象，精简快乐节点与其它节点的关系。并存储到记忆中。
			}else {
				// todo: 如果没有直接的 “快乐” 节点，则执行抽象，并联想，查找与快乐相关的模式的节点。
				// todo: 继续尝试进行联想抽象，比较各种快乐模式，重新设定快乐阈值（提高或降低阈值，不超过某个阈值不激活）
				// todo: 该增强的增强，该削弱的削弱，并存储记忆。
			}
			// todo: 尝试主动复现产生 “快乐” 节点的各种子节点（具象输出）。
		}
		
		private function searchByPattern(theList:Vector.<Node>,pattern:String):Node {
			var len:uint = theList.length;
			for (var i:int = 0; i < len; i++) {
				var node:Node = theList[i] as Node;
				if(node.patternKey[0] == NodeType.Happy){
					return node;
				}
			}
			return node;
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
			if(!inFocus){
				if(!node.patternKey){
					node.updatePatternKey();
				}
				// todo: 创建时间节点。（可能有用，比如描述等待）
				addToShortList(node);
			}else {
				// 如果 isFocus ，则直接忽略输入的 node
			}
		}

		private function addToShortList(node:Node):void {
			shortList.unshift(node);
			while(shortList.length > shortListMaxLen){
				shortList.pop();
			}
		}
		public var thinkLoopTimeInterval:int = 100; //每隔多久思考一次，思考时间间隔，单位（毫秒）。
		public var shortListMaxLen:int = 100;
		//短期记忆列表，如果注意力不在 focusList，则在 shortList 这个列表。从中筛选有价值的，通过 Net.inst.add(node); 放入记忆。
		public var shortList:Vector.<Node> = new Vector.<Node>();

		//专注列表，此列表中的节点，会被大脑集中计算，其它节点有可能会被忽略。
		public var focusList:Vector.<Node> = new Vector.<Node>();
		
		//是否在专注模式中，如果是，则忽略其它输入。
		public var inFocus:Boolean = false;
		
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
