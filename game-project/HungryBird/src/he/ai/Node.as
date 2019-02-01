package he.ai {
	import laya.maths.Point;
	/**
	 * Node 神经节点，简称节点，用于记忆单个抽象事物，Node 中包含了多个 Port（突触） 。
	 * 
	 * 先写一个基本假设：
	 * 
	 * 一切事物都是在运动着。
	 * 比如我们说“人”，是一个名词，似乎是静态的，但实际上，这个人的分子层面和细胞层面，每秒钟都在活跃着。
	 * 
	 * 再来说根据上面的假设得到的推论：
	 * 所有的节点都在表达一种运动，或者对运动的抽象。
	 * 
	 * 所以，Node 中的 _ports 数组中存在着的大量的 Port（突触），
	 * 这些 Port 在数组中的位置次序，记录了运动先后，或者相关性，重要程度的排序结果
	 * 而 Port 中的 value，记录的就是运动的落差、强烈程度等等。
	 */
	public class Node {
		public var id: String = "" + Node._gInstanceCounter++;
		public var _ports: Vector.<Port> = new Vector.<Port>(); //以 数组 的方式记录突触
		public var _dic:Object = {}; 							//以 key value 的方式记录突触
		public var pos:Point = new Point();
		
		public static var _gInstanceCounter: Number = 0;
		
		public function Node() {
			Net.inst.add(this);
		}
		public function dispose(): void {
			var i:int;
			var cnt:int;
			cnt = this._ports.length;
			for(i = cnt - 1;i >= 0;--i) {
				var obj:Port = this._ports[i];
				obj.dispose();
			}
			//todo: return to pool;
		}
		public function addPort(port: Port): Port {
			return this.addPortAt(port,this._ports.length);
		}
		public function addPortAt(port: Port,index: Number = 0): Port {
			if(!port)
				throw "port is null";
			
			var numChildren: Number = this._ports.length;
			
			if(index >= 0 && index <= numChildren) {
				var cnt: Number = this._ports.length;
				if(index == cnt)
					this._ports.push(port);
				else
					this._ports.splice(index,0,port);
				
				this._dic[port.id] = port;
				port.parentNode = this;
				
				return port;
			}
			else {
				throw "Invalid port index";
			}
		}	
		public function addPortByNode(child: Node): Node {
			return this.addPortByNodeAt(child,this._ports.length);
		}
		public function addPortByNodeAt(child: Node,index: Number = 0): Node {
			if(!child)
				throw "child is null";
			
			var port:Port = new Port(this,child);
			addPortAt(port,index);
			return child;
		}
		public function removePortByNode(child: Node,dispose: Boolean = false): Node {
			var port:Port = getPort(child.id);
			removePort(port);
			return child;
		}
		public function removePort(port: Port,dispose: Boolean = false): Port {
			var childIndex: Number = this._ports.indexOf(port);
			if(childIndex != -1) {
				this.removePortAt(childIndex,dispose);
			}
			return port;
		}
		private function getPort(portName:String):Port
		{
			return this._dic[portName];
		}
		public function removePortAt(index: Number,dispose: Boolean = false): Port {
			if(index >= 0 && index < this.numChildren) {
				var port: Port = this._ports[index];
				port.parentNode = null;
				
				this._ports.splice(index,1);
				
				if(dispose)
					port.dispose();
				
				delete this._dic[port.id];
				
				return port;
			}
			else {
				throw "Invalid child index";
			}
		}
		public function removePorts(beginIndex: Number = 0,endIndex: Number = -1,dispose: Boolean = false): void {
			if(endIndex < 0 || endIndex >= this.numChildren)
				endIndex = this.numChildren - 1;
			
			for(var i: Number = beginIndex;i <= endIndex;++i)
				this.removePortAt(beginIndex,dispose);
		}
		public function getPortAt(index: Number = 0): Node {
			if(index >= 0 && index < this.numChildren)
				return this._ports[index];
			else
				throw "Invalid port index";
		}
		public function getPortIndex(port: Port): Number {
			return this._ports.indexOf(port);
		}
		public function setPortIndex(port: Port,index: Number = 0): void {
			var oldIndex: Number = this._ports.indexOf(port);
			if(oldIndex == -1)
				throw "Not a child of this container";
			
			this._setChildIndex(port,oldIndex,index);
		}
		public function setChildIndexBefore(port: Port, index:int):int
		{
			var oldIndex:int = _ports.indexOf(port);
			if (oldIndex == -1) 
				throw "Not a child of this container";
			
			if (oldIndex < index)
				return _setChildIndex(port, oldIndex, index - 1);
			else
				return _setChildIndex(port, oldIndex, index);
		}
		private function _setChildIndex(child: Port, oldIndex:int, index:int):int
		{
			var cnt: Number = this._ports.length;
			if(index > cnt)
				index = cnt;
			
			if(oldIndex == index)
				return oldIndex;
			
			this._ports.splice(oldIndex,1);
			this._ports.splice(index,0,child);
			
			return index;
		}
		public function swapChildren(child1: Port,child2: Port): void {
			var index1: Number = this._ports.indexOf(child1);
			var index2: Number = this._ports.indexOf(child2);
			if(index1 == -1 || index2 == -1)
				throw "Not a port of this container";
			this.swapChildrenAt(index1,index2);
		}
		public function swapChildrenAt(index1: Number,index2: Number = 0): void {
			var child1: Port = this._ports[index1];
			var child2: Port = this._ports[index2];
			
			this.setPortIndex(child1,index2);
			this.setPortIndex(child2,index1);
		}
		
		public function get numChildren(): Number {
			return this._ports.length;
		}
	}
}