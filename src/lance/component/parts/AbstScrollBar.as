package lance.component.parts 
{
	import lance.component.properties.ValueType;	
	import lance.core.skinObject.ISkinObject;	

	import flash.utils.Timer;	
	import flash.events.TimerEvent;	
	import flash.events.MouseEvent;	

	import lance.component.skin.ScrollBarSkin;	
	import lance.component.events.ScrollEvent;
	import lance.component.parts.LanceSkinComponent;
	import lance.component.parts.IScroller;
	import lance.lance;
	use namespace lance;

	/** @copy lance.component.events.ScrollEvent#SCROLL */
	[Event(name="scroll", type="lance.component.events.ScrollEvent")]

	/**
	 * 스크롤바의 원시구현
	 * @author SSen
	 */
	public class AbstScrollBar extends LanceInputComponent implements IScroller
	{
		protected var _moveUp : AbstButton;
		protected var _moveDown : AbstButton;
		protected var _move : AbstButton;
		protected var _up : Boolean;
		protected var _timer : Timer;
		protected var _track : ScrollTrack;
		protected var _container : IScrollContainer;
		protected var _direction : String;
		protected var _sec : Number;
		protected var _moveSpeed : int;
		protected var _trackBG : ISkinObject;
		protected var _trackMode : String;
		protected var _minValue : Number;
		protected var _maxValue : Number;

		public function AbstScrollBar(skin : ScrollBarSkin, container : IScrollContainer, width : int = 0, height : int = 0, 
										direction : String = "vertical", 
										sec : Number = 0, moveSpeed : int = 10, trackMode : String = "point", minValue : Number = 0, maxValue : Number = 0)
		{
			super(skin, width, height, ValueType.NUMBER);
			
			_container = container;
			_direction = direction;
			_sec = sec;
			_moveSpeed = moveSpeed;
			_trackMode = trackMode;
			_minValue = minValue;
			_maxValue = maxValue;
			
			create();
		}
		/** _skin 을 ScrollBarSkin 으로 형변환 */
		protected function get scrollBarSkin() : ScrollBarSkin
		{
			return _skin as ScrollBarSkin;
		}
		/** 오브젝트들을 생성한다 */
		protected function create() : void
		{
			align();
			eventOn();
		}
		/** 배열한다 (after creat(), width, height) */
		protected function align() : void
		{
			// abstract
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		override public function set enabled(bool : Boolean) : void
		{
			super.enabled = bool;
			_track.enabled = bool;
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			align();
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			align();
		}
		/** @copy lance.component.parts.IScroller#page() */
		public function page(delta : int) : void
		{
			_track.page(delta);
		}
		/** @copy lance.component.parts.ISlider#wheel() */
		public function wheel(delta : int) : void
		{
			_track.wheel(delta);
		}
		/** @copy lance.component.parts.ISlider#move() */
		public function move(pixel : int) : void
		{
			_track.move(pixel);
		}
		/** @copy lance.component.parts.IScroller#container */
		public function get container() : IScrollContainer
		{
			return _track.container;
		}
		public function set container(container : IScrollContainer) : void
		{
			_track.container = container;
		}
		/** @copy lance.component.parts.IScroller#sight */
		public function get sight() : Number
		{
			return _track.sight;
		}
		/** @copy lance.component.parts.ISlider#minValue */
		public function get minValue() : Number
		{
			return _track.minValue;
		}
		public function set minValue(minValue : Number) : void
		{
			_track.minValue = minValue;
		}
		/** @copy lance.component.parts.ISlider#maxValue */
		public function get maxValue() : Number
		{
			return _track.maxValue;
		}
		public function set maxValue(maxValue : Number) : void
		{
			_track.maxValue = maxValue;
		}
		/** @copy lance.component.parts.IInput#value */
		override public function get value() : Object
		{
			return _track.value;
		}
		override public function set value(value : Object) : void
		{
			_track.value = value;
		}
		/** @copy lance.component.parts.ISlider#sec */
		public function get sec() : Number
		{
			return _track.sec;
		}
		public function set sec(sec : Number) : void
		{
			_track.sec = sec;
		}
		/* *********************************************************************
		 * Protected Properties and Methods 
		 ********************************************************************* */
		/** @private */
		override lance function eventOn() : void
		{
			super.eventOn();
			_track.addEventListener(ScrollEvent.SCROLL, trackScroll, false, 0, true);
		}
		/** @private */
		override lance function eventOff() : void
		{
			super.eventOff();
			_track.removeEventListener(ScrollEvent.SCROLL, trackScroll);
		}
		/** dispatch scrollEvent */
		private function trackScroll(event : ScrollEvent) : void
		{
			dispatchEvent(new ScrollEvent(event.type, event.secX, event.secY));
		}
		/** page up button listener */
		protected function pageUp(event : MouseEvent) : void
		{
			page(-1);
		}
		/** page down button listener */
		protected function pageDown(event : MouseEvent) : void
		{
			page(1);
		}
		/** move button 들의 시동이벤트 - 마우스를 눌렀을때 */
		protected function moveDown(event : MouseEvent) : void
		{
			_move = event.target as AbstButton;
			_up = (_move == _moveUp) ? true : false;
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, moveTimer, false, 0, true);
			_timer.start();
			
			_move.addEventListener(MouseEvent.ROLL_OUT, moveOut, false, 0, true);
			_move.addEventListener(MouseEvent.ROLL_OVER, moveOver, false, 0, true);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, moveUp, false, 0, true);
		}
		/** moveDown --> mouse 가 버튼위에 있을때 지속적인 이동 */
		protected function moveTimer(event : TimerEvent) : void
		{
			var i : int = (_up) ? 1 : -1;
			move(i * _moveSpeed);
		}
		/** moveDown --> 마우스가 벗어났을때 */
		protected function moveOut(event : MouseEvent) : void
		{
			_timer.stop();
		}
		/** moveOver --> 마우스가 다시 들어왔을때 */
		protected function moveOver(event : MouseEvent) : void
		{
			if (_move.press) {
				_timer.start();
			}
		}
		/** moveDown --> 마우스 떼었을때 */
		protected function moveUp(event : MouseEvent) : void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, moveTimer);
			_move.removeEventListener(MouseEvent.ROLL_OUT, moveOut);
			_move.removeEventListener(MouseEvent.ROLL_OVER, moveOver);
			stage.removeEventListener(MouseEvent.MOUSE_UP, moveUp);
			_timer = null;
			_move = null;
		}
	}
}
