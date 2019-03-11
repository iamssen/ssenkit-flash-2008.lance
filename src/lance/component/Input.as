package lance.component 
{
	import lance.component.parts.LanceInputComponent;
	import lance.component.properties.ValueType;
	import lance.component.skin.InputSkin;
	import lance.component.skin.LanceSkin;
	import lance.core.contents.Content;
	import lance.core.contents.ContentType;
	import lance.core.events.LanceEvent;
	import lance.core.skinObject.SkinGridSprite;
	import lance.core.skinObject.SkinMode;
	import lance.core.text.LanceTextField;
	import lance.core.text.TextStyle;
	import lance.lance;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;		
	
	use namespace lance;

	/** keyDown */
	[Event(name="keyDown", type="flash.events.KeyboardEvent")]

	/** keyUp */
	[Event(name="keyUp", type="flash.events.KeyboardEvent")]

	/** textInput */
	[Event(name="textInput", type="flash.events.TextEvent")]

	/** @copy lance.core.events.LanceEvent#INPUT_START */
	[Event(name="inputStart", type="lance.core.events.LanceEvent")]

	/** @copy lance.core.events.LanceEvent#INPUT_END */
	[Event(name="inputEnd", type="lance.core.events.LanceEvent")]

	/**
	 * Input Component
	 * @author SSen 
	 */
	public class Input extends LanceInputComponent 
	{
		// object
		private var _txt : LanceTextField;
		private var _bg : SkinGridSprite;
		// content
		private var _thumbnail : DisplayObject;
		private var _textStyle : TextStyle;
		private var _textAlign : String;
		// log -- 최근 입력 기록
		protected var _logID : String;
		// mark -- [front]내용내용[back]
		protected var _frontMark : String;
		protected var _backMark : String;

		/* *********************************************************************
		 * Initializer
		 ********************************************************************* */
		public function Input(skin : InputSkin, width : int = 0, height : int = 0,
								defaultValue : String = null,
								thumbnail : Content = null,
								textStyle : TextStyle = null,
								textAlign : String = "left",
								logID : String = null,
								frontMark : String = null,
								backMark : String = null
								)
		{
			super(skin, width, height, ValueType.STRING);
			
			if (thumbnail != null && (thumbnail.type == ContentType.BITMAP_DATA || thumbnail.type == ContentType.DISPLAY_OBJECT)) _thumbnail = thumbnail.getDisplayObject();
			_value = (defaultValue != null && defaultValue != "") ? defaultValue : "";
			
			_skinMode = SkinMode.DEFAULT;
			_textAlign = textAlign;
			_logID = logID;
			_frontMark = frontMark;
			_backMark = backMark;
			_textStyle = (textStyle != null) ? textStyle : new TextStyle();
			if (_textStyle.colors == null) _textStyle.colors = inputSkin.input_colors();
			
			init();
		}
		private function init() : void
		{
			tabEnabled = true;
			
			_bg = inputSkin.input_bg();
			addChild(_bg);
			if (_thumbnail != null) addChild(_thumbnail);
			
			_txt = new LanceTextField();
			_txt.defaultTextFormat = _textStyle;
			setText(String(_value));
			_txt.type = TextFieldType.INPUT;
			_txt.alwaysShowSelection = true;
			addChild(_txt);
			
			_skinMode = SkinMode.DEFAULT;
			
			_bg.width = _width;
			_bg.height = _height;
			
			align();
			skinning();
			eventOn();
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		public override function set skin(skin : LanceSkin) : void
		{
			var inputSkin : InputSkin = InputSkin(skin);
			var bg : SkinGridSprite = inputSkin.input_bg();
			addChildTo(bg, _bg);
			_bg = bg;
			_textStyle.colors = inputSkin.input_colors();
			super.skin = skin;
		}
		/** text position #flash.text.TextFormatAlign */
		public function get textAlign() : String
		{
			return _textAlign;
		}
		public function set textAlign(textAlign : String) : void
		{
			_textAlign = textAlign;
			align();
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			_bg.width = value;
			align();
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			_bg.height = value;
			align();
		}
		/** @private */
		override public function set enabled(bool : Boolean) : void
		{
			super.enabled = bool;
			if (bool) {
				if (stage.focus == _txt) {
					skinFocus();
				} else {
					skinDefault();
				}
				tabEnabled = true;
			} else {
				skinDisable();
				tabEnabled = false;
			}
		}
		/** thumb */
		public function get thumbnail() : DisplayObject
		{
			return _thumbnail;
		}
		public function set thumbnail(thumb : DisplayObject) : void
		{
			removeThumb(false);
			_thumbnail = thumb;
			addChild(_thumbnail);
			align();
		}
		/** thumb 을 삭제함 */
		public function removeThumb(afterAlign : Boolean = true) : void
		{
			if (_thumbnail != null && contains(_thumbnail)) {
				removeChild(_thumbnail);
				_thumbnail = null;
			}
			if (afterAlign) align();
		}
		/** @private */
		override public function get value() : Object
		{
			if (_skinMode == SkinMode.ACTION) {
				return _txt.text;
			}
			return _value;
		}
		/** @private */
		override public function set value(value : Object) : void
		{
			super.value = String(value);
			setText(String(value));
		}
		// TODO Input 신규 인터페이스 구현하기
		/** null 이 아니면, SharedObject 를 사용해서 추천을 제공한다 */
		public function get logID() : String
		{
			return _logID;
		}
		public function set logID(logID : String) : void
		{
			_logID = logID;
		}
		/** Unfocused 시에 앞에 붙는 단어 */
		public function get frontMark() : String
		{
			return _frontMark;
		}
		public function set frontMark(frontMark : String) : void
		{
			_frontMark = frontMark;
			setText(String(_value));
		}
		/** Unfocused 시에 뒤에 붙는 단어 */
		public function get backMark() : String
		{
			return _backMark;
		}
		public function set backMark(backMark : String) : void
		{
			_backMark = backMark;
			setText(String(_value));
		}
		/* *********************************************************************
		 * Event 
		 ********************************************************************* */
		override lance function eventOn() : void
		{
			super.eventOn();
			_txt.addEventListener(FocusEvent.FOCUS_IN, focusIn, false, 0, true);
			_txt.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
			_txt.addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 0, true);
			_txt.addEventListener(TextEvent.TEXT_INPUT, textInput, false, 0, true);
			addEventListener(FocusEvent.FOCUS_IN, focusThis, false, 0, true);
		}
		override lance function eventOff() : void
		{
			super.eventOff();
			eventOffOut();
			_txt.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			_txt.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_txt.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			_txt.removeEventListener(TextEvent.TEXT_INPUT, textInput);
			removeEventListener(FocusEvent.FOCUS_IN, focusThis);
		}
		private function eventOnOut() : void
		{
			skinFocus();
			stage.addEventListener(MouseEvent.CLICK, outClick, false, 0, true);
		}
		private function eventOffOut() : void
		{
			skinDefault();
			if (stage.hasEventListener(MouseEvent.CLICK)) stage.removeEventListener(MouseEvent.CLICK, outClick);
		}
		// tab 으로 focus 가 발생하면 txt 로 옮겨준다.
		private function focusThis(event : FocusEvent) : void
		{
			stage.focus = _txt;
		}
		// txt 이벤트를 옮겨준다
		private function textInput(event : TextEvent) : void
		{
			dispatchEvent(event);
		}
		private function keyUp(event : KeyboardEvent) : void
		{
			dispatchEvent(event);
		}
		private function keyDown(event : KeyboardEvent) : void
		{
			if (event.keyCode == 9) {
				txtOut();
			}
			if (event.keyCode == 13) {
				dispatchEvent(new LanceEvent(LanceEvent.INPUT_ENTER));
			}
			dispatchEvent(event);
		}
		// txt 밖으로 포커스가 빠질때의 행동들
		private function txtOut() : void
		{
			eventOffOut();
			_value = _txt.text;
			dispatchEvent(new LanceEvent(LanceEvent.INPUT_END));
		}
		// txt 에 포커스 들어옴 
		private function focusIn(event : FocusEvent) : void
		{
			eventOnOut();
			_txt.defaultTextFormat = _textStyle;
			_txt.setTextFormat(_textStyle);
			dispatchEvent(new LanceEvent(LanceEvent.INPUT_START));
		}
		// 바깥 클릭
		// TODO 특수 기능들의 경우엔 영역을 다르게 지정
		private function outClick(event : MouseEvent) : void
		{
			var click : Boolean = isPointerInRect(stage, new Rectangle(_bg.x, _bg.y, _bg.width, _bg.height));
			var focus : Boolean = stage.focus == _txt;
			if (!focus && !click) {
				txtOut(); 
			}
		}
		/* *********************************************************************
		 * Skinning Methods
		 ********************************************************************* */
		// 스킨 새로고침
		/*
		private function refreshSkin() : void
		{
		switch (_skinMode) {
		case SkinMode.ACTION :
		skinFocus();
		break;
		case SkinMode.DISABLE :
		skinDisable();
		break;
		default :
		skinDefault();
		break;
		}
		}*/
		// 기본 스킨
		private function skinDefault() : void
		{
			if (enabled) {
				_skinMode = SkinMode.DEFAULT;
				skinning();
			}
		}
		// 포커스 상태 스킨
		private function skinFocus() : void
		{
			if (enabled) {
				_skinMode = SkinMode.ACTION;
				skinning();
			}
		}
		// 비활성 상태 스킨
		private function skinDisable() : void
		{
			_skinMode = SkinMode.DISABLE;
			skinning();
		}
		// 스킨을 입힌다
		override lance function skinning(modeName : String = null) : void
		{
			var mode : String = (modeName == null) ? _skinMode : modeName;
			_bg.skinning(mode);
			_textStyle.color = _textStyle.colors[mode];
			_txt.setTextFormat(_textStyle);
			_txt.defaultTextFormat = _textStyle;
		}
		/* *********************************************************************
		 * Private Util functions
		 ********************************************************************* */
		// 재정렬
		private function align() : void
		{
			var skin : InputSkin = inputSkin;
			
			if (_txt.fixHeight > _height - skin.input_innerGrid.top - skin.input_innerGrid.bottom) {
				_height = _txt.fixHeight + skin.input_innerGrid.top + skin.input_innerGrid.bottom;
				_bg.height = _height;
			}
			
			_txt.height = _txt.fixHeight;
			_txt.y = (_height >> 1) - (_txt.height >> 1);
			
			if (_thumbnail != null && contains(_thumbnail)) {
				if (_thumbnail.height > _height - skin.input_innerGrid.top - skin.input_innerGrid.bottom) {
					var d : Number = (_height - skin.input_innerGrid.top - skin.input_innerGrid.bottom) / _thumbnail.height;
					_thumbnail.width *= d;
					_thumbnail.height *= d;
					if (_thumbnail is Bitmap) Bitmap(_thumbnail).smoothing = true;
				}
				_thumbnail.y = (_height >> 1) - (_thumbnail.height >> 1);
				_thumbnail.x = _thumbnail.y;
				_txt.width = _width - skin.input_innerGrid.left - skin.input_innerGrid.right - _thumbnail.width - _thumbnail.x;
				_txt.x = (_thumbnail.x << 1) + _thumbnail.width;
			} else {
				_txt.width = _width - skin.input_innerGrid.left - skin.input_innerGrid.right;
				_txt.x = skin.input_innerGrid.left;
			}
			
			switch (_textAlign) {
				case TextFormatAlign.LEFT :
				case TextFormatAlign.JUSTIFY :
				case TextFormatAlign.CENTER :
				case TextFormatAlign.RIGHT :
					break;
				default :
					_textAlign = TextFormatAlign.LEFT;
					break;
			}
			_textStyle.align = _textAlign;
			_txt.setTextFormat(_textStyle);
		}
		// _txt.text = 
		private function setText(str : String) : void
		{
			if (str != "") {
				if (_frontMark != null && _frontMark != "") {
					str = _frontMark + str;
				}
				if (_backMark != null && _backMark != "") {
					str = str + _backMark;
				}
			}
			_txt.text = str;
			_txt.setTextFormat(_textStyle);
		}
		// _skin 형변환
		private function get inputSkin() : InputSkin
		{
			return InputSkin(_skin); 
		}
	}
}
