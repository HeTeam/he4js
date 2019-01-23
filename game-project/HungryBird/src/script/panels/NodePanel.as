package script.panels {
import Basic.UI_MainPanel;
import Basic.UI_NodePanel;

// 程序入口
public class NodePanel {
    public function NodePanel()
    {
        var v:UI_NodePanel = UI_NodePanel.createInstance();
        PanelUtil.toWindow(v);
        v.x = 330;
        v.y = 100;
    }
}
}