package script.panels {
import Basic.UI_MainPanel;
import script.theitems.BoneAni
import laya.display.Sprite;
import fairygui.GGraph;
import Basic.UI_MainPanelBirdContainer;

// 程序入口
public class MainPanel {
    public var m_container:UI_MainPanelBirdContainer;
    public var m_bird:GGraph;
    public var bird_ui:BoneAni;
    public function MainPanel()
    {
        var v:UI_MainPanel = UI_MainPanel.createInstance();
        m_container = UI_MainPanelBirdContainer(v.getChildAt(1));
        m_bird = m_container.m_bird;
        PanelUtil.toWindow(v);
        
        v.x = 10;
        v.y = 100;

        bird_ui = new BoneAni("res/bird.sk",true,null,0.2);
		m_bird.setNativeObject(bird_ui);
    }

}
}