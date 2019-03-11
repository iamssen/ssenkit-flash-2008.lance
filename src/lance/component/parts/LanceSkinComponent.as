package lance.component.parts 
{
	import lance.component.events.SkinEvent;
	import lance.component.skin.LanceSkin;
	import lance.component.parts.LanceComponent;
	import lance.lance;
	use namespace lance;

	/** @copy lance.component.events.SkinEvent#CHANGE */
	[Event(name="change", type="lance.component.events.SkinEvent")]

	/** @copy lance.component.events.SkinEvent#MODE_CHANGE */
	[Event(name="modeChange", type="lance.component.events.SkinEvent")]

	/**
	 * Skin Component
	 * @author SSen
	 */
	public class LanceSkinComponent extends LanceComponent
	{
		protected var _skin : LanceSkin;
		protected var _skinMode : String;

		public function LanceSkinComponent(skin : LanceSkin, width : int = 0, height : int = 0)
		{
			super(width, height);
			_skin = skin;
		}
		/** skin */
		public function get skin() : LanceSkin
		{
			return _skin;
		}
		public function set skin(skin : LanceSkin) : void
		{
			_skin = skin;
			dispatchEvent(new SkinEvent(SkinEvent.CHANGE));
			skinning();
		}
		/** skin 의 className 을 가져온다 */
		public function get skinType() : String
		{
			return _skin.skinClassName;
		}
		/** skin 의 상태 */
		public function get skinMode() : String
		{
			return _skinMode;
		}
		/** skin 을 변경한다 */
		lance function skinning(modeName : String = null) : void
		{
			if (modeName != null) _skinMode = modeName;
			dispatchEvent(new SkinEvent(SkinEvent.MODE_CHANGE, _skinMode));
		}
	}
}
