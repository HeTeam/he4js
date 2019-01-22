package laya.physics.joint {
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.physics.Physics;
	import laya.physics.RigidBody;
	
	/**
	 * 焊接关节：焊接关节的用途是使两个物体不能相对运动，受到关节的限制，两个刚体的相对位置和角度都保持不变，看上去像一个整体
	 */
	public class WeldJoint extends JointBase {
		/**@private */
		private static var _temp:*;
		/**[首次设置有效]关节的自身刚体*/
		public var selfBody:RigidBody;
		/**[首次设置有效]关节的连接刚体*/
		public var otherBody:RigidBody;
		/**[首次设置有效]关节的链接点，是相对于自身刚体的左上角位置偏移*/
		public var anchor:Array = [0, 0];
		/**[首次设置有效]两个刚体是否可以发生碰撞，默认为false*/
		public var collideConnected:Boolean = false;
		
		/**弹簧系统的震动频率，可以视为弹簧的弹性系数*/
		private var _frequency:Number = 5;
		/**刚体在回归到节点过程中受到的阻尼，取值0~1*/
		private var _damping:Number = 0.7;
		
		override protected function _createJoint():void {
			if (!_joint) {
				if (!otherBody) throw "otherBody can not be empty";
				selfBody ||= owner.getComponent(RigidBody);
				if (!selfBody) throw "selfBody can not be empty";
				
				var box2d:* = window.box2d;
				var def:* = _temp || (_temp = new box2d.b2WeldJointDef());
				var anchorPos:Point = Sprite(selfBody.owner).localToGlobal(Point.TEMP.setTo(anchor[0], anchor[1]), false, Physics.I.worldRoot);
				var anchorVec:* = new box2d.b2Vec2(anchorPos.x / Physics.PIXEL_RATIO, anchorPos.y / Physics.PIXEL_RATIO);
				def.Initialize(otherBody.getBody(), selfBody.getBody(), anchorVec);
				def.frequencyHz = _frequency;
				def.dampingRatio = _damping;
				def.collideConnected = collideConnected;
				
				_joint = Physics.I._createJoint(def);
			}
		}
		
		/**弹簧系统的震动频率，可以视为弹簧的弹性系数*/
		public function get frequency():Number {
			return _frequency;
		}
		
		public function set frequency(value:Number):void {
			_frequency = value;
			if (_joint) _joint.SetFrequency(value);
		}
		
		/**刚体在回归到节点过程中受到的阻尼，建议取值0~1*/
		public function get damping():Number {
			return _damping;
		}
		
		public function set damping(value:Number):void {
			_damping = value;
			if (_joint) _joint.SetDampingRatio(value);
		}
	}
}