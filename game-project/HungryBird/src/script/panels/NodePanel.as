package script.panels {
import Basic.UI_Box;
import Basic.UI_MainPanel;
import Basic.UI_NodePanel;

import fairygui.GRoot;
import fairygui.Window;

import script.Box;

// 程序入口
public class NodePanel {
    public var v:UI_NodePanel = UI_NodePanel.createInstance();
    public function NodePanel()
    {
        var win:Window = PanelUtil.toWindow(v);
		win.bringToFontOnClick = false;
		
        v.x = 0;
        v.y = 0;
		v.m_nodeContainer;
		
		v.width = GRoot.inst.width;
		v.height = GRoot.inst.height;
		

        addTestBoxs();
    }

    private function addTestBoxs():void
    {
        var box:Box
        box = UI_Box.createInstance() as Box;
        box.x = 50;
        box.y = 50;
        v.addChild(box);


        box = UI_Box.createInstance() as Box;
        box.x = 30;
        box.y = 100;
        v.addChild(box);

        box = UI_Box.createInstance() as Box;
        box.x = 70;
        box.y = 100;
        v.addChild(box);
    }
}
}