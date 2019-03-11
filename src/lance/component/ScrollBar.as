package lance.component 
{
	import lance.component.skin.LanceSkin;	
	import lance.core.skinObject.SkinMode;	
	import lance.component.events.SkinEvent;	
	import lance.component.properties.DirectionMode;	
	import lance.component.parts.AbstButton;	

	import flash.events.MouseEvent;	

	import lance.component.parts.ScrollTrack;
	import lance.component.skin.ScrollBarSkin;	
	import lance.component.parts.IScrollContainer;
	import lance.component.parts.AbstScrollBar;
	import lance.lance;
	use namespace lance;

	/**
	 * moveUp, moveDown 이 구성되는 기본 ScrollBar
	 * @author SSen
	 */
	public class ScrollBar extends AbstScrollBar 
	{
		public function ScrollBar(skin : ScrollBarSkin, container : IScrollContainer, width : int = 0, height : int = 0, 
									direction : String = "vertical", 
									sec : Number = 0, moveSpeed : int = 10, trackMode : String = "point", minValue : Number = 0, maxValue : Number = 0)
		{
			super(skin, container, width, height, direction, sec, moveSpeed, trackMode, minValue, maxValue);
		}
		/** @private */
		override protected function create() : void
		{
			_moveUp = scrollBarSkin.button_moveUp(_direction);
			_moveDown = scrollBarSkin.button_moveDown(_direction);
			_trackBG = scrollBarSkin.scroll_track(_direction);
			if (_direction == DirectionMode.VERTICAL) {
				_track = new ScrollTrack(scrollBarSkin, _container, _width, _height - _moveUp.height - _moveDown.height, _direction, _sec, true, _trackMode, _minValue, _maxValue);
			} else {
				_track = new ScrollTrack(scrollBarSkin, _container, _width - _moveUp.width - _moveDown.width, _height, _direction, _sec, true, _trackMode, _minValue, _maxValue);
			}
			addChildren(_trackBG, _moveUp, _moveDown, _track);
			super.create();
		}
		/** @private */
		override protected function align() : void
		{
			if (_direction == DirectionMode.VERTICAL) {
				_moveUp.x = (_moveUp.rotation != 0) ? _moveUp.height : 0;
				_moveUp.y = 0;
				_track.height = _trackBG.height = _height - _moveUp.height - _moveDown.height;
				_trackBG.width = _width;
				trace("scrollBar vertical", _track.width, _track.height, _trackBG.width, _trackBG.height, _width, _height);
				_track.x = _trackBG.x = 0;
				_track.y = _trackBG.y = _moveUp.height;
				_trackBG.x = 0;
				_trackBG.y = _moveUp.height;
				_moveDown.x = (_moveDown.rotation != 0) ? _moveDown.height : 0;
				_moveDown.y = _track.y + _track.height;
			} else {
				_moveUp.x = 0;
				_moveUp.y = (_moveUp.rotation != 0) ? _moveUp.width : 0;
				_track.width = _trackBG.width = _width - _moveUp.width - _moveDown.width;
				_trackBG.height = _height;
				trace("scrollBar horizontal", _track.width, _track.height, _trackBG.width, _trackBG.height, _width, _height);
				_track.x = _trackBG.x = _moveUp.width;
				_track.y = 0;
				_moveDown.x = _track.x + _track.width;
				_moveDown.y = (_moveDown.rotation != 0) ? _moveDown.width : 0;
			}
		}
		/** @private */
		override public function set enabled(bool : Boolean) : void
		{
			_moveUp.enabled = bool;
			_moveDown.enabled = bool;
			super.enabled = bool;
		}
		/** @private */
		override public function set skin(skin : LanceSkin) : void
		{
			super.skin = skin;
			
			eventOff();
			
			var moveUp : AbstButton = scrollBarSkin.button_moveUp(_direction);
			var moveDown : AbstButton = scrollBarSkin.button_moveDown(_direction);
			addChildTo(moveUp, _moveUp);
			addChildTo(moveDown, _moveDown);
			_moveUp = moveUp;
			_moveDown = moveDown;
			_track.skin = scrollBarSkin;
			
			if (!enabled) {
				_moveUp.enabled = false;
				_moveDown.enabled = false;
			}
			
			eventOn();
		}
		/** @private */
		override lance function eventOn() : void
		{
			super.eventOn();
			_moveUp.addEventListener(MouseEvent.MOUSE_DOWN, moveDown, false, 0, true);
			_moveDown.addEventListener(MouseEvent.MOUSE_DOWN, moveDown, false, 0, true);
			_track.addEventListener(SkinEvent.MODE_CHANGE, trackChange, false, 0, true);
		}
		private function trackChange(event : SkinEvent) : void
		{
			_trackBG.skinning(event.mode);
			dispatchEvent(new SkinEvent(SkinEvent.CHANGE, event.mode));
		}
		/** @private */
		override lance function eventOff() : void
		{
			super.eventOff();
			_moveUp.removeEventListener(MouseEvent.MOUSE_DOWN, moveDown);
			_moveDown.removeEventListener(MouseEvent.MOUSE_DOWN, moveDown);
			_track.removeEventListener(SkinEvent.MODE_CHANGE, trackChange);
		}
		/** @private */
		override protected function moveDown(event : MouseEvent) : void
		{
			_trackBG.skinning(SkinMode.ACTION);
			super.moveDown(event);
		}
		/** @private */
		override protected function moveUp(event : MouseEvent) : void
		{
			_trackBG.skinning(SkinMode.DEFAULT);
			super.moveUp(event);
		}
	}
}
