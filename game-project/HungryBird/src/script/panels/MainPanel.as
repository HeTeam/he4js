package script.panels {
import laya.utils.Handler;
import laya.net.Loader;
import fairygui.*;
import fairygui.GRoot;
import Basic.UI_MainPanel;
import fairygui.Window;

// 程序入口
public class MainPanel {
    public function MainPanel()
    {
        var v:UI_MainPanel = UI_MainPanel.createInstance();
        v["contentPane"] = v;
        GRoot.inst.showWindow(v as Window);
        v.center();
    }
}
}