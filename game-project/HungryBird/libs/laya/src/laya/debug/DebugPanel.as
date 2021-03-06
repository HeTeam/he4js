package laya.debug {
	import laya.debug.DebugTool;
	import laya.debug.divui.DivScripts;
	import laya.debug.tools.AtlasTools;
	import laya.debug.tools.CacheAnalyser;
	import laya.debug.tools.ClassTool;
	import laya.debug.tools.ClickSelectTool;
	import laya.debug.tools.enginehook.RenderSpriteHook;
	import laya.debug.tools.enginehook.SpriteRenderHook;
	import laya.debug.tools.IDTools;
	import laya.debug.tools.JsonTool;
	import laya.debug.tools.JSTools;
	import laya.debug.tools.ObjectTools;
	import laya.debug.view.nodeInfo.NodeUtils;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.MathUtil;
	import laya.utils.Browser;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ww
	 */
	public class DebugPanel {
		
		public function DebugPanel() {
			_init();
		}
		public static var I:DebugPanel;
		private static var overlay:Boolean;
		private static var _enable:Boolean = false;
		
		/**
		 * 启动调试面板
		 * @param underGame 是否在游戏下方显示，true:将改变原游戏的大小,false:直接覆盖在游戏上方
		 * @param bgColor 调试面板背景颜色
		 */
		public static function enable(underGame:Boolean = true, bgColor:String = "#ffffff"):void {
			if (!_enable && !I) {
				_enable = true;
				overlay = !underGame;
				DivScripts.init();
				DebugTool.initBasicFunctions();
				RenderSpriteHook.init();
				SpriteRenderHook.init();
				I = new DebugPanel();
				I.setRoot(Laya.stage);
				CacheAnalyser.showRecacheSprite = false;
				if (bgColor) {
					I.div.style.background = bgColor;
				}
			}		
		}
		
		public static const ChildrenSign:String = "item";
		public static const LabelSign:String = "text";
		
		public static function getSpriteTreeArr(sprite:Sprite):Object {
			var rst:Object;
			rst = {};
			rst[LabelSign] = "" + ClassTool.getNodeClassAndName(sprite);
			rst.target = sprite;
			IDTools.idObj(sprite);
			rst.id = IDTools.getObjID(sprite);
			var childs:Array;
			childs = sprite._children;
			var i:int, len:int;
			len = childs.length;
			var tchild:Object;
			var childsList:Array;
			childsList = [];
			rst[ChildrenSign] = childsList;
			for (i = 0; i < len; i++) {
				childsList.push(getSpriteTreeArr(childs[i]));
				
			}
			return rst;
		}
		public static var displayTypes:Object = {"boolean": true, "number": true, "string": true};
		public static var displayKeys:Array = [["x", "number"], ["y", "number"], ["width", "number"], ["width", "number"], ["width", "number"], ["width", "number"], ["width", "number"], ["width", "number"], ["width", "number"], ["width", "number"], ["width", "number"],];
		public static var tObjKeys:Array = [];
		public var tShowObj:Object;
		public var preValueO:Object = {};
		public static var noDisplayKeys:Object = {"desginWidth": true, "desginHeight": true};
		public static const Bottom:String = "bottom";
		public static const Right:String = "right";
		public static var sideType:String = Bottom;
		
		private function removeNoDisplayKeys(arr:Array):void {
			var i:int;
			for (i = arr.length - 1; i >= 0; i--) {
				if (noDisplayKeys[arr[i]]) {
					arr.splice(i, 1);
				}
			}
		}
		
		public function updateShowKeys():void {
			tObjKeys.length = 0;
			if (!tShowObj)
				return;
			tObjKeys = ClassTool.getObjectDisplayAbleKeys(tShowObj, tObjKeys);
			if (tShowObj == Laya.stage) {
				removeNoDisplayKeys(tObjKeys);
			}
			
			tObjKeys.sort(MathUtil.sortSmallFirst);
		}
		
		public static function getObjectData(data:Object):Array {
			var dataList:Array;
			var tData:Object;
			var key:String;
			var tValue:*;
			var tType:String;
			dataList = [];
			var keys:Array;
			keys = tObjKeys;
			var i:int, len:int;
			len = keys.length;
			for (i = 0; i < len; i++) {
				key = keys[i];
				tValue = data[key];
				tType = typeof(tValue);
				if (key.charAt(0) == "_")
					continue;
				if (displayTypes[tType]) {
					tData = {};
					tData["key"] = key;
					tData["value"] = tValue;
					tData["type"] = tType;
					dataList.push(tData);
				}
			}
			
			return dataList;
		}
		public var div:*;
		public var debug_view:*;
		public var height:Number = 300;
		public var width:Number = 600;
		public var clickedHandler:Handler;
		
		private function _init():void {
			div = Browser.document.createElement('div');
			Browser.document.body.appendChild(div);
			clickedHandler = new Handler(this, onClickSelected);
			debug_view = Browser.window.layaair_debug_view;
			debug_view.initLayaAirDebugView(div);
			debug_view.tree.attachEvent("onSelect", function(id:*):void {
					var dataO:Object;
					dataO = getDataByID(id, _treeDataList[0]);
					if (dataO.target) {
						DebugTool.showDisBound(dataO.target);
						showTargetInfo(dataO.target);
					}
				
				});
			debug_view.setValueChangeHandler(function(data:*, new_value:*):void {
					onValueChange(data, new_value);
				});
			debug_view.onRefresh(function():void {
					I.setRoot(Laya.stage);
				});
			debug_view.onInspectElement(function():void {
					ClickSelectTool.I.beginClickSelect(clickedHandler);
				});
			debug_view.onLogInfo(function():void {
					trace(tShowObj);
				});
			debug_view.onPrintEnabledNodeChain(function():void {
					DebugTool.traceDisMouseEnable(tShowObj);
				});
			debug_view.onPrintSizeChain(function():void {
					DebugTool.traceDisSizeChain(tShowObj);
				});
			debug_view.onToggleVisibility(function(selectd:*):void {
					if (tShowObj) {
						tShowObj.visible = debug_view.getVisibility();
					}
				});
			debug_view.onToggleDebugBorder(function(selectd:*):void {
					if (!tShowObj)
						return;
					SpriteRenderHook.showDisplayBorder(tShowObj, debug_view.getShowDebugBorder());
				});
			debug_view.onToggleShowCurrentCache(function(selectd:*):void {
					CacheAnalyser.showRecacheSprite = debug_view.getShowCurrentCache();
				});
			debug_view.onToggleShowAllCache(function(selectd:*):void {
					CacheAnalyser.showCacheSprite = debug_view.getShowAllCache();
				});
			debug_view.onToggleShowAtlas(function(selectd:*):void {
					trace("toggle show atlas:", debug_view.getShowAtlas());
					if (debug_view.getShowAtlas()) {
						AtlasTools.getInstance().start();
					}
					else {
						AtlasTools.getInstance().end();
					}
				
				});
			
			JSTools.showToBody(div, 0, 0);
			initNewDivs();
			initDragWork();
			initTreeWidthDrag();
			Laya.stage.on(Event.RESIZE, this, adptPos);
			adptPos();
		}
		private function initNewDivs():void
		{
			var parentNode:*;
			parentNode = Browser.document.getElementById("show_current_cache_control").parentNode;
			var switchNode:*;
			switchNode = Browser.createElement("input");
			switchNode.type = "checkbox";
			parentNode.appendChild(switchNode);
			parentNode.append("右侧");
			function onSwitchChange(e:*):void
			{
				if (e.target.checked)
				{
					sideType = Right;
				}else
				{
					sideType = Bottom;
				}
				adptPos();
			}
			switchNode.addEventListener("change", onSwitchChange);
		}
		private var dragArea:Number = 10;
		
		private static function getOffset(e:*, sign:String):Number
		{
			var target:*;
			target = e.target;
			var cTarget:*;
			cTarget = e.currentTarget;
			var kSign:String;
			if (sign == "X")
			{
				kSign = "offsetLeft";
			}else
			{
				kSign = "offsetTop";
			}
			var value:Number;
			value = e["offset" + sign];
			while (target&&target != cTarget)
			{
				value += target[kSign];
				target = target.offsetParent;
			}
			
			return value;
		}
		
		private function initTreeWidthDrag():void
		{
			
			var leftDiv:*;
			var rightDiv:*;
			leftDiv = Browser.document.getElementById("tree_container");
			var parentNode:*;
			parentNode = leftDiv.parentNode;
			rightDiv = parentNode.children[1];
			var isMouseDown:Boolean = false;
			var preX:Number;
			var preY:Number;
			
			
			function onDivMouseMove(e:*):void {
				
				var abs:Number;
				abs = Math.abs(getOffset(e, "X")-leftDiv.clientWidth);
				if (abs < dragArea)
				{
					div.style.cursor = "e-resize";
				}else
				{
					div.style.cursor = "auto";
				}
				//e.stopPropagation();
			
			}
			function onDivMouseDown(e:*):void {
				var abs:Number;
				abs = Math.abs(getOffset(e, "X")-leftDiv.clientWidth);
				if (abs < dragArea)
				{
					div.style.cursor = "e-resize";
					isMouseDown = true;
				}else
				{
					isMouseDown = false;
					return;
				}
				e.stopPropagation();
			}
			function onBodyMouseMove(e:*):void {
				if (!isMouseDown)
					return;
				leftDiv.style.width = getOffset(e, "X")+"px";
				e.stopPropagation();
			}
			function onDivMouseUp(e:*):void {
				if (!isMouseDown)
					return;
				isMouseDown = false;
				e.stopPropagation();
			}
			parentNode.addEventListener("mousedown", onDivMouseDown,true)
			parentNode.addEventListener("mousemove", onDivMouseMove,true)
			Browser.document.body.addEventListener("mousemove", onBodyMouseMove)
			Browser.document.body.addEventListener("mouseup", onDivMouseUp)
		}
		private function initDragWork():void {
			var isMouseDown:Boolean = false;
			var preX:Number;
			var preY:Number;
			
			
			function onDivMouseMove(e:*):void {
				if (sideType == Bottom) {
					if (getOffset(e,"Y") < dragArea) {
						div.style.cursor = "n-resize";
					}
					else {
						div.style.cursor = "auto";
					}
				}
				else {
					if (getOffset(e,"X") < dragArea) {
						div.style.cursor = "e-resize";
					}
					else {
						div.style.cursor = "auto";
					}
				}
			
			}
			function onDivMouseDown(e:*):void {
				if (sideType == Bottom)
				{
					if (getOffset(e,"Y") > dragArea)
					return;
				}else
				{
					if (getOffset(e,"X") > dragArea)
					return;
				}
				
				isMouseDown = true;
				preX = e.pageX;
				preY = e.pageY;
				e.stopPropagation();
			}
			function onBodyMouseMove(e:*):void {
				if (!isMouseDown)
					return;
				var curX:Number;
				var curY:Number;
				var dX:Number;
				var dY:Number;
				curX = e.pageX;
				curY = e.pageY;
				dX = curX - preX;
				dY = curY - preY;
				if (sideType == Bottom)
				{
					this.height -= dY;
				}else
				{
					this.width -= dX;
				}
				
				adptPos();
				preX = curX;
				preY = curY;
				e.stopPropagation();
			}
			function onDivMouseUp(e:*):void {
				if (!isMouseDown)
					return;
				isMouseDown = false;
				e.stopPropagation();
			}
			div.addEventListener("mousedown", onDivMouseDown,true)
			div.addEventListener("mousemove", onDivMouseMove,true)
			Browser.document.body.addEventListener("mousemove", onBodyMouseMove)
			Browser.document.body.addEventListener("mouseup", onDivMouseUp)
		}
		
		private function onClickSelected(target:*):void {
			var dataO:Object;
			if (!_treeDataList)
				return;
			debug_view.tree.selectItem(IDTools.getObjID(target));
			//debug_view.tree.focusItem(IDTools.getObjID(target));
			debug_view.bounceUpInspectButton();
		}
		
		private function updateLoop():void {
			if (tShowObj) {
				showTargetInfo(tShowObj);
			}
		}
		
		private function onSelectItem(obj:Object):void {
			var tTarget:*;
			tTarget = obj.target;
			showTargetInfo(tTarget);
		}
		
		public static function mParseFloat(v:*):Number {
			var rst:Number;
			rst = parseFloat(v);
			if (isNaN(rst))
				return 0;
			return rst;
		}
		
		private function onValueChange(obj:Object, newValue:*):void {
			if (obj["type"] == "number") {
				newValue = mParseFloat(newValue);
			}
			if (obj["type"] == "boolean") {
				newValue = newValue.toString() == "true";
			}
			if (tShowObj) {
				var key:String;
				key = obj["key"];
				preValueO[key] = tShowObj[key] = newValue;
			}
		}
		
		public function showTargetInfo(tTarget:Object):void {
			if (!tTarget)
				return;
			debug_view.setVisibility(tTarget.visible);
			debug_view.setShowDebugBorder(SpriteRenderHook.isDisplayShowBorder(tTarget));
			var i:int, len:int;
			len = tObjKeys.length;
			var key:String;
			if (tShowObj == tTarget) {
				for (i = 0; i < len; i++) {
					key = tObjKeys[i];
					if (preValueO[key] != tTarget[key]) {
						debug_view.changeValueByLabel(key, tTarget[key]);
					}
				}
			}
			else {
				tShowObj = tTarget;
				updateShowKeys();
				var dataList:Array;
				dataList = getObjectData(tTarget);
				debug_view.setContents(dataList);
			}
			
			for (i = 0; i < len; i++) {
				key = tObjKeys[i];
				preValueO[key] = tTarget[key];
			}
		}
		
		private var fromMe:Boolean = false;
		
		private function adptPos():void {
			if (fromMe)
				return;
			fromMe = true;
			
			if (sideType == Bottom) {
				JSTools.setPos(div, 0, Browser.clientHeight - this.height);
				debug_view.resize(Browser.clientWidth, this.height);
				if (!overlay) {
					Laya.stage.setScreenSize(Browser.clientWidth * Browser.pixelRatio, (Browser.clientHeight - this.height) * Browser.pixelRatio);
				}
			}
			else {
				JSTools.setPos(div, Browser.clientWidth - this.width, 0);
				debug_view.resize(this.width, Browser.clientHeight);
				if (!overlay) {
					Laya.stage.setScreenSize((Browser.clientWidth - this.width) * Browser.pixelRatio, Browser.clientHeight * Browser.pixelRatio);
				}
			}
			
			fromMe = false;
		}
		
		private var _treeDataList:Array;
		
		public function setRoot(sprite:Sprite):void {
			var mtreeo:Object;
			mtreeo = getSpriteTreeArr(sprite);
			_treeDataList = [mtreeo];
			
			var wraped:Object;
			wraped = {};
			wraped.id = 0;
			wraped.item = [mtreeo];
			debug_view.setTree(wraped);
			Laya.timer.loop(500, this, updateLoop);
		}
		
		public function getDataByID(targetID:String, nodeO:Object):Object {
			if (!nodeO)
				return null;
			if (targetID == nodeO.id)
				return nodeO;
			var childs:Array;
			childs = nodeO[ChildrenSign];
			if (!childs)
				return null;
			var i:int, len:int;
			len = childs.length;
			var tRst:Object;
			for (i = 0; i < len; i++) {
				tRst = getDataByID(targetID, childs[i]);
				if (tRst)
					return tRst;
			}
			return null;
		}
		
		public function getDataByTarget(target:*, nodeO:Object):Object {
			if (!nodeO)
				return null;
			if (target == nodeO.target)
				return nodeO;
			var childs:Array;
			childs = nodeO[ChildrenSign];
			if (!childs)
				return null;
			var i:int, len:int;
			len = childs.length;
			var tRst:Object;
			for (i = 0; i < len; i++) {
				tRst = getDataByTarget(target, childs[i]);
				if (tRst)
					return tRst;
			}
			return null;
		
		}
	}

}