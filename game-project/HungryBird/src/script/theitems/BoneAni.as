package script.theitems
{
	import laya.ani.bone.Skeleton;
	import laya.ani.bone.Templet;
	import laya.display.Sprite;
	import laya.events.Event;

	public class BoneAni extends Sprite
	{
		private var mAniPath:String;
		private var mFactory:Templet;
		private var mActionIndex:int = 0;
        public var playIndex:int = 0;
		public var mArmature:Skeleton;
		private var mCurrSkinIndex:int = 0;
		private var scaleNum:Number;

		private var endFun:Function;

		private var loop:Boolean;

		public function BoneAni(mAniPath:String,loop:Boolean=false,endFun:Function=null,scaleNum:Number=1)
		{
			this.loop = loop;
			this.endFun = endFun;
			this.scaleNum = scaleNum;
			this.mAniPath = mAniPath;
			mFactory = new Templet();
			mFactory.on(Event.COMPLETE, this, parseComplete);
			mFactory.on(Event.ERROR, this, onError);
			mFactory.loadAni(mAniPath);
		}
		private function onError(e:*):void
		{
			trace("error"+e);
		}
		
		private function parseComplete(fac:Templet):void {
			//创建模式为1，可以启用换装
			mArmature = mFactory.buildArmature(0);
			mArmature.scale(scaleNum, scaleNum);
			addChild(mArmature);
			mArmature.on(Event.STOPPED, this, completeHandler);
			play();
		}
		
		private function completeHandler():void
		{
			if(endFun)endFun();
		}
		public function play():void
		{
			mArmature.play(playIndex,loop);
		}
		public function nextPlay():void
		{
			playIndex++;
			if (playIndex >= mArmature.getAnimNum())
			{
				playIndex = 0;
			}
			mArmature.play(playIndex,loop);
		}
		public function stop():void
		{
			mArmature.stop();
		}
	}
}