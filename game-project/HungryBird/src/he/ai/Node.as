package he.ai {
import fairygui.GComponent;

import he.ai.EventNames;

import laya.maths.Point;
	import laya.events.Event;
	import fairygui.Events;

import script.Box;

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
	 * 所以，Node 中的 portInArrList 数组中存在着的大量的 Port（突触），
	 * 这些 Port 在数组中的位置次序，记录了运动先后，或者相关性，重要程度的排序结果
	 * 而 Port 中的 value，记录的就是运动的落差、强烈程度等等。
	 * 
	 * 一个场景：
	 * 假设有两种坚果，一种是【无壳坚果】，一种是【有壳坚果】，现在有一个有壳坚果 A，我们将其抽象成一棵树，
	 * 然后又出现了一个有壳坚果 B，由于 B 和 A 的不同点仅仅在于坐标不同，则 B 和 A 抽象成一颗通用的树：C，
	 * 而 B 和 A 则成为了 C 的子对象，即实例。
	 * 这个时候，如果出现了 无壳坚果 D，那么 D 和 C 抽象出一个更通用的坚果 E。
	 * 
	 * 又一个场景：
	 * 假设【中国】是一个节点，而【美国】是另一个节点，那么他们可以抽象出一个叫做【国家】的节点，
	 * 这个大的节点之下，包含了大量关于经济、文化、历史、社会等上千万个主题的运动节点，
	 * 而这些主题节点之下又包含了更多的子节点。
	 * 
	 * 又一个场景：
	 * 一个【苹果】节点，直觉上我们认为苹果是静态的，其实不是，
	 * 由于不是绝对零度，所以苹果内部发生着原子层面的布朗运动。
	 * 并且，当季节变动，苹果内部也会发生着各种化学反应，使得青苹果慢慢变红。
	 * 而【红色】这个节点，也是【光反射】这种运动的表象，其实也是一种运动所留下的痕迹。
	 * 采摘后的苹果，如果不放入冰箱，则会在周围细菌的作用下慢慢腐烂。
	 * 所以苹果其实是一个表示运动的动态节点，举一反三，其它物体也都是动态节点。
	 */
	public class Node {
		public var id: String = "" + Node._gInstanceCounter++;
		public var portInArrList: Vector.<Port> = new Vector.<Port>();  //以 数组 的方式记录突触
		public var portInDicByPortID:Object = {}; 						//以 PortID 的方式记录突触
		public var portInDicByNodeID:Object = {}; 						//以 NodeID 的方式记录突触
		public var pos:Point = new Point();
		public var baseType:String = "";
		public var value:Number = 0;
		public var valueStr:String = "";
		
		public static var _gInstanceCounter: Number = 0;
	
		public var box:Box;                 //对应的节点 UI
		public var realObject:GComponent;   //对应的真实物体，如：坚果
		
		public function Node() {
			Net.inst.add(this);
			EventCenter.inst.event(EventNames.AddNode,this);
		}
		public function dispose(): void {
			var i:int;
			var cnt:int;
			cnt = this.portInArrList.length;
			for(i = cnt - 1;i >= 0;--i) {
				var obj:Port = this.portInArrList[i];
				obj.dispose();
			}
			//todo: return to pool;
		}
		private function addPort(port: Port): Port {
			return this.addPortAt(port,this.portInArrList.length);
		}
		private function addPortAt(port: Port,index: Number = 0): Port {
			if(!port)
				throw "port is null";
			
			var numChildren: Number = this.portInArrList.length;
			
			if(index >= 0 && index <= numChildren) {
				var cnt: Number = this.portInArrList.length;
				this.portInDicByPortID[port.id] = port;
				this.portInDicByNodeID[port.getOtherID(this)] = port;
				if(index == cnt){
					this.portInArrList.push(port);
				}else{
					this.portInArrList.splice(index,0,port);
				}
				return port;
			}
			else {
				throw "Invalid port index";
			}
		}	
		public function addPortByNode(child: Node): Port {
			return this.addPortByNodeAt(child,this.portInArrList.length);
		}
		public function addPortByNodeAt(child: Node,index: Number = 0): Port {
			if(!child)
				throw "child is null";

			var childPort:Port = Port.get(this,child);
			if(childPort){
				addPortAt(childPort,index);
				return childPort;
			}
			var port:Port = new Port(this,child);
			this.addPortAt(port,index);
			child.addPortByNode(this);
			return port;
		}
		public function removePortByNode(child: Node,dispose: Boolean = false): Node {
			var port:Port = getPort(child.id);
			removePort(port);
			return child;
		}
		public function removePort(port: Port,dispose: Boolean = false): Port {
			var childIndex: Number = this.portInArrList.indexOf(port);
			if(childIndex != -1) {
				this.removePortAt(childIndex,dispose);
			}
			return port;
		}
		private function getPort(portName:String):Port
		{
			return this.portInDicByPortID[portName];
		}
		private function getPortByOtherNode(node:Node):Port
		{
			return this.portInDicByNodeID[node.id];
		}
		public function removePortAt(index: Number,dispose: Boolean = false): Port {
			if(index >= 0 && index < this.numChildren) {
				var port: Port = this.portInArrList[index];
				port.a = null;
				
				this.portInArrList.splice(index,1);
				
				if(dispose)
					port.dispose();
				
				delete this.portInDicByPortID[port.id];
				delete this.portInDicByNodeID[port.getOtherID(this)];
				EventCenter.inst.event(EventNames.Remove,port);
				
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
		public function getPortAt(index: Number = 0): Port {
			if(index >= 0 && index < this.numChildren)
				return this.portInArrList[index];
			else
				throw "Invalid port index";
		}
		public function getPortIndex(port: Port): Number {
			return this.portInArrList.indexOf(port);
		}
		public function setPortIndex(port: Port,index: Number = 0): void {
			var oldIndex: Number = this.portInArrList.indexOf(port);
			if(oldIndex == -1)
				throw "Not a child of this container";
			
			this._setChildIndex(port,oldIndex,index);
		}
		public function setChildIndexBefore(port: Port, index:int):int
		{
			var oldIndex:int = portInArrList.indexOf(port);
			if (oldIndex == -1) 
				throw "Not a child of this container";
			
			if (oldIndex < index)
				return _setChildIndex(port, oldIndex, index - 1);
			else
				return _setChildIndex(port, oldIndex, index);
		}

		private function _setChildIndex(child: Port, oldIndex:int, index:int):int
		{
			var cnt: Number = this.portInArrList.length;
			if(index > cnt)
				index = cnt;
			
			if(oldIndex == index)
				return oldIndex;
			
			this.portInArrList.splice(oldIndex,1);
			this.portInArrList.splice(index,0,child);
			EventCenter.inst.event(EventNames.PortIndexChange,{oldIndex:oldIndex,index:index,child:child})
			
			return index;
		}
		public function swapChildren(child1: Port,child2: Port): void {
			var index1: Number = this.portInArrList.indexOf(child1);
			var index2: Number = this.portInArrList.indexOf(child2);
			if(index1 == -1 || index2 == -1)
				throw "Not a port of this container";
			this.swapChildrenAt(index1,index2);
		}
		public function swapChildrenAt(index1: Number,index2: Number = 0): void {
			var child1: Port = this.portInArrList[index1];
			var child2: Port = this.portInArrList[index2];
			
			this.setPortIndex(child1,index2);
			this.setPortIndex(child2,index1);
		}
		
		public function get numChildren(): Number {
			return this.portInArrList.length;
		}
	}
}