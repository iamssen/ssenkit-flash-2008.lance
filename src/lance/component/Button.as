package lance.component 
{
	import lance.core.skinObject.SkinLabel;	
	import lance.component.skin.LanceSkin;	
	import lance.component.parts.AbstButton;	
	import lance.core.skinObject.ISkinObject;	
	import lance.core.geom.Position9;	
	import lance.component.skin.ButtonSkin;
	import lance.core.skinObject.SkinGridSprite;	
	import lance.component.parts.LanceSkinComponent;	

	import flash.display.DisplayObject;

	import lance.lance;
	use namespace lance;
	/**
	 * Button UI Object
	 * @author SSen
	 */
	public class Button extends AbstButton
	{
		// position9 내부 컨텐츠의 정렬
		private var _contentPosition9 : String;
		// 자동 사이즈 관련
		private var _autoWidth : Boolean;
		private var _autoHeight : Boolean;
		// 모양새들
		private var _content : ISkinObject;
		private var _bg : SkinGridSprite;

		/* *********************************************************************
		 * Initializer
		 ********************************************************************* */
		/**
		 * @param thumb thumnail 이 될 그림의 displayObject 나 bitmapData
		 * @param title 제목 글씨
		 * @param skin button 의 스킨
		 * @param type 보통 버튼 이거나 toggle 버튼으로 설정 가능
		 */
		public function Button(skin : ButtonSkin, width : int = 0, height : int = 0,
								content : ISkinObject = null,
								autoWidth : Boolean = true,
								autoHeight : Boolean = false,
								buttonType : String = "normal", 
								contentPosition9 : String = "middleCenter"
								)
		{
			super(skin, width, height, buttonType);
			
			// 정보들을 저장한다
			_content = content;
			_autoWidth = autoWidth;
			_autoHeight = autoHeight;
			_contentPosition9 = contentPosition9;
			
			init();
		}
		// _skin 형변환
		private function get buttonSkin() : ButtonSkin
		{
			return ButtonSkin(_skin); 
		}
		/** @private */
		override protected function init() : void
		{
			super.init(); 
			
			_bg = buttonSkin.button_bg();
			addChild(_bg);
			if (_content != null) addChild(DisplayObject(_content));
			
			_bg.width = _width;
			_bg.height = _height;
			
			align();
			eventOn();
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		public override function set skin(skin : LanceSkin) : void
		{
			var buttonSkin : ButtonSkin = ButtonSkin(skin);
			var bg : SkinGridSprite = buttonSkin.button_bg();
			addChildTo(bg, _bg);
			_bg = bg;
			if (_content is SkinLabel) SkinLabel(_content).textStyle.colors = buttonSkin.button_fontColors;
			super.skin = skin;
		}
		/** 가로 사이즈 자동 맞추기 */
		public function get autoWidth() : Boolean
		{
			return _autoWidth;
		}
		public function set autoWidth(bool : Boolean) : void
		{
			_autoWidth = bool;
			align();
		}
		/** 높이 자동 맞추기 */
		public function get autoHeight() : Boolean
		{
			return _autoHeight;
		}
		public function set autoHeight(bool : Boolean) : void
		{
			_autoHeight = bool;
			align();
		}
		/** content position #lance.core.geom.Position9 constants TL, ML, BL... */
		public function get contentPosition9() : String
		{
			return _contentPosition9;
		}
		public function set contentPosition9(contentPosition9 : String) : void
		{
			_contentPosition9 = contentPosition9;
			align();
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			_width = value;
			align();
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			_height = value;
			align();
		}
		/** @private */
		override public function kill() : void
		{
			eventOff();
			if (_content != null) removeChild(DisplayObject(_content));
			removeChild(_bg);
			_skin = null;
		}		
		/** @private */
		override lance function skinning(modeName : String = null) : void
		{
			if (modeName != null) _skinMode = modeName;
			super.skinning(_skinMode);
			_bg.skinning(_skinMode);
			if (_content != null) _content.skinning(_skinMode);
		}
		/* *********************************************************************
		 * Private Util functions
		 ********************************************************************* */
		// 정렬한다
		private function align() : void
		{
			if (_content != null) {
				// grid bitmap size
				var minWidth : Number = _content.width + buttonSkin.button_innerGrid.left + buttonSkin.button_innerGrid.right;
				var minHeight : Number = _content.height + buttonSkin.button_innerGrid.top + buttonSkin.button_innerGrid.bottom;
				
				if (_autoWidth || _width < minWidth) {
					_bg.width = minWidth;
					_width = minWidth;
				} else {
					_bg.width = _width;
				}
				if (_autoHeight || _height < minHeight) {
					_bg.height = minHeight;
					_height = minHeight;
				} else {
					_bg.height = _height;
				}
				
				// align txt and thumb
				var w : Number = _content.width;
				var h : Number = _content.height;
				var x : int;
				var y : int;
				switch (_contentPosition9) {
					case Position9.TL :
					case Position9.TC :
					case Position9.TR :
						y = buttonSkin.button_innerGrid.top;
						break;
					case Position9.ML : 
					case Position9.MC :
					case Position9.MR : 
						y = (_bg.height >> 1) - (h >> 1);
						break;
					case Position9.BL :
					case Position9.BC : 
					case Position9.BR : 
						y = _bg.height - h - buttonSkin.button_innerGrid.bottom;
						break;
				}
				switch (_contentPosition9) {
					case Position9.TL :
					case Position9.ML :
					case Position9.BL :
						x = buttonSkin.button_innerGrid.left;
						break;
					case Position9.TC :
					case Position9.MC :
					case Position9.BC :
						x = (_bg.width >> 1) - (w >> 1);
						break;
					case Position9.TR :
					case Position9.MR :
					case Position9.BR :
						x = _bg.width - w - buttonSkin.button_innerGrid.right;
						break;
				}
				_content.x = x;
				_content.y = y;
			} else {
				_bg.width = _width;
				_bg.height = _height;
			}
		}
	}
}
