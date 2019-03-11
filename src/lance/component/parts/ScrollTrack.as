package lance.component.parts 
{
	import fl.motion.easing.Quadratic;
	
	import gs.TweenLite;
	
	import lance.component.events.ScrollEvent;
	import lance.component.parts.LanceSkinComponent;
	import lance.component.properties.DirectionMode;
	import lance.component.properties.TrackMode;
	import lance.component.properties.ValueType;
	import lance.component.skin.LanceSkin;
	import lance.component.skin.ScrollTrackSkin;
	import lance.core.events.LanceEvent;
	import lance.core.graphics.FavoriteDisplayObject;
	import lance.core.skinObject.ISkinObject;
	import lance.core.skinObject.SkinGridSprite;
	import lance.core.skinObject.SkinMode;
	import lance.lance;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;		
	
	use namespace lance;	

	/** @copy lance.component.events.ScrollEvent#SCROLL */
	[Event(name="scroll", type="lance.component.events.ScrollEvent")]

	/** @copy lance.component.events.ScrollEvent#THUMB_SHOW */
	[Event(name="thumbShow", type="lance.component.events.ScrollEvent")]

	/** @copy lance.component.events.ScrollEvent#THUMB_HIDE */
	[Event(name="thumbHide", type="lance.component.events.ScrollEvent")]

	/**
	 * ScrollTrack Object
	 * @author SSen
	 */
	public class ScrollTrack extends LanceInputComponent implements IScroller
	{
		// track 이 숨겨질 것인지를 체크
		private var _isTrackHide : Boolean;
		// 현재 위치의 0~1 값 
		private var _sec : Number = 0;
		private var _thumb : SkinGridSprite;
		// 스크롤의 조작영역
		private var _container : IScrollContainer;
		// 배경
		private var _track : Sprite;
		// skin 이 disable 상태인지 확인
		private var _isSkinDisabled : Boolean = false;
		// thumb 을 누르는 순간의 Stage 의 MouseY 위치
		private var _downStageMouseXY : Number;
		// thumb 를 누르는 순간의 thumb 의 y 위치 
		private var _downThumbXY : Number;
		// thumb 이 내려가서는 안되는 x, y 위치
		private var _thumbMaxXY : Number;
		// 방향을 설정한다
		private var _direction : String;
		private var _trackMode : String;
		// skin file
		private var _thumbSkinMode : String;
		private var _trackSkinMode : String;
		// value
		private var _minValue : Number;
		private var _maxValue : Number;

		public function ScrollTrack(skin : ScrollTrackSkin, container : IScrollContainer, width : int = 0, height : int = 0,
									direction : String = "vertical",
									sec : Number = 0,
									isTrackHide : Boolean = false,
									trackMode : String = "point",
									minValue : Number = 0,
									maxValue : Number = 0
									)
		{
			super(skin, width, height, ValueType.NUMBER);
			
			_container = container;
			_direction = direction;
			_sec = sec;
			_isTrackHide = isTrackHide;
			_trackMode = trackMode;
			
			_thumbSkinMode = SkinMode.DEFAULT;
			_trackSkinMode = SkinMode.DEFAULT;
			
			_minValue = minValue;
			_maxValue = maxValue;
			
			init();
		}
		private function init() : void
		{
			_thumb = scrollTrackSkin.scroll_thumb(_direction);
			if (!scrollTrackSkin.trackSkin) _isTrackHide = true;
			_track = (_isTrackHide) ? FavoriteDisplayObject.BLANK_SPRITE() : scrollTrackSkin.scroll_track(_direction);
			_thumb.width = _width;
			_thumb.height = _height;
			_track.width = _width;
			_track.height = _height;
			
			addChild(_track);
			addChild(_thumb);
			
			thumbSize(thumbWH);
			eventOn();
			
			if (_minValue == 0 && _maxValue == 0) {
				_minValue = 0;
				_maxValue = _thumbMaxXY; 
			} 
		}
		private function get scrollTrackSkin() : ScrollTrackSkin
		{
			return _skin as ScrollTrackSkin;
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		public override function set skin(skin : LanceSkin) : void
		{
			eventOff();
			
			var scrllTrackSkin : ScrollTrackSkin = ScrollTrackSkin(skin);
			var thumb : SkinGridSprite = scrllTrackSkin.scroll_thumb(_direction);
			if (!scrllTrackSkin.trackSkin) _isTrackHide = true;
			var track : Sprite = (_isTrackHide) ? FavoriteDisplayObject.BLANK_SPRITE() : scrllTrackSkin.scroll_track(_direction);
			
			addChildTo(thumb, _thumb);
			addChildTo(track, _track);
			
			_thumb = thumb;
			_track = track;
			
			eventOn();
			
			super.skin = skin;
		}
		/** @copy lance.component.parts.IScroller#container */
		public function get container() : IScrollContainer
		{
			return _container;
		}
		public function set container(container : IScrollContainer) : void
		{
			_container = container;
			thumbSize(thumbWH);
			thumbPos(thumbXY);
		}
		/** @copy lance.component.parts.ISlider#minValue */
		public function get minValue() : Number
		{
			return _minValue;
		}
		public function set minValue(minValue : Number) : void
		{
			_minValue = minValue;
		}
		/** @copy lance.component.parts.ISlider#maxValue */
		public function get maxValue() : Number
		{
			return _maxValue;
		}
		public function set maxValue(maxValue : Number) : void
		{
			_maxValue = maxValue;
		}
		/** @copy lance.component.parts.IInput#value */
		override public function get value() : Object
		{
			return ((_maxValue - _minValue) * _sec) + _minValue;
		}
		override public function set value(value : Object) : void
		{
			var v : Number;
			if (value is Number) {
				v = Number(value);
			} else {
				throw new Error("숫자형만 입력되어야 합니다.");
			}
			if (v > _maxValue) {
				v = _maxValue;
			} else if (v < _minValue) {
				v = _minValue;
			}
			
			sec = (v - _minValue) / (_maxValue - _minValue);
			super.value = v;
		}
		/** @copy lance.component.parts.IScroller#sight */
		public function get sight() : Number
		{
			return (_direction == DirectionMode.VERTICAL) ? _thumb.height / _track.height : _thumb.width / _track.width;
		}
		/** @copy lance.component.parts.ISlider#sec */
		public function get sec() : Number
		{
			return _sec;
		}
		public function set sec(sec : Number) : void
		{
			_sec = sec;
			thumbPos(thumbXY);
			dispatchScroll();
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			_track.width = value;
			var w : Number = (_direction != DirectionMode.VERTICAL) ? thumbWH : value;
			if (_thumb.visible) { 
				_thumb.width = w; 
			}
			thumbPos(thumbXY);
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			_track.height = value;
			var h : Number = (_direction == DirectionMode.VERTICAL) ? thumbWH : value;
			if (_thumb.visible) {
				_thumb.height = h; 
			}
			thumbPos(thumbXY);
		}
		/** @copy lance.component.parts.ISlider#wheel() */
		public function wheel(delta : int) : void
		{
			if (delta == 0) return;
			
			if(_thumb.visible) {
				delta <<= 1;
				var xy : Number = (_direction == DirectionMode.VERTICAL) ? _thumb.y - delta : _thumb.x - delta;
				_thumb.y = xyFix(xy);
				dispatchScroll();
			}
		}
		/** @copy lance.component.parts.IScroller#page() */
		public function page(delta : int) : void
		{
			if (delta == 0) return;
			
			trackStart();
			this.stage.mouseChildren = false;
			var speed : Number = 0.2;
			var page : int = (delta > 0) ? delta : delta * -1;
			
			if (_direction == DirectionMode.VERTICAL) {
				var oy : Number;
				if (delta < 0) {
					oy = _thumb.y - (_thumb.height * page) + (_thumb.height >> 3);
				} else {
					oy = _thumb.y + (_thumb.height * page) - (_thumb.height >> 3);
				}
				TweenLite.to(_thumb, speed, {y:oy, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			} else {
				var ox : Number;
				if (delta < 0) {
					ox = _thumb.x - (_thumb.width * page) + (_thumb.width >> 3);
				} else if (mouseX > _thumb.x + _thumb.width) {
					ox = _thumb.x + (_thumb.width * page) - (_thumb.width >> 3);
				}
				TweenLite.to(_thumb, speed, {x:ox, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			}
		}
		/** @copy lance.component.parts.ISlider#move() */
		public function move(pixel : int) : void
		{
			if (pixel == 0) return;
			
			if (_direction == DirectionMode.VERTICAL) {
				_container.contentY += pixel;
			} else {
				_container.contentX += pixel;
			}
		}
		/** @private */
		override public function set enabled(bool : Boolean) : void
		{
			super.enabled = bool;
			if (bool && isTallContenThanContainer) {
				_isSkinDisabled = false;
				thumbOut();
				trackComplete();
			} else {
				_isSkinDisabled = true;
				disableTrack();
			}
		}
		/** @private */
		override public function kill() : void
		{
			eventOff();
			_thumb = null;
			_track = null;
			super.kill();
		}
		/* *********************************************************************
		 * Protected Properties and Methods 
		 ********************************************************************* */
		private function eventOnControl() : void
		{
			_thumb.addEventListener(MouseEvent.MOUSE_OVER, thumbMouseOver, false, 0, true);
			_thumb.addEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut, false, 0, true);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbMouseDown, false, 0, true);
			_track.addEventListener(MouseEvent.CLICK, trackClick, false, 0, true);
		}
		private function eventOffControl() : void
		{
			_thumb.removeEventListener(MouseEvent.MOUSE_OVER, thumbMouseOver);
			_thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut);
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbMouseDown);
			_track.removeEventListener(MouseEvent.CLICK, trackClick);
		}
		/** @private */
		override lance function eventOn() : void
		{
			super.eventOn();
			eventOnControl();
			_container.addEventListener(LanceEvent.RESIZE, containerRefresh, false, 0, true);
			_container.addEventListener(LanceEvent.ENABLE, containerEnabled, false, 0, true);
			_container.addEventListener(LanceEvent.DISABLE, containerDisabled, false, 0, true);
			_container.addEventListener(ScrollEvent.CONTENT_CHANGE, containerRefresh, false, 0, true);
			_container.addEventListener(ScrollEvent.CONTENT_DELETED, containerRefresh, false, 0, true);
			_container.addEventListener(ScrollEvent.SCROLL, containerScroll, false, 0, true);
		}
		/** @private */
		override lance function eventOff() : void
		{
			super.eventOff();
			eventOffControl();
			_container.removeEventListener(LanceEvent.RESIZE, containerRefresh);
			_container.removeEventListener(LanceEvent.ENABLE, containerEnabled);
			_container.removeEventListener(LanceEvent.DISABLE, containerDisabled);
			_container.removeEventListener(ScrollEvent.CONTENT_CHANGE, containerRefresh);
			_container.removeEventListener(ScrollEvent.CONTENT_DELETED, containerRefresh);
			_container.removeEventListener(ScrollEvent.SCROLL, containerScroll);
		}
		/* *********************************************************************
		 * Private Event Handlers
		 ********************************************************************* */
		// container 가 스크롤될때
		private function containerScroll(event : ScrollEvent) : void
		{
			sec = (_direction == DirectionMode.VERTICAL) ? event.secY : event.secX;
		}
		// 컨테이너가 비활성 될때
		private function containerDisabled(event : LanceEvent) : void
		{
			enabled = false;
		}
		// 컨테이너가 활성 될때
		private function containerEnabled(event : LanceEvent) : void
		{
			enabled = true;
		}
		// 컨테이너가 모양적으로 변화가 있을때
		private function containerRefresh(event : Event) : void
		{
			thumbSize(thumbWH);
			thumbPos(thumbXY);
		}
		// mouse down event handler
		private function thumbMouseDown(event : MouseEvent) : void
		{
			if (_direction == DirectionMode.VERTICAL) {
				_downStageMouseXY = this.stage.mouseY;
				_downThumbXY = this._thumb.y;
			} else {
				_downStageMouseXY = this.stage.mouseX;
				_downThumbXY = this._thumb.x;
			}
			
			thumbDown();
			
			_thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut);
			
			this.stage.mouseChildren = false;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
		}
		// mouse out event handler
		private function thumbMouseOut(event : MouseEvent) : void
		{
			thumbOut();
		}
		// mouse over event handler
		private function thumbMouseOver(event : MouseEvent) : void
		{
			thumbOver();
		}
		// stage 의 mouse down event handler
		private function mouseUp(event : MouseEvent) : void
		{
			thumbUp();
			
			_thumb.addEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut, false, 0, true);
			
			this.stage.mouseChildren = true;
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		// stage 의 mouse move event handler
		private function mouseMove(event : MouseEvent) : void
		{
			var xy : Number = (_direction == DirectionMode.VERTICAL) ? _downThumbXY - (_downStageMouseXY - stage.mouseY) : _downThumbXY - (_downStageMouseXY - stage.mouseX);
			thumbPos(xyFix(xy));
			dispatchScroll();
		}
		// track 을 클릭했을때 움직임
		private function trackClick(event : MouseEvent) : void
		{
			trackStart();
			this.stage.mouseChildren = false;
			
			var speed : Number;
			
			if (_direction == DirectionMode.VERTICAL) {
				var oy : Number;
				switch (_trackMode) {
					case TrackMode.POINT :
						speed = 0.4; 
						oy = mouseY - (_thumb.height >> 1);
						break;
					case TrackMode.PAGE :
						speed = 0.2;
						if (mouseY < _thumb.y) {
							oy = _thumb.y - _thumb.height + (_thumb.height >> 3);
						} else if (mouseY > _thumb.y + _thumb.height) {
							oy = _thumb.y + _thumb.height - (_thumb.height >> 3);
						}
				}
				TweenLite.to(_thumb, speed, {y:oy, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			} else {
				var ox : Number;
				switch (_trackMode) {
					case TrackMode.POINT :
						speed = 0.4; 
						ox = mouseX - (_thumb.width >> 1);
						break;
					case TrackMode.PAGE :
						speed = 0.2;
						if (mouseX < _thumb.x) {
							ox = _thumb.x - _thumb.width + (_thumb.width >> 3);
						} else if (mouseX > _thumb.x + _thumb.width) {
							ox = _thumb.x + _thumb.width - (_thumb.width >> 3);
						}
				}
				TweenLite.to(_thumb, speed, {x:ox, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			}
		}
		// easing update
		private function trackClickUpdate() : void
		{
			var xy : Number = (_direction == DirectionMode.VERTICAL) ? _thumb.y : _thumb.x;
			thumbPos(xyFix(xy));
			dispatchScroll();
		}
		// easing complete
		private function trackClickComplete() : void
		{
			trackComplete();
			
			this.stage.mouseChildren = true;
			dispatchScroll();
		}
		/* *********************************************************************
		 * Skinning Methods
		 ********************************************************************* */
		// thumb 의 MouseOut 시점에 호출됨
		private function thumbOut() : void
		{
			_thumbSkinMode = SkinMode.DEFAULT;
			skinning();
		}
		// thumb 의 MouseOver 시점에 호출됨
		private function thumbOver() : void
		{
			_thumbSkinMode = SkinMode.OVER;
			skinning();
		}
		// thumb 의 MouseDown 시점에 호출됨
		private function thumbDown() : void
		{
			_thumbSkinMode = SkinMode.ACTION;
			_trackSkinMode = SkinMode.ACTION;
			skinning();
		}
		// thumb 의 MouseUp 시점에 호출됨
		private function thumbUp() : void
		{
			_thumbSkinMode = SkinMode.DEFAULT;
			_trackSkinMode = SkinMode.DEFAULT;
			skinning();
		}
		// track 의 EasingStart 시점에 호출됨
		private function trackStart() : void
		{
			_trackSkinMode = SkinMode.ACTION;
			skinning();
		}
		// track 의 EasingComplete 시점에 호출됨
		private function trackComplete() : void
		{
			_trackSkinMode = SkinMode.DEFAULT;
			skinning();
		}
		// disable 시의 스키닝
		private function disableTrack() : void
		{	
			_thumbSkinMode = SkinMode.DISABLE;
			_trackSkinMode = SkinMode.DISABLE;
			skinning();
		}
		// 스킨을 입힌다
		override lance function skinning(modeName : String = null) : void
		{
			if (modeName == SkinMode.DISABLE) {
				_thumbSkinMode = SkinMode.DISABLE;
				_trackSkinMode = SkinMode.DISABLE;
			} else if (modeName != null) {
				_trackSkinMode = modeName;
			}
			
			var thumbMode : String = (_isSkinDisabled) ? SkinMode.DISABLE : _thumbSkinMode;
			var trackMode : String = (_isSkinDisabled) ? SkinMode.DISABLE : _trackSkinMode;
			_thumb.skinning(thumbMode);
			if (!_isTrackHide) ISkinObject(_track).skinning(trackMode);
			
			super.skinning(_trackSkinMode);
		}
		/* *********************************************************************
		 * Private Util functions
		 ********************************************************************* */
		// thumb 의 높이를 계산해서 반환한다
		private function get thumbWH() : Number
		{
			var showHide : Boolean = showHideThumb();
			var wh : int;
			if (showHide) { 
				if (_direction == DirectionMode.VERTICAL) {
					wh = (_container.containerHeight / _container.contentHeight) * _height;
					wh = (wh < 5) ? 5 : wh;
					_thumbMaxXY = _height - wh;
				} else {
					wh = (_container.containerWidth / _container.contentWidth) * _width;
					wh = (wh < 5) ? 5 : wh;
					_thumbMaxXY = _width - wh;
				}
			} else {
				wh = 0;
			}
			return wh;
		}
		// thumb 의 y 위치를 계산해서 반환한다
		private function get thumbXY() : Number
		{
			return (_direction == DirectionMode.VERTICAL) ? (_track.height - _thumb.height) * _sec : (_track.width - _thumb.width) * _sec;
		}
		// thumb 의 y 위치를 기준으로 sec 를 계산해서 가져온다
		private function getSec() : Number
		{
			var sec : Number = (_direction == DirectionMode.VERTICAL) ? _thumb.y / (_track.height - _thumb.height) : _thumb.x / (_track.width - _thumb.width);
			if (sec <= 0) {
				sec = 0; 
			} else if (sec >= 1) {
				sec = 1;
			}
			return sec;
		}
		// thumb 의 show, hide 처리를 하고, dispatch 시킨다.
		private function showHideThumb() : Boolean
		{
			var bool : Boolean;
			if (isTallContenThanContainer && _container.content != null) {
				if (!_thumb.visible) { 
					dispatchEvent(new ScrollEvent(ScrollEvent.THUMB_SHOW)); 
				}
				_thumb.visible = true;
				eventOnControl();
				if (enabled) {
					_isSkinDisabled = false;
					thumbOut();
					trackComplete();
				} else {
					disableTrack();
				}
				bool = true;
			} else {
				if (_thumb.visible) { 
					dispatchEvent(new ScrollEvent(ScrollEvent.THUMB_HIDE)); 
				}
				_thumb.visible = false;
				eventOffControl();
				disableTrack();
				_isSkinDisabled = true;
				bool = false;
			}
			return bool;
		}
		// container 보다 content 가 더 큰지... 스크롤이 필요없는지 확인한다.
		private function get isTallContenThanContainer() : Boolean
		{
			var bool : Boolean;
			if (_direction == DirectionMode.VERTICAL) {
				bool = _container.containerHeight < _container.contentHeight;
			} else {
				bool = _container.containerWidth < _container.contentWidth;
			}
			return bool;
		}
		// y 위치를 설정값 내부에서 고정시킨다
		private function xyFix(n : Number) : Number
		{
			if (n <= 0) {
				n = 0;
			} else if (n >= _thumbMaxXY) {
				n = _thumbMaxXY;
			}
			return n;
		}
		// sec 를 저장하고, ScrollEvent 를 dispatch 시킨다
		private function dispatchScroll() : void
		{
			var sec : Number = getSec();
			if (_direction == DirectionMode.VERTICAL) {
				_container.secY = sec;
				dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, 0, sec));
			} else {
				_container.secX = sec;
				dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, sec));
			}
			 
			_sec = sec;
		}
		// thumb 의 width or height 
		private function thumbSize(value : Number) : void
		{
			if (value > 0) {
				if (_direction == DirectionMode.VERTICAL) {
					_thumb.height = value;
				} else {
					_thumb.width = value;
				}
			}
		}
		// thumb 의 x or y
		private function thumbPos(value : Number) : void
		{
			if (_direction == DirectionMode.VERTICAL) {
				_thumb.y = value;
			} else {
				_thumb.x = value;
			}
		}
	}
}
