package laya.physics.joint {
	import laya.physics.Physics;
	import laya.physics.RigidBody;
	
	/**
	 * 绳索关节：限制了两个点之间的最大距离。它能够阻止连接的物体之间的拉伸，即使在很大的负载下
	 */
	public class RopeJoint extends JointBase {
		/**@private */
		private static var _temp:*;
		/**[首次设置有效]关节的自身刚体*/
		public var selfBody:RigidBody;
		/**[首次设置有效]关节的连接刚体，可不设置，默认为左上角空刚体*/
		public var otherBody:RigidBody;
		/**[首次设置有效]自身刚体链接点，是相对于自身刚体的左上角位置偏移*/
		public var selfAnchor:Array = [0, 0];
		/**[首次设置有效]链接刚体链接点，是相对于otherBody的左上角位置偏移*/
		public var otherAnchor:Array = [0, 0];
		/**[首次设置有效]两个刚体是否可以发生碰撞，默认为false*/
		public var collideConnected:Boolean = false;
		
		/**selfAnchor和otherAnchor之间的最大距离*/
		private var _maxLength:Number = 1;
		
		override protected function _createJoint():void {
			if (!_joint) {
				//if (!otherBody) throw "otherBody can not be empty";
				selfBody ||= owner.getComponent(RigidBody);
				if (!selfBody) throw "selfBody can not be empty";
				
				var box2d:* = window.box2d;
				var def:* = _temp || (_temp = new box2d.b2RopeJointDef());
				def.bodyA = otherBody ? otherBody.getBody() : Physics.I._emptyBody;
				def.bodyB = selfBody.getBody();
				def.localAnchorA.Set(otherAnchor[0] / Physics.PIXEL_RATIO, otherAnchor[1] / Physics.PIXEL_RATIO);
				def.localAnchorB.Set(selfAnchor[0] / Physics.PIXEL_RATIO, selfAnchor[1] / Physics.PIXEL_RATIO);
				def.maxLength = _maxLength / Physics.PIXEL_RATIO;
				def.collideConnected = collideConnected;
				
				_joint = Physics.I._createJoint(def);
			}
		}
		
		/**selfAnchor和otherAnchor之间的最大距离*/
		public function get maxLength():Number {
			return _maxLength;
		}
		
		public function set maxLength(value:Number):void {
			_maxLength = value;
			if (_joint) _joint.SetMaxLength(value / Physics.PIXEL_RATIO);
		}
	}
}