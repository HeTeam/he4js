package script.panels {
import Basic.UI_MainPanel;
import Basic.UI_MainPanelBirdContainer;
import Basic.UI_Nut1;
import Basic.UI_Nut2;

import fairygui.Controller;
import fairygui.GComponent;
import fairygui.GGraph;
import fairygui.GObject;

import laya.events.Event;
import laya.maths.Point;

import script.theitems.BoneAni;
import fairygui.Window;
import he.ai.Think;
import he.ai.Node;
import he.ai.Port;
import he.ai.NodeType;
import he.ai.EventCenter;
import he.ai.EventNames;

// 程序入口
public class MainPanel extends PanelWithResize{
    private var v:UI_MainPanel;
    private static var _inst:MainPanel;

    public static function inst():MainPanel{
        if(!_inst){
            _inst = new MainPanel();
        }
        return _inst;
    }
    public var bird_ui:BoneAni;
    public function MainPanel()
    {
        super.view = v = UI_MainPanel.createInstance();
        contentPane = v;
		v.m_frame.m_closeButton.visible = false;
        v.x = 300;
        v.y = 100;

        bird_ui = new BoneAni("res/bird.sk",true,AniEndFun,0.2,this);
        v.m_container.m_bird.setNativeObject(bird_ui);

		v.m_container.on(Event.MOUSE_DOWN,this,onContainerClick);

		v.m_btn_eat.onClick(this,onEat);

    }

    private function AniEndFun():void {
        bird_ui.mArmature.play("happy",true);
    }

    private function onEat():void {
        bird_ui.mArmature.play("eat",false);
    }
	
	private function onContainerClick(e:Event):void
	{
		var nut:GComponent;
		var isNut1:Boolean = v.m_selnut.selectedIndex==0;
		if(isNut1){
			nut = UI_Nut1.createInstance();
		}else{
			nut = UI_Nut2.createInstance();
		}
		var click_pos:Point = v.m_container.globalToLocal(e.stageX,e.stageY);
		nut.x = click_pos.x;
		nut.y = click_pos.y;
		nut.setScale(0.5,0.5);
		v.m_container.addChild(nut);
		sortScene();

		var nut_node:Node = new Node();

		var attr_node1:Node = new Node();
        attr_node1.baseType = NodeType.Distance;
        attr_node1.value = getDistance(v.m_container.m_bird,nut);
		var port1:Port = nut_node.addPortByNode(attr_node1);
		EventCenter.inst.event(EventNames.Link,[port1]);

        var attr_node2:Node = new Node();
        attr_node2.baseType = NodeType.CanEat;
        attr_node2.value = isNut1 ? 0:1;
		var port2:Port = nut_node.addPortByNode(attr_node2);
		EventCenter.inst.event(EventNames.Link,[port2]);

		Think.inst.dataIn(nut_node);
	}
	
	private static var apos:Point = new Point;
	private function getDistance(a:GObject,b:GObject):Number{
		apos.x = a.x;
		apos.y = a.y;
		return apos.distance(b.x,b.y);
	}
	private function sortScene():void
	{
		var sort:Vector.<fairygui.GObject> = v.m_container._children.slice().sort(sortY);
		for (var i:int = 0; i < sort.length; i++) 
		{
			sort[i].sortingOrder = i;
		}
	}
	
	private function sortY(a:GComponent,b:GComponent):int
	{
		if(a.y > b.y)return 1;
		if(b.y > a.y)return -1;
		return 0;
	}
	
}
}