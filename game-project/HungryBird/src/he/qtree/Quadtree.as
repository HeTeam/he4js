package he.qtree
{
    import laya.maths.Rectangle;
    import laya.maths.Point;
    public class Quadtree
    {
        public var depth:int;
        private var _root:QuadtreeNode;
        private var _bounds:Rectangle;
        private var _objectNodeMapping:Object;

        public function Quadtree(minX:Number, minY:Number, maxX:Number, maxY:Number,depth:int)
        {
            _bounds = new Rectangle(minX, minY, maxX - minX, maxY - minY);
            this.depth = depth;
            _root = new QuadtreeNode(_bounds,depth);
            _objectNodeMapping = new Object();
        }

        public function findSpace():Point{
            return _root.findSpace();
        }

        public function insert(object:Object):Boolean
        {
            var targetQuadtreeNode:QuadtreeNode = _root.insert(object);
            if (targetQuadtreeNode) {
                _objectNodeMapping[object] = targetQuadtreeNode;
            }
            return targetQuadtreeNode != null;
        }

        public function nodeForObject(object:Object):QuadtreeNode
        {
            return _objectNodeMapping[object];
        }

        public function remove(object:Object):Boolean
        {
            var node:QuadtreeNode = _objectNodeMapping[object];
            if (!node) return false;// Object not found
            node.removeObject(object);
            delete _objectNodeMapping[object];
            return true;
        }

        public function update(object:Object):void
        {
            const wasRemoved:Boolean = this.remove(object);
            if (!wasRemoved) {
                throw new Error("Can't update object which has not been added to Quadtree.");
            }
            this.insert(object);
        }

        public function objectsInRectangle(rectangle:Rectangle):Vector.<Object>
        {
            return _root.objectInBounds(rectangle);
        }
        
        public function get root():QuadtreeNode
        {
            return _root;
        }
    }
}