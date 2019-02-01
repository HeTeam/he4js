package script.panels {
import Basic.UI_Box;
import Basic.UI_MainPanel;
import Basic.UI_NodeContainer;
import Basic.UI_NodePanel;

import fairygui.GRoot;
import fairygui.Window;

import script.Box;

// 程序入口
public class PanelUtil {
    public static function bindWindows():void{
        fairygui.UIObjectFactory.setPackageItemExtension(UI_MainPanel.URL, PanelWithResize);
        fairygui.UIObjectFactory.setPackageItemExtension(UI_Box.URL, Box);
        fairygui.UIObjectFactory.setPackageItemExtension(UI_NodeContainer.URL, NodeContainer);
    }
    public static function toWindow(v,show:Boolean=true):Window{
        v["contentPane"] = v;
        if(show){
            GRoot.inst.showWindow(v as Window);
        }
		return v as Window;
    }
}
}