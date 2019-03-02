package script.panels
{
	import Basic.UI_NodeContainer;

import fairygui.GGraph;

import he.ai.Node;

import laya.display.Graphics;

import laya.display.Sprite;
import he.ai.Util;
import laya.utils.Tween;

public class LineContainer extends UI_NodeContainer
	{
		public function LineContainer()
		{
			super();
		}
        private static var _instance:LineContainer;

        public static function get inst():LineContainer
        {
            return _instance;
        }
		protected override function constructFromXML(xml:Object):void
		{
			super.constructFromXML(xml);
            _instance = this;
			removeChildren();
		}
		public static var dic:Object = new Object();
        public function has(n1,n2):*{
            var sortedID:String = Util.getSortIDs(n1,n2);
			var line:Object = dic[sortedID];
            return line;
        }
        public function drawLine(node:Node, childNode:Node, del:Boolean = false):void {
			var sortedID:String = Util.getSortIDs(node,childNode);
			var line:Object = dic[sortedID];
			if(del){
                if(line){
                    remove(line);
                }
                return;
			}
            if(!line){
				line = {};
                createLine(line,node,childNode);
                dic[sortedID] = line;
            }else{
                update(line);
            }
        }
        private function createLine(line:Object,n1,n2):void
        {
            var g:GGraph = new GGraph();
            addChild(g);
            var s:Sprite = new Sprite();
            g.setNativeObject(s);
            line.g = g;
            line.s = s;
			line.from = n1;
			line.to = n2;
            s.alpha = 0;
            Tween.to(s,{alpha:1},100);
            update(line);
        }
        private function update(line:Object):void
        {
            var g:GGraph = line.g;
            var s:Sprite = line.s;
            var graphics:Graphics = s.graphics;
            graphics.clear();
            g.x = line.from.ui.x+10;
            g.y = line.from.ui.y+10;
            graphics.drawLine(0,0,line.to.ui.x-line.from.ui.x,line.to.ui.y-line.from.ui.y,"#555522",1);
        }
        private function remove(line:Object):void
        {
            var g:GGraph = line.g;
            g.removeFromParent();
            delete dic[line.key];
        }
    }
}