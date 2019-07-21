package script{
import Basic.UI_Box;
import fairygui.Events;
import fairygui.GRoot;

import he.ai.Node;
import he.ai.Port;
import he.ai.Think;

import script.panels.LineContainer;
import laya.events.Event;
import he.qtree.QuadtreeNode;
import he.qtree.Quadtree;

import script.panels.MainPanel;

import script.panels.MainPanel;

public class Box extends UI_Box{
    public var qnode:QuadtreeNode;
    public var qtree:Quadtree;
    public function Box() {
        onClick(this,blink)
        this.draggable = true;
        this.on(Events.DRAG_END,this,onDrag);
        this.on(Events.DRAG_MOVE,this,onDrag);
        this.on(Event.ADDED,this,addToQuadTree);
	    this.on(Event.DOUBLE_CLICK,this,onDClick)
    }
	
	private function onDClick(e:Event):void {
		m_state.selectedIndex = m_state.selectedIndex==0? 1 : 0; // 反转
		if(m_state.selectedIndex==1){
			Think.inst.on(getNode());
		}else {
			Think.inst.off(getNode());
		}
	}
	public function getNode():Node{
		return data as Node;
	}
    public function blink():void {
        m_blinkMV.play();
	    var node:Node = getNode();
	    if(node.realObject && node.realObject.parent){
		    MainPanel.flash(getNode().realObject,66);
	    }
        trace(node);
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
	
	public function flash():void {
		MainPanel.flash(this,55);
	}
}
}