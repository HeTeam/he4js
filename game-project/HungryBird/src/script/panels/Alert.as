package script.panels
{
	import Basic.UI_Alert;
	import Basic.UI_Mask;
	
	import fairygui.GObject;
	import fairygui.GRoot;
	import fairygui.UIConfig;
	import fairygui.Window;
	
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.utils.Tween;
	
	public class Alert extends Window
	{
		public static var ins:Alert;
		public var v:UI_Alert;
		
		public function get getInputCall():Function
		{
			return _getInputCall;
		}
		
		public function set getInputCall(value:Function):void
		{
			_getInputCall = value;
		}
		
		private var okCall:Function;
		
		private var noCall:Function;
		
		private var _getInputCall:Function;
		
		private static var theThis:Object;
		
		private static var okWhenPressEnter:Boolean;
		public function Alert()
		{
			if(ins){
				console.log("Alert 单例对象不能用 new 创建");
			}
			super();
			modal = true;
			v = UI_Alert.createInstance();
			fairygui.UIConfig.globalModalWaiting = UI_Mask.URL;
			contentPane = v;
			v.m_btnOK.on(Event.CLICK,this,onOKClick);
			v.m_btnNO.on(Event.CLICK,this,onNoClick);
			v.m_frame.getChild("closeButton").on(Event.CLICK,this,onNoClick);
		}
		public static function getInstance():Alert
		{
			if(ins==null){
				ins = new Alert();
			}
			return ins;
		}
		private function onOKClick():void
		{
			var txt:String = v.m_input.text;
			hide();
			var p:String = v.m_c1.selectedPage;
			if(p=="ok" || p=="okno"){
				if(okCall)okCall.call(theThis);
				if(noCall)noCall.call(theThis);
			}
			var tmpFun:Function = getInputCall;
			if(p=="input"){
				if(tmpFun)tmpFun(txt);
			}
			clear();
		}
		
		private function callEnd():void
		{
			if(okCall)okCall.call(theThis);
			if(noCall)noCall.call(theThis);
		}
		
		private function clear():void
		{
			getInputCall = null;
			okCall = null;
			noCall = null;
			v.m_input.text = "";
			v.m_txt.text = "";
		}
		private function onNoClick():void
		{
			hide();
			clear();
		}
		
		private function showMsg(str,okCall:Function=null,noCall:Function=null):void
		{
			this.noCall = noCall;
			this.okCall = okCall;
			if(okCall && noCall){
				v.m_c1.setSelectedPage("okno");	
			}
			if(okCall && !noCall){
				v.m_c1.setSelectedPage("ok");
			}
			if(!okCall && !noCall){
				v.m_c1.setSelectedPage("ok");
			}
			show();
			fadeIn(GRoot.inst.modalLayer);
			center();
			v.m_txt.text = str;
			v.m_title.text = "提示";
		}
		public static function fadeIn(g:GObject):void
		{
			var oldAlpha:Number = g.alpha;
			g.alpha = 0.01;
			Tween.to(g,{alpha:oldAlpha},200);
		}
		private function realGetInput(title:String,getInputCall:Function,defaultStr:String=""):void
		{
			v.m_c1.setSelectedPage("input");
			this.getInputCall = getInputCall;
			show();
			center();
			//v.m_input.tooltips = title;
			v.m_frame.title = title;
			v.m_input.text=defaultStr;
			Laya.stage.on(Event.KEY_DOWN,this,onKey);
		}
		override protected function onHide(): void {
			Laya.stage.off(Event.KEY_UP,this,onKey);
		}
		private function onKey(e:Event):void
		{
			if(e.nativeEvent.keyCode==Keyboard.ENTER){
				if(okWhenPressEnter){
					var t:String = v.m_input.text;
					var t2:String;
					if(t[t.length-1]=="\n"){
						t2 = t.substr(0,t.length-1);
					}else{
						t2 = t;
					}
					v.m_input.text = t2; 
					onOKClick();
				}
			}
		}
		
		public static function getInput(title:String,getInputCall:Function,defaultStr:String="",okWhenPressEnter:Boolean=true):void
		{
			Alert.okWhenPressEnter = okWhenPressEnter;
			getInstance().realGetInput(title,getInputCall,defaultStr);
		}
		
		public static function show(s,okCall:Function=null,noCall:Function=null,theThis:Object=null):void
		{
			Alert.theThis = theThis;
			if(s){
				getInstance().showMsg(s,okCall,noCall);
			}
		}
		public static function showTip(s,sec=3):void
		{
			GRoot.inst.showTooltips(s);
			Laya.timer.once(sec*1000,GRoot.inst,GRoot.inst.hideTooltips);
		}
		public static function showWait(msg:String="...网络不稳定，正在尝试重连..."):void
		{
			GRoot.inst.showModalWait(msg);
		}
		
		public static function hideWait():void
		{
			GRoot.inst.closeModalWait();
		}
		
	}
}