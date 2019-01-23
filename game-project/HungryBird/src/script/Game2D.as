package script {
import laya.utils.Handler;
import laya.net.Loader;
import fairygui.*;
import fairygui.GRoot;
import script.panels.MainPanel;
import Basic.UI_MainPanel;
import fairygui.Window;
import script.panels.PanelUtil;
import script.panels.NodePanel;

// 程序入口
public class Game2D {
    public function Game2D()
    {
        // Laya.init(1136, 640, Laya.WebGL);
        laya.utils.Stat.show(0, 0);
        //设置适配模式
        // Laya.stage.scaleMode = "showall";
        // Laya.stage.alignH = "left";
        // Laya.stage.alignV = "top";
        //设置横竖屏
        // Laya.stage.screenMode = "horizontal";
        
        Laya.loader.load([
            { url: "res/Basic_atlas0.png", type: Loader.IMAGE },
            { url: "res/Basic.fui", type: Loader.BUFFER }
        ], Handler.create(this, this.onLoaded));
    }
   
    public function onLoaded(): void {
        
        Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
        
        fairygui.UIPackage.addPackage("res/Basic");
        
        fairygui.UIConfig.defaultFont = "宋体";
        fairygui.UIConfig.verticalScrollBar = "ui://Basic/ScrollBar_VT";
        fairygui.UIConfig.horizontalScrollBar = "ui://Basic/ScrollBar_HZ";
        fairygui.UIConfig.popupMenu = "ui://Basic/PopupMenu";
        fairygui.UIConfig.buttonSound = "ui://Basic/click";

        PanelUtil.bindWindows();
        
        new MainPanel();
        new NodePanel();
    }
}
}