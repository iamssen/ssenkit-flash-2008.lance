package lance.component.parts 
{
	import flash.events.KeyboardEvent;	
	import flash.events.FocusEvent;	
	import flash.events.MouseEvent;	

	import lance.core.events.OnOffEvent;
	import lance.component.properties.ButtonType;	
	import lance.core.skinObject.SkinMode;	
	import lance.component.skin.LanceSkin;	
	import lance.component.parts.LanceSkinComponent;
	import lance.lance;
	use namespace lance;

	/** @copy lance.core.events.OnOffEvent#ONOFF */
	[Event(name="onoff", type="lance.core.events.OnOffEvent")]

	/** 마우스 클릭 - 당연히 interactive object 의 모든 event 가 된다 */
	[Event(name="click", type="flash.events.MouseEvent")]

	/**
	 * 버튼의 원시구현
	 * @author SSen
	 */
	public class AbstButton extends LanceSkinComponent 
	{
		// button mode - normal, toggle
		protected var _buttonType : String;
		protected var _selected : Boolean = false;
		protected var _press : Boolean;

		public function AbstButton(skin : LanceSkin, width : int = 0, height : int = 0, buttonType : String = "normal")
		{
			super(skin, width, height);
			_buttonType = buttonType;
		}
		/** @private */
		protected function init() : void
		{
			mouseChildren = false;
			tabEnabled = true;
			buttonMode = true;
			
			_skinMode = SkinMode.DEFAULT;
		}
		/** toggle 상태 */
		public function get selected() : Boolean
		{
			return _selected;
		}
		public function set selected(selected : Boolean) : void
		{
			_selected = selected;
			skinDefault();
		}
		/** button type #lance.component.constant.ButtonType */
		public function get buttonType() : String
		{
			return _buttonType;
		}
		public function set buttonType(buttonType : String) : void
		{
			_buttonType = buttonType;
			_selected = false;
			if (_buttonType == ButtonType.TOGGLE) {
				
				if (!hasEventListener(MouseEvent.CLICK)) addEventListener(MouseEvent.CLICK, mouseClick, false, 0, true);
			} else {
				if (hasEventListener(MouseEvent.CLICK)) removeEventListener(MouseEvent.CLICK, mouseClick);
			}
			skinning();
		}
		/** @private */
		override public function set enabled(bool : Boolean) : void
		{
			super.enabled = bool;
			if (bool) {
				skinDefault();
				tabEnabled = true;
				buttonMode = true;
			} else {
				skinDisabled();
				tabEnabled = false;
				buttonMode = false;
			}
			mouseChildren = false;
		}
		/** 누른 상태인지 확인 */
		public function get press() : Boolean
		{
			return _press;
		}
		/* *********************************************************************
		 * Event 
		 ********************************************************************* */
		/** @copy lance.component.parts.LanceComponent#eventOn */
		override lance function eventOn() : void
		{
			super.eventOn();
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0, true);
			if (_buttonType == ButtonType.TOGGLE) addEventListener(MouseEvent.CLICK, mouseClick, false, 0, true);
			addEventListener(FocusEvent.FOCUS_IN, focusIn, false, 0, true);
			addEventListener(FocusEvent.FOCUS_OUT, focusOut, false, 0, true);
		}
		/** @copy lance.component.parts.LanceComponent#eventOff */
		override lance function eventOff() : void
		{
			super.eventOff();
			removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			if (_buttonType == ButtonType.TOGGLE) removeEventListener(MouseEvent.CLICK, mouseClick);
			removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			if (stage.hasEventListener(MouseEvent.MOUSE_UP)) stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function focusOut(event : FocusEvent) : void
		{
			if (enabled) {
				skinDefault();
				removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			}
		}
		private function focusIn(event : FocusEvent) : void
		{
			if (enabled) {
				skinOver();
				addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
				addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 0, true);
			}
		}
		private function keyUp(event : KeyboardEvent) : void
		{
			if (event.keyCode == 32 || event.keyCode == 13) {
				skinOver();
				dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, 0, 0, null, event.ctrlKey, event.altKey, event.shiftKey));
			}
		}
		private function keyDown(event : KeyboardEvent) : void
		{
			if (event.keyCode == 32 || event.keyCode == 13) {
				skinDown();
			}
		}
		// 토글 클릭
		private function mouseClick(event : MouseEvent) : void
		{
			_selected = (_selected) ? false : true;
			dispatchEvent(new OnOffEvent(OnOffEvent.ONOFF, _selected));
			if (_selected) {
				skinDown();
			} else {
				skinOver();
			}
		}
		// 마우스 눌렀다 뗌
		private function mouseUp(event : MouseEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_press = false;
			if (isPointerInRect(this, getRect(this))) {
				skinOver();
			} else {
				skinDefault();
			}
		}
		// 마우스 누름
		private function mouseDown(event : MouseEvent) : void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
			_press = true;
			skinDown();
		}
		// 마우스 벗어남
		private function mouseOut(event : MouseEvent) : void
		{
			skinDefault();
		}
		// 마우스 오버
		private function mouseOver(event : MouseEvent) : void
		{
			if (_press) {
				skinDown();
			} else {
				skinOver();
			}
		}
		/* *********************************************************************
		 * Skinning Methods
		 ********************************************************************* */
		// 스킨 #기본 상태
		private function skinDefault() : void
		{
			if (_selected) {
				_skinMode = SkinMode.ACTION;
			} else {
				_skinMode = SkinMode.DEFAULT;
			}
			skinning();
		}
		// 스킨 #비활성화 상태
		private function skinDisabled() : void
		{
			_skinMode = SkinMode.DISABLE;
			skinning();
		}
		// 스킨 #오버되어 있는 모습
		private function skinOver() : void
		{
			_skinMode = SkinMode.OVER;
			skinning();
		}
		// 스킨 #누르는 순간
		private function skinDown() : void
		{
			_skinMode = SkinMode.ACTION;
			skinning();
		}
	}
}
