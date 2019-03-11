package lance.component.parts 
{
	import lance.core.skinObject.SkinMode;	
	import lance.core.skinObject.ISkinObject;	

	import flash.display.Graphics;	

	import lance.component.events.ScrollEvent;	

	import flash.display.Shape;	
	import flash.display.DisplayObject;	

	import lance.component.parts.LanceComponent;

	/** @copy lance.component.events.ScrollEvent#MASK_ON */
	[Event(name="maskOn", type="lance.component.events.ScrollEvent")]

	/** @copy lance.component.events.ScrollEvent#MASK_OFF */
	[Event(name="maskOff", type="lance.component.events.ScrollEvent")]

	/** @copy lance.component.events.ScrollEvent#CONTENT_CHANGE */
	[Event(name="contentChange", type="lance.component.events.ScrollEvent")]

	/** @copy lance.component.events.ScrollEvent#CONTENT_DELETED */
	[Event(name="contentDeleted", type="lance.component.events.ScrollEvent")]

	/** @copy lance.component.events.ScrollEvent#SCROLL */
	[Event(name="scroll", type="lance.component.events.ScrollEvent")]
	/**
	 * Description
	 * @author SSen
	 */
	public class ScrollContainer extends LanceComponent implements ISkinObject, IScrollContainer
	{
		// secX 의 저장소
		private var _secX : Number = 0;
		// secY 의 저장소
		private var _secY : Number = 0;
		/** content 의 저장소 */
		protected var _content : DisplayObject;
		/** mask object 의 저장소 */
		protected var _mask : Shape;
		/** maskOn 의 저장소 */
		protected var _maskOn : Boolean;
		private var _skinMode : String;

		public function ScrollContainer(content : DisplayObject = null, width : Number = 300, height : Number = 300, maskOn : Boolean = true, secX : Number = 0, secY : Number = 0, skinMode : String = "default")
		{
			_width = width;
			_height = height;
			_secX = secX;
			_secY = secY;
			_content = content;
			_maskOn = maskOn;
			
			_skinMode = skinMode;
			
			init();
		}
		public function skinning(modeName : String = "default") : void
		{
			_skinMode = (modeName == SkinMode.DISABLE) ? SkinMode.DISABLE : SkinMode.DEFAULT;
			// 필터적용을 한다
		}
		public function get flag() : String
		{
			return _skinMode;
		}
		public function get skinList() : Array
		{
			return [SkinMode.DEFAULT, SkinMode.DISABLE];
		}
		private function init() : void
		{
			if (_content != null) { 
				addChild(_content); 
			}
			secX = _secX;
			secY = _secY;
			maskOn = _maskOn;
		}
		/* *********************************************************************
		 * Interface Properties and Methods :: positioning
		 ********************************************************************* */
		/** 현재 X위치의 0~1 값 */
		public function get secX() : Number
		{
			return _secX;
		}
		public function set secX(sec : Number) : void
		{
			_secX = sec;
			if (_content != null) {
				_content.x = secToX(sec);
			}
		}
		/** 현재 Y위치의 0~1 값 */
		public function get secY() : Number
		{
			return _secY;
		}
		public function set secY(sec : Number) : void
		{
			_secY = sec;
			if (_content != null) {
				_content.y = secToY(sec);
			}
		}
		/** content 의 x 위치 */
		public function get contentX() : Number
		{
			return _content.x;
		}
		public function set contentX(value : Number) : void
		{
			if (_content != null) {
				var xMin : Number = _width - _content.width;
				if (value > 0) {
					_content.x = 0;
				} else if (value < xMin) {
					_content.x = xMin;
				} else {
					_content.x = value;
				}
				_secX = _content.x / (_width - content.width);
				dispatchScroll();
			} else {
				trace("SSEN//", this, "container 에 content 가 null 이라 무효화됨");
			}
		}
		/** content 의 y 위치 */
		public function get contentY() : Number
		{
			return _content.y;
		}
		public function set contentY(value : Number) : void
		{
			if (_content != null) {
				var yMin : Number = _height - _content.height;
				if (value > 0) {
					_content.y = 0;
				} else if (value < yMin) {
					_content.y = yMin;
				} else {
					_content.y = value;
				}
				_secY = _content.y / (_height - content.height);
				dispatchScroll();
			} else {
				trace(this, "container 에 content 가 null 이라 무효화됨");
			}
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		override public function kill() : void
		{
			_content = null;
			_mask = null;
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			if (_content != null) {
				maskSize(value, _height);
				alignContent();
			}
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			if (_content != null) {
				maskSize(_width, value);
				alignContent();
			}
		}
		/** mask 의 활성, 비활성 여부 */
		public function get maskOn() : Boolean
		{
			return _maskOn;
		}
		public function set maskOn(bool : Boolean) : void
		{
			_maskOn = bool;
			if (_content != null) {
				if (bool) {
					addMask();
					dispatchEvent(new ScrollEvent(ScrollEvent.MASK_ON));
				} else {
					removeMask();
					dispatchEvent(new ScrollEvent(ScrollEvent.MASK_OFF));
				}
			}
		}
		/** container 의 width */
		public function get containerWidth() : Number
		{
			return _width;
		}
		/** container 의 height */
		public function get containerHeight() : Number
		{
			return _height;
		}
		/** content 의 width */
		public function get contentWidth() : Number
		{
			return (_content != null) ? _content.width : 0;
		}
		/** content 의 height */
		public function get contentHeight() : Number
		{
			return (_content != null) ? _content.height : 0;
		}
		/** 내용이 되는 display object */
		public function get content() : DisplayObject
		{
			return _content;
		}
		public function set content(content : DisplayObject) : void
		{
			removeContent();
			_content = content;
			addChild(_content);
			refresh();
			_content = content; 
		}
		/** content 를 삭제한다 */
		public function deleteContent() : void
		{
			removeContent();
			dispatchEvent(new ScrollEvent(ScrollEvent.CONTENT_DELETED));
		}
		/** content 의 size 가 변경되거나 할 경우 호출해서, 사이즈를 재정렬 시켜준다 */
		public function refresh() : void
		{
			alignContent();
			if (_maskOn) {
				addMask();
			}
			dispatchEvent(new ScrollEvent(ScrollEvent.CONTENT_CHANGE));
		}
		/* *********************************************************************
		 * Private Util functions
		 ********************************************************************* */
		// content 를 재정렬 시킨다.
		private function alignContent() : void
		{
			_content.x = secToX(_secX);
			_content.y = secToY(_secY);
		}
		// content 를 삭제한다.
		private function removeContent() : void
		{
			if (_content != null) {
				if (contains(_content)) {
					removeChild(_content);
				}
				_content = null;
			}
		}
		// mask 의 사이즈를 조절한다.
		private function maskSize(width : Number, height : Number) : void
		{
			if (_maskOn && _mask != null) {
				_mask.width = width;
				_mask.height = height;
			}
		}
		// mask 를 활성화 시킨다.
		private function addMask() : void
		{
			removeMask();
			if (_maskOn) {
				_mask = new Shape();
				var g : Graphics = _mask.graphics;
				g.beginFill(0xeeeeee);
				g.drawRect(0, 0, _width, _height);
				g.endFill();
				addChild(_mask);
				_content.mask = _mask;
			}
		}
		// mask 를 비활성 시킨다.
		private function removeMask() : void
		{
			if (_mask != null) {
				_content.mask = null;
				if (contains(_mask)) {
					removeChild(_mask);
				}
				_mask = null;
			}
		}
		// sec 를 저장하고, ScrollEvent 를 dispatch 시킨다
		private function dispatchScroll() : void
		{
			this.dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, _secX, _secY));
		}
		// sec 를 x 위치로 바꿔서 반환
		private function secToX(sec : Number) : Number
		{
			return sec * (_width - _content.width);
		}
		// sec 를 y 위치로바꿔서 반환
		private function secToY(sec : Number) : Number
		{
			return sec * (_height - _content.height);
		}
	}
}
