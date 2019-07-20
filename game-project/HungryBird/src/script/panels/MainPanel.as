package script.panels {
import Basic.UI_KillNut2Ani;
import Basic.UI_MainPanel;
import Basic.UI_Nut1;
import Basic.UI_Nut2;

import fairygui.GComponent;
import fairygui.GObject;
import fairygui.utils.ColorMatrix;

import laya.events.Event;
import laya.filters.ColorFilter;
import laya.maths.Point;

import script.theitems.BoneAni;
import he.ai.Think;
import he.ai.Node;
import he.ai.Port;
import he.ai.NodeType;
import he.ai.EventCenter;
import he.ai.EventNames;

// 程序入口
public class MainPanel extends PanelWithResize{
	private var v:UI_MainPanel;
	private static var _inst:MainPanel;

	public static function inst():MainPanel{
		if(!_inst){
			_inst = new MainPanel();
		}
		return _inst;
	}
	public var bird_ui:BoneAni;
    private static var colorFilter:ColorFilter;
	public function MainPanel()
	{
		super.view = v = UI_MainPanel.createInstance();
		contentPane = v;
		v.m_frame.m_closeButton.visible = false;
		v.x = 300;
		v.y = 100;

		bird_ui = new BoneAni("res/bird.sk",true,AniEndFun,0.2,this);
		v.m_container.m_bird.m_birdReplaceHolder.setNativeObject(bird_ui);
        v.m_container.m_bird.on(Event.MOUSE_DOWN,this,onBirdMouseDown);
        v.m_container.m_bird.on(Event.MOUSE_UP,this,onBirdMouseUp);

		v.m_container.on(Event.MOUSE_DOWN,this,onContainerClick);

		v.m_btn_eat.onClick(this,onEat);

        v.m_selnut.selectedIndex = 1;

        var cm:ColorMatrix = new ColorMatrix();
        cm.adjustBrightness(0.2);
        cm.adjustContrast(0.6);
        cm.adjustSaturation(-0.4);
        cm.adjustHue(-0.2);
        colorFilter = new ColorFilter(cm);

	}

    //闪烁效果，瞬时提高物体的亮度，随后恢复。
    public static function flash(ob:GObject,time:int=1000):void
    {
        ob.filters = [colorFilter];
        Laya.timer.once(time,{},backToNormalColor,[ob],false);
    }

    public static function backToNormalColor(ob:GObject):void
    {
        ob.filters = [];
    }

	private function AniEndFun():void {
		bird_ui.mArmature.play("happy",true);
	}

	private function onEat():void {
		//上帝模式（硬编码部分，不涉及智能）：
		//找到距离最近的坚果，让小鸟转身，做出吃的动作，让坚果消失

		var nut:GComponent = findNearNut();
		bird_ui.mArmature.play("eat",false);
        if(nut){
            var isNut1:Boolean = nut is UI_Nut1;
            var isNut2:Boolean = nut is UI_Nut2;

            faceToNut(nut);

            Laya.timer.once(200,this,flash,[nut,55]); // 闪一下坚果。

            if(isNut1){
                Laya.timer.once(255,{},function(nut:GComponent):void {
                    (nut as UI_Nut1).m_t0.play(); //播放震动动画，仅仅是震动，因为小鸟难以将坚果破壳。
                },[nut],false);
            }
            if(isNut2){
                // 如果可以吃，则坚果消失。 // todo: 小于一定距离才能吃。
                removeNut(nut);
                //todo: 此时应给小鸟一个兴奋的信号，以奖励其行为，调动其情绪，带动小鸟记录和思考。
                //todo: 是否要去除脑海里的 Node ？ 可能不需要，小鸟对比世界后自己删除？也可能不需要，
                //todo：Nut 可以活在记忆中，除非年代久远或该 Nut 并无特殊，则可去除（通过睡眠？需要实现睡眠清理机）。
            }
        }
	}

    private function removeNut(nut:GComponent):void {
        Laya.timer.once(333,this,realRemoveNut,[nut]);
    }

    private function realRemoveNut(nut:GComponent):void {
        createEff(UI_KillNut2Ani.createInstance(),nut);
        nut.removeFromParent();
        nut.dispose();
    }

    private function createEff(ani:GComponent, nut:GComponent,removeEffTime:int = 255):void {
        nut.parent.addChild(ani);
        ani.x = nut.x;
        ani.y = nut.y;
        Laya.timer.once(removeEffTime,{},function(ani:GComponent):void {
            ani.removeFromParent();
        },[ani],false);
    }

    private function faceToNut(nut:GComponent):void {
        var rightHand:Boolean = v.m_container.m_bird.x > nut.x;
        v.m_container.m_bird.scaleX = rightHand? 1:-1;
    }

	private function findNearNut():GComponent {
        var num:int = v.m_container.numChildren;
        var dist:Number = 9999999;
        var theNut:GObject;
        for(var i:int = 0; i<num ; i++){
            var ob:GObject = v.m_container.getChildAt(i);
            var isNut1:Boolean = ob is UI_Nut1;
            var isNut2:Boolean = ob is UI_Nut2;
            if(isNut1 || isNut2){
                var p0:Point = new Point(v.m_container.m_bird.x,v.m_container.m_bird.y);
                var p1:Point = new Point(ob.x,ob.y);
                var tmpDist:Number = p1.distance(p0.x,p0.y);
                if(tmpDist < dist){
                    dist = tmpDist;
                    //trace(p0,p1,tmpDist);
                    theNut = ob;
                }
            }
        }
        return theNut as GComponent;
	}
	private var unSel:String="unsel";
	private function onContainerClick(e:Event):void
	{
        if(v.m_selnut.selectedPage==unSel){
            return;
        }
		var nut:GComponent;
		var isNut1:Boolean = v.m_selnut.selectedIndex==0;
		if(isNut1){
			nut = UI_Nut1.createInstance();
		}else{
			nut = UI_Nut2.createInstance();
		}
		var click_pos:Point = v.m_container.globalToLocal(e.stageX,e.stageY);
		nut.x = click_pos.x;
		nut.y = click_pos.y;
		nut.setScale(0.5,0.5);
        nut.on(Event.MOUSE_DOWN,this,onNutMouseDown,[nut]);
        nut.on(Event.MOUSE_DOWN,this,onNutMouseUp,[nut]);
		v.m_container.addChild(nut);
		sortScene();

		var nut_node:Node = new Node();

		var attr_node1:Node = new Node();
		attr_node1.baseType = NodeType.Distance;
		attr_node1.value = getDistance(v.m_container.m_bird,nut);
		var port1:Port = nut_node.addPortByNode(attr_node1);
		EventCenter.inst.event(EventNames.Link,[port1]);

		var attr_node2:Node = new Node();
		attr_node2.baseType = NodeType.CanEat;
		attr_node2.value = isNut1 ? 0:1;
		var port2:Port = nut_node.addPortByNode(attr_node2);
		EventCenter.inst.event(EventNames.Link,[port2]);

        nut.data = nut_node;

		Think.inst.dataIn(nut_node);

        v.m_selnut.selectedPage = unSel;
	}
    //小鸟位置变化后，重新排序
    private function onBirdMouseUp():void {
        if(v.m_selnut.selectedPage==unSel){
            sortScene();
        }
    }

    //可以用鼠标移动小鸟。
    private function onBirdMouseDown():void {
        if(v.m_selnut.selectedPage==unSel){
            v.m_container.m_bird.startDrag();
        }
    }

    //坚果位置变化后，重新排序
    private function onNutMouseUp(nut:GComponent):void {
        if(v.m_selnut.selectedPage==unSel){
            sortScene();
        }
    }

    //按钮没有被选中的情况下，可以移动坚果。
    private function onNutMouseDown(nut:GComponent):void {
        if(v.m_selnut.selectedPage==unSel){
            nut.startDrag();
        }
    }
	
	private static var apos:Point = new Point;
	private function getDistance(a:GObject,b:GObject):Number{
		apos.x = a.x;
		apos.y = a.y;
		return apos.distance(b.x,b.y);
	}
	private function sortScene():void
	{
		var sort:Vector.<fairygui.GObject> = v.m_container._children.slice().sort(sortY);
		for (var i:int = 0; i < sort.length; i++) 
		{
			sort[i].sortingOrder = i;
		}
	}
	
	private function sortY(a:GComponent,b:GComponent):int
	{
		if(a.y > b.y)return 1;
		if(b.y > a.y)return -1;
		return 0;
	}
	
}
}