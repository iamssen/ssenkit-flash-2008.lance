package lance.component.events 
{
	import flash.events.Event;
	/**
	 * @author SSen
	 */
	public class SkinEvent extends Event 
	{
		/** 스킨 오브젝트의 skin mode 가 교체될때 */
		public static const MODE_CHANGE : String = "modeChange";
		/** 스킨 자체가 교체될때 */
		public static const CHANGE : String = "change"; 
		private var _mode : String;

		public function SkinEvent(type : String, mode : String = "default", bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_mode = mode;
		}
		/** skin 의 모드 */
		public function get mode() : String
		{
			return _mode;
		}
		public override function toString() : String
		{
			return '[SkinEvent type="' + type + '" mode="' + _mode + '"]';
		} 
	}
}
