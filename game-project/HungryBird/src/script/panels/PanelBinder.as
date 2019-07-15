package script.panels {
import Basic.UI_Box;
import Basic.UI_LineContainer;
import Basic.UI_MainPanel;
import Basic.UI_NodeContainer;
import Basic.UI_NodePanel;

import fairygui.GRoot;
import fairygui.Window;

import script.Box;

// 程序入口
public class PanelBinder {
    public static function bindAll():void{
        fairygui.UIObjectFactory.setPackageItemExtension(UI_Box.URL, Box);
        fairygui.UIObjectFactory.setPackageItemExtension(UI_NodeContainer.URL, NodeContainer);
        fairygui.UIObjectFactory.setPackageItemExtension(UI_LineContainer.URL, LineContainer);
    }
}
}