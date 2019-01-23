package script.panels {
import fairygui.GRoot;
import fairygui.Window;
import Basic.UI_MainPanel;
import Basic.UI_NodePanel;

// 程序入口
public class PanelUtil {
    public static function bindWindows():void{
        fairygui.UIObjectFactory.setPackageItemExtension(UI_MainPanel.URL, PanelWithResize);
        fairygui.UIObjectFactory.setPackageItemExtension(UI_NodePanel.URL, PanelWithResize);
    }
    public static function toWindow(v,show:Boolean=true):void{
        v["contentPane"] = v;
        if(show){
            GRoot.inst.showWindow(v as Window);
        }
    }
}
}