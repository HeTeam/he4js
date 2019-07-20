package script{
import Basic.UI_Box;
import fairygui.Events;
import he.ai.Node;
import he.ai.Port;
import script.panels.LineContainer;
import laya.events.Event;
import he.qtree.QuadtreeNode;
import he.qtree.Quadtree;
public class Box extends UI_Box{
    public var qnode:QuadtreeNode;
    public var qtree:Quadtree;
    public function Box() {
        onClick(this,blink)
        this.draggable = true;
        this.on(Events.DRAG_END,this,onDrag);
        this.on(Events.DRAG_MOVE,this,onDrag);
        this.on(Event.ADDED,this,addToQuadTree);
    }
    public function blink():void {
        m_blinkMV.play();
        trace(this.data);
    }
    public function addToQuadTree():void{
        qtree = parent["qtree"] as Quadtree;
        if(qtree){
            qtree.insert(this);
        }
    }
    public function updateInQuadTree():void{
        if(qtree){
            qtree.update(this);
        }
    }
    public function onDrag():void {
        var node:Node = (data as Node)
        var len:int = node.portInArrList.length
        for(var i:int = 0; i < len; i++)
        {
            var port:Port = node.portInArrList[i];
            LineContainer.inst.drawLine(port.a,port.b);
        }
    }
}
}