package script {
import Basic.BasicBinder;
import Basic.UI_MainPanel;

import fairygui.GRoot;
import fairygui.UIConfig;
import fairygui.UIPackage;
import fairygui.Window;

import laya.debug.tools.Base64Atlas;
import laya.debug.tools.Base64Tool;
import laya.net.Loader;
import laya.utils.Handler;

import script.panels.Alert;
import script.panels.MainPanel;
import script.panels.NodePanel;
import script.panels.PanelUtil;

// 程序入口
public class Game2D {
    //allinOne-start
    public static var allInOne:Boolean = false; //是否要集中所有文件到 index.html
    //allinOne-end
    public function Game2D()
    {
        // Laya.init(1136, 640, Laya.WebGL);
        // laya.utils.Stat.show(0, 0);
        // 设置适配模式
        // Laya.stage.scaleMode = "showall";
        // Laya.stage.alignH = "left";
        // Laya.stage.alignV = "top";
        // 设置横竖屏
        // Laya.stage.screenMode = "horizontal";
        if(!allInOne){
            Laya.loader.load([
                { url: "res/Basic_atlas0.png", type: Loader.IMAGE },
                { url: "res/Basic.fui", type: Loader.BUFFER }
            ], Handler.create(this, this.onLoaded));
        }else{
            //加载 index.html 中的 多个 png
            var _imgsData:*;
            __JS__('_imgsData = imgsData');
            var base64:Base64Atlas = new Base64Atlas(_imgsData);
            base64.preLoad(new Handler(this,onLoaded));
        }
    }
   
    public function onLoaded(): void {
        
        Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
        
        //如果要集中所有文件到 index.html
        if(allInOne){
            //加载 index.html 中的 UI 配置
            var _basicUIData:*;
            var _otherbin:*;
            __JS__('_basicUIData = basicUIData');
            __JS__('_otherbin = otherbin');
            fairygui.UIPackage.addPackage("res/Basic",laya.debug.tools.Base64Tool.decode(_basicUIData));
            Laya.loader.cacheRes("res/bird.sk",laya.debug.tools.Base64Tool.decode(_otherbin));
            // for(var key:String in _otherbin)
            // {
                // Laya.loader.cacheRes(key,laya.debug.tools.Base64Tool.decode(_otherbin[key]));
            // }
        }else{
            fairygui.UIPackage.addPackage("res/Basic");
        }
        
        fairygui.UIConfig.defaultFont = "宋体";
        fairygui.UIConfig.verticalScrollBar = "ui://Basic/ScrollBar_VT";
        fairygui.UIConfig.horizontalScrollBar = "ui://Basic/ScrollBar_HZ";
        fairygui.UIConfig.popupMenu = "ui://Basic/PopupMenu";
        fairygui.UIConfig.buttonSound = "ui://Basic/click";
        fairygui.UIConfig.clickDragSensitivity = 1;
        fairygui.UIConfig.touchDragSensitivity = 3;
        BasicBinder.bindAll();
        PanelUtil.bindWindows();
        
		new Alert();
        new NodePanel();
        new MainPanel();
    }
}
}