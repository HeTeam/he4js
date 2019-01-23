package script.panels {
import Basic.UI_MainPanel;

// 程序入口
public class MainPanel {
    public function MainPanel()
    {
        var v:UI_MainPanel = UI_MainPanel.createInstance();
        PanelUtil.toWindow(v);
        v.x = 10;
        v.y = 100;
    }
}
}