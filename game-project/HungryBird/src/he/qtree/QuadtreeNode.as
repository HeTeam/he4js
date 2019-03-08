package he.qtree
{
    import laya.maths.Rectangle;
    import laya.maths.Point;

    public class QuadtreeNode
    {
        private var _topRight:QuadtreeNode;
        private var _topLeft:QuadtreeNode;
        private var _bottomRight:QuadtreeNode;
        private var _bottomLeft:QuadtreeNode;

        private var _bounds:Rectangle;
        public var depth:int;
        public static var max:int = 999999999;
        public var hasChild:Boolean;

        private var _objectContainer:Vector.<Object>;
        public var xMidPoint:Number;
        public var yMidPoint:Number;
        public var subBoundTopLeft:Rectangle;
        public var subBoundTopRight:Rectangle;
        public var subBoundBottomRight:Rectangle;
        public var subBoundBottomLeft:Rectangle;
        public var subs:Vector.<QuadtreeNode>;
        public function QuadtreeNode(bounds:Rectangle,depth:int)
        {
            this.depth = depth;
            _objectContainer = new Vector.<Object>();
            _bounds = bounds;
            if(depth>0){
                depth--;
                hasChild = true;
                xMidPoint = _bounds.width / 2
                yMidPoint = _bounds.height / 2;
                subBoundTopLeft = new Rectangle(_bounds.x, _bounds.y, xMidPoint, yMidPoint);
                subBoundTopRight = new Rectangle(_bounds.x + xMidPoint, _bounds.y, xMidPoint, yMidPoint);
                subBoundBottomLeft = new Rectangle(_bounds.x, _bounds.y + yMidPoint, xMidPoint, yMidPoint);   
                subBoundBottomRight = new Rectangle(_bounds.x + xMidPoint, _bounds.y + yMidPoint, xMidPoint, yMidPoint);
                _topLeft = new QuadtreeNode(subBoundTopLeft,depth);
                _topRight = new QuadtreeNode(subBoundTopRight,depth);
                _bottomLeft = new QuadtreeNode(subBoundBottomLeft,depth);
                _bottomRight = new QuadtreeNode(subBoundBottomRight,depth);
                subs = new Vector.<QuadtreeNode>;
                subs.push(_topLeft);
                subs.push(_topRight);
                subs.push(_bottomLeft);
                subs.push(_bottomRight);
                for (var i:int = 0;i<4;i++)
                {
                    subs[i].parent = this;
                }
            }

        }

        public function removeObject(object:Object):void
        {
            for (var i:int = 0; i < _objectContainer.length; i++)
            {
                var element:Object = _objectContainer[i];

                if (element.object === object)
                {
                    _objectContainer.splice(i, 1);
                    addSum(-1);
                    return;
                }
            }
        }

        private function objectInBoundsHelper(checkingBounds:Rectangle, found:Vector.<Object>):void
        {
            /// doesn't intersect this node, do not check further
            if (!checkingBounds.intersects(_bounds))
            {
               return;
            }

            for each (var nodeElement:Object in _objectContainer)
            {
                if (checkingBounds.contains(nodeElement.object.x,nodeElement.object.y))
                {
                    found.push(nodeElement.object);
                }
            }

            if (_topLeft)
            {
                _topLeft.objectInBoundsHelper(checkingBounds, found);
            }

            if (_topRight)
            {
                _topRight.objectInBoundsHelper(checkingBounds, found);
            }

            if (_bottomLeft)
            {
                _bottomLeft.objectInBoundsHelper(checkingBounds, found);
            }

            if (_bottomRight)
            {
                _bottomRight.objectInBoundsHelper(checkingBounds, found);
            }
        }

        public function objectInBounds(checkingBounds:Rectangle):Vector.<Object>
        {
            var found:Vector.<Object> = new Vector.<Object>();

            objectInBoundsHelper(checkingBounds, found);

            return found;
        }
		public function findSpace():Point{
            if(!hasChild){
                return new Point(bounds.x,bounds.y);
            }
            var minSub:QuadtreeNode;
            var minLen:int = max;
            var minIndex:int;
            for(var index:int = 0; index < 4; index++)
            {
                var now:QuadtreeNode = subs[index];
                if(now.sum < minLen){
                    minIndex = index;
                    minSub = now;
                    minLen = minSub.sum;
                }
            }
            return minSub.findSpace();
        }
        public var parent:QuadtreeNode;
        public var sum:int;
        public function addSum(n:int):void{
            sum += n;
            if(parent){
                parent.addSum(n);
            }
        }
        public function insert(object:Object):QuadtreeNode
        {

            /// the object should not be in this node
            if (!_bounds.contains(object.x,object.y))
            {
                return null;
            }
            if(!hasChild){
                _objectContainer.push(object);
                addSum(1);
                return this;
            }
            if (subBoundTopLeft.contains(object.x,object.y))
            {
                return _topLeft.insert(object);
            }

            if (subBoundTopRight.contains(object.x,object.y))
            {
                return _topRight.insert(object);
            }

            if (subBoundBottomLeft.contains(object.x,object.y))
            {
                return _bottomLeft.insert(object);
            }

            if (subBoundBottomRight.contains(object.x,object.y))
            {
                return _bottomRight.insert(object);
            }
            return null;
        }

        public function get objects():Vector.<Object>
        {
            var objects:Vector.<Object> = new Vector.<Object>(_objectContainer.length);

            for each (var element:Object in _objectContainer) {
                objects.push(element.object);
            }

            return objects;
        }

        public function get bounds():Rectangle
        {
            return _bounds;
        }
    }
}
