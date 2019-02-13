package he.ai
{
	import laya.events.EventDispatcher;

	/**
	 * 消息分发中心，AGI 通过这这里向外部发送消息，通知界面程序更新视图。 
	 */
	public class EventCenter extends EventDispatcher
	{
		public function EventCenter()
		{
		}
		private static var _instance:EventCenter;

		public static function get inst():EventCenter
		{
			if(_instance==null){
				_instance = new EventCenter;
			}
			return _instance;
		}
	}
}