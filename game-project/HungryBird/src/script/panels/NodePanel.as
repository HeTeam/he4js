package script.panels {
import Basic.UI_MainPanel;
import Basic.UI_NodePanel;
import Basic.UI_Box;
import script.Box;

// 程序入口
public class NodePanel {
    public var v:UI_NodePanel = UI_NodePanel.createInstance();
    public function NodePanel()
    {
        PanelUtil.toWindow(v);
        v.x = 330;
        v.y = 100;

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