package {
	import laya.net.AtlasInfoManager;
	import laya.net.URL;
	import laya.utils.Handler;
	import laya.utils.Stat;
	import laya.utils.Utils;
	import script.Game2D;
	import laya.utils.Browser;
	
	public class Main {
		public function Main() {
			//根据IDE设置初始化引擎
			trace(laya.utils.Browser.clientWidth);
			trace(laya.utils.Browser.width);
			trace(laya.utils.Browser.pixelRatio);
			if(!laya.utils.Browser.onMobile){
				GameConfig.width = laya.utils.Browser.width;
				GameConfig.height = laya.utils.Browser.height;
			}
			if (window["Laya3D"]) window["Laya3D"].init(GameConfig.width, GameConfig.height);
			else Laya.init(GameConfig.width, GameConfig.height, Laya["WebGL"]);
			Laya["Physics"] && Laya["Physics"].enable();
			Laya["DebugPanel"] && Laya["DebugPanel"].enable();
			if(!laya.utils.Browser.onMobile){
				Laya.stage.scaleMode = GameConfig.scaleMode;
				Laya.stage.screenMode = GameConfig.screenMode;
			}else{
				Laya.stage.scaleMode = "fixedauto";
				Laya.stage.screenMode = GameConfig.screenMode;
			}
			Laya.stage.alignV = GameConfig.alignV;
			Laya.stage.alignH = GameConfig.alignH;
			Laya.stage.bgColor = "#666666";
			//兼容微信不支持加载scene后缀场景
			URL.exportSceneToJson = GameConfig.exportSceneToJson;
			
			//打开调试面板（IDE设置调试模式，或者url地址增加debug=true参数，均可打开调试面板）
			if (GameConfig.debug || Utils.getQueryString("debug") == "true") Laya.enableDebugPanel();
			if (GameConfig.physicsDebug && Laya["PhysicsDebugDraw"]) Laya["PhysicsDebugDraw"].enable();
			if (GameConfig.stat) Stat.show();
			Laya.alertGlobalError = true;
			
			//激活资源版本控制，版本文件由发布功能生成
			//ResourceVersion.enable("version.json", Handler.create(this, this.onVersionLoaded), ResourceVersion.FILENAME_VERSION);

			//暂时不需要上面的版本管理系统，直接执行 onConfigLoaded()
			onConfigLoaded();
		}
		
		private function onVersionLoaded():void {
			//激活大小图映射，加载小图的时候，如果发现小图在大图合集里面，则优先加载大图合集，而不是小图
			AtlasInfoManager.enable("fileconfig.json", Handler.create(this, this.onConfigLoaded));
		}
		
		private function onConfigLoaded():void {
			//加载场景
			new Game2D();
		}
	}
}