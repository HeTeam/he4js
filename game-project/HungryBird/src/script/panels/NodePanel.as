package script.panels {
import Basic.UI_Box;
import Basic.UI_MainPanel;
import Basic.UI_NodeContainer;
import Basic.UI_NodePanel;

import fairygui.GRoot;
import fairygui.Window;

import he.ai.EventNames;
import he.ai.Node;
import he.ai.Port;

import laya.events.Event;
import laya.utils.Handler;
import laya.utils.Tween;

import script.Box;
import he.ai.EventCenter;

// 程序入口
public class NodePanel {
    public var v:UI_NodePanel = UI_NodePanel.createInstance();
    private var isDrag:Boolean;

    private var nodeContainer:NodeContainer;
	private var lineContainer:LineContainer;

    private var moveStage:Boolean;
	private var help_tips:String = "右键或中建可拖拽背景视图";
    public function NodePanel()
    {
        v.x = 0;
        v.y = 0;
		nodeContainer = v.m_nodeContainer as NodeContainer;
		lineContainer = v.m_lineContainer as LineContainer;
		GRoot.inst.addChild(v);
		v.width = GRoot.inst.width;
		v.height = GRoot.inst.height;

		v.on(Event.MOUSE_DOWN,this,onDown);
		v.on(Event.RIGHT_MOUSE_DOWN,this,onDown);
		
		v.m_helpOver.onClick(this,onHelp);

        EventCenter.inst.on(EventNames.AddNode,this,onNodeAdd)
        EventCenter.inst.on(EventNames.Link,this,onLink)
        EventCenter.inst.on(EventNames.PortIndexChange,this,onIndexChange)
        EventCenter.inst.on(EventNames.Remove,this,onRemove)
    }

	private function onHelp():void
	{
		Alert.show(help_tips);
	}
	
	private function onDown(e:Event):void
	{
		moveStage = e.ctrlKey;
		if(e.type==Event.RIGHT_MOUSE_DOWN){
			moveStage = true;
		}
		if(e.touches && e.touches.length>1){
			moveStage = true; //两个手指或以上，视为平移操作
		}
		if(!moveStage){
			var item:* = e.target["$owner"];
			if(item && (item is UI_NodeContainer)){
				isDrag = true;
				//todo: 记录当前节点集窗口
				Laya.stage.on(Event.MOUSE_MOVE,this,onMove);
				Laya.stage.on(Event.MOUSE_UP,this,onUp);
			}
		}else{
			Laya.stage.on(Event.RIGHT_MOUSE_UP,this,onUp);
			nodeContainer.startDrag();
		}
	}
	private function onMove(e:Event):void
	{
		if(!moveStage){
			if(!isDrag)return;
			//todo: 如果有选择框，则处理选择框
		}
	}
	private function onUp(e:Event):void
	{
		nodeContainer.stopDrag();
		moveStage = false;
		if(isDrag){
			//todo: 如果有选择框，则处理选择框
		}
		isDrag = false;
	}

    private function onNodeAdd(node:Node):void{
        var box:Box
        box = UI_Box.createInstance() as Box;
		box.data = node;
		node.ui = box;
        box.x = Math.floor(50+ 160 * Math.random());
        box.y = Math.floor(50+ 500 * Math.random()); // todo： 改成其它布局，避免重叠
        nodeContainer.addChild(box);
	}
    private function onLink(port:Port):void {
		var has:* = LineContainer.inst.has(port.a,port.b);
		if(has){
			return;
		}
        var targetY:int = port.a.ui.y + 40;
		var targetX:int = port.a.ui.x + 25+(-50)*Math.random();
		Tween.to(port.b.ui,{y:targetY, x:targetX},100+300*Math.random(),laya.utils.Ease.circOut,Handler.create(this,addLine,[port.a,port.b]));
    }

    private function addLine(n1,n2):void {
        n1.ui.x = Math.round(n1.ui.x);
        n1.ui.y = Math.round(n1.ui.y);
        n2.ui.x = Math.round(n2.ui.x);
        n2.ui.y = Math.round(n2.ui.y);
        LineContainer.inst.drawLine(n1,n2);
    }
	private function onIndexChange(node:Node):void {
//        trace("onIndexChange",node);
    }
    private function onRemove(node:Node):void {
//        trace("onRemove",node);
    }
}
}