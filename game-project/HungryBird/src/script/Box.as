package script{
import Basic.UI_Box;
import fairygui.Events;
import he.ai.Node;
import he.ai.Port;
import script.panels.LineContainer;

public class Box extends UI_Box{
    public function Box() {
        onClick(this,blink)
        this.draggable = true;
        this.on(Events.DRAG_END,this,onDrag);
        this.on(Events.DRAG_MOVE,this,onDrag);
    }
    public function blink():void {
        m_blinkMV.play();
        trace(this.data);
    }
    public function onDrag():void {
        var node:Node = (data as Node)
        var len:int = node._ports.length
        for(var i:int = 0; i < len; i++)
        {
            var port:Port = node._ports[i];
            LineContainer.inst.drawLine(port.a,port.b);
        }
    }
}
}