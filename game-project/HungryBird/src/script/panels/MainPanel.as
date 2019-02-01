package script.panels {
import Basic.UI_MainPanel;
import Basic.UI_MainPanelBirdContainer;
import Basic.UI_Nut1;
import Basic.UI_Nut2;

import fairygui.Controller;
import fairygui.GComponent;
import fairygui.GGraph;
import fairygui.GObject;

import laya.display.Sprite;
import laya.events.Event;
import laya.maths.Point;

import script.theitems.BoneAni;

// 程序入口
public class MainPanel {
    public var m_container:UI_MainPanelBirdContainer;
    public var m_bird:GGraph;
    public var bird_ui:BoneAni;
    private var v:UI_MainPanel;
    private var m_selnut:Controller;
    public function MainPanel()
    {
        v = UI_MainPanel.createInstance();
		m_selnut = v.getControllerAt(0);
        m_container = UI_MainPanelBirdContainer(v.getChildAt(1));
        m_bird = m_container.m_bird;
        PanelUtil.toWindow(v);
        
        v.x = 300;
        v.y = 100;

        bird_ui = new BoneAni("res/bird.sk",true,null,0.2);
		m_bird.setNativeObject(bird_ui);
		
		m_container.on(Event.MOUSE_DOWN,this,onContainerClick);
    }
	
	private function onContainerClick(e:Event):void
	{
		var nut:GComponent;
		if(m_selnut.selectedIndex==0){
			nut = UI_Nut1.createInstance();
		}else{
			nut = UI_Nut2.createInstance();
		}
		var click_pos:Point = m_container.globalToLocal(e.stageX,e.stageY);
		nut.x = click_pos.x;
		nut.y = click_pos.y;
		nut.setScale(0.5,0.5);
		m_container.addChild(nut);
		sortScene();
	}
	
	private function sortScene():void
	{
		var sort:Vector.<fairygui.GObject> = m_container._children.slice().sort(sortY);
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