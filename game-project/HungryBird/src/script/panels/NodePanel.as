package script.panels {
import Basic.UI_Box;
import Basic.UI_MainPanel;
import Basic.UI_NodeContainer;
import Basic.UI_NodePanel;

import fairygui.GRoot;
import fairygui.Window;

import laya.events.Event;

import script.Box;
import he.ai.EventCenter;

// 程序入口
public class NodePanel {
    public var v:UI_NodePanel = UI_NodePanel.createInstance();
    private var isDrag:Boolean;

    private var nodeContainer:NodeContainer;

    private var moveStage:Boolean;
	private var help_tips:String = "右键或中建可拖拽背景视图";
    public function NodePanel()
    {
        v.x = 0;
        v.y = 0;
		nodeContainer = v.m_nodeContainer as NodeContainer;
		GRoot.inst.addChild(v);
		v.width = GRoot.inst.width;
		v.height = GRoot.inst.height;

        addTestBoxs();
		v.on(Event.MOUSE_DOWN,this,onDown);
		v.on(Event.RIGHT_MOUSE_DOWN,this,onDown);
		
		v.m_helpOver.onClick(this,onHelp);

		EventCenter.inst.on(Event.ADDED,this,onNodeAdd)
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
    private function addTestBoxs():void
    {
        var box:Box
        box = UI_Box.createInstance() as Box;
        box.x = 50;
        box.y = 50;
		nodeContainer.addChild(box);

        box = UI_Box.createInstance() as Box;
        box.x = 30;
        box.y = 100;
		nodeContainer.addChild(box);

        box = UI_Box.createInstance() as Box;
        box.x = 70;
        box.y = 100;
		nodeContainer.addChild(box);
    }

    public function onNodeAdd(e,d):void{
		trace(e,d);
	}
}
}