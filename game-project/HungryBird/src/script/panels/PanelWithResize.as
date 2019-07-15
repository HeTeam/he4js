package script.panels{
import fairygui.Window;
import fairygui.GComponent;
import fairygui.Events;
import fairygui.GGraph;
import fairygui.GObject;
import fairygui.GRoot;
import laya.events.Event;
import laya.maths.Point;

public class PanelWithResize extends Window {
    public function PanelWithResize() {
        
    }
    public var aframe:GComponent
    override public function set contentPane(val: GComponent):void {
        super.contentPane = val;
        contentPane.relations.clearAll();//去掉 size 事件绑定，避免无限 resize。
        if(val != null) {
            aframe = GComponent(val.getChild("frame"));
            if(aframe != null) {
                this.resizer = aframe.getChild("resizer");
                this._resizer.visible = true;
            }
        }
    }

    private var _resizer:GObject;
    private var widthfix:int;
    private var heightfix:int;
    private var mousefix:Point = new Point;

    public function get resizer():GObject
    {
    	return _resizer;
    }

    public function set resizer(value:GObject):void
    {
        if(this._resizer != value) {
            if(this._resizer != null) {
                this._resizer.draggable = false;
                this._resizer.off(Events.DRAG_START, this, this.___resizeStart);
            }
            
            this._resizer = value;
            if(this._resizer != null) {
                if(this._resizer is GGraph)
                    this._resizer.asGraph.drawRect(0,null,null);
                this._resizer.on(Event.MOUSE_DOWN,this,this.___resizeStart);
            }
        }
    }
    public function ___resizeStart(evt:Event):void {
        mousefix = this.globalToLocal(evt.stageX,evt.stageY,mousefix);
        this.widthfix = this.width-mousefix.x;
        this.heightfix = this.height-mousefix.y;
		GObject.cast(evt.currentTarget).stopDrag();
        GRoot.inst.on(Event.MOUSE_UP,this,resizeEnd);
		Laya.timer.loop(50,this,panelResize,null,true,true);
    }
    public function panelResize():void {
        var newPoint:Point = this.globalToLocal(this.displayListContainer.stage.mouseX,this.displayListContainer.stage.mouseY);
        var ww:int = newPoint.x+this.widthfix;
        var hh:int = newPoint.y+this.heightfix;
        ww = ww < miniWidth ? miniWidth : ww;
        hh = hh < miniH ? miniH : hh;
        this.setSize(ww,hh);
    }
    public function resizeEnd():void {
        GRoot.inst.off(Event.MOUSE_UP,this,resizeEnd);
        Laya.timer.clear(this,panelResize);
        this.panelResize();
    }

    public var miniWidth:int = 350;
    public var miniH:int = 150;
}
}