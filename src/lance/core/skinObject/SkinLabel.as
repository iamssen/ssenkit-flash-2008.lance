package lance.core.skinObject 
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	
	import lance.core.contents.Content;
	import lance.core.contents.ContentType;
	import lance.core.geom.VerticalAlign;
	import lance.core.graphics.FavoriteColorMatrix;
	import lance.core.graphics.LanceSprite;
	import lance.core.skinObject.ISkinObject;
	import lance.core.skinObject.SkinMode;
	import lance.core.skinObject.SkinSprite;
	import lance.core.text.ITextObject;
	import lance.core.text.LanceTextField;
	import lance.core.text.RollText;
	import lance.core.text.TextStyle;		
	/**
	 * SkinObject : Thumbnail 과 TextField 로 구성된 Label, textStyle 를 사용해서 SkinMode 를 구성한다
	 * @author SSen
	 */
	public class SkinLabel extends LanceSprite implements ISkinObject, ITextObject 
	{
		private var _title : LanceTextField;
		private var _thumbnail : DisplayObject;
		private var _textStyle : TextStyle;
		private var _isSkinSprite : Boolean;
		private var _flag : String;
		private var _width : Number;
		private var _roll : Boolean;
		private var _rollTitle : RollText;

		public function SkinLabel(title : String, textStyle : TextStyle, thumbnail : Content = null, thumbnailResize : Boolean = true)
		{
			super();
			
			_flag = SkinMode.DEFAULT;
			_textStyle = textStyle;
			
			var txt : LanceTextField = new LanceTextField();
			_title = txt;
			_title.defaultTextFormat = _textStyle;
			_title.text = title;
			_title.autoReplaceOverText = true;
			_title.autoSizeWidth();
			_title.autoSizeHeight();
			
			setThumbnail(thumbnail, thumbnailResize);
			
			mouseChildren = false;
			addChild(_title);
		}
		/** 
		 * thumbnail 을 생성, 교체한다.
		 * @param thumbnail bitmapData 혹은 displayObject
		 * @param thumbnailResize thumbnail 을 리사이즈 할 것 인지의 여부
		 */
		public function setThumbnail(thumbnail : Content = null, thumbnailResize : Boolean = true) : void
		{
			removeThumbnail();
			
			if (thumbnail != null && (thumbnail.type == ContentType.BITMAP_DATA || thumbnail.type == ContentType.DISPLAY_OBJECT)) {
				_thumbnail = thumbnail.getDisplayObject();
				if (_thumbnail is SkinSprite) _isSkinSprite = true;
				addChild(_thumbnail);
			}
			
			if (_thumbnail != null) {
				if (thumbnailResize && _thumbnail.height > _title.height) {
					var d : Number = _title.height / _thumbnail.height;
					_thumbnail.width *= d;
					_thumbnail.height *= d;
				} else if (_thumbnail.height > _title.height) {
					_title.y = (_thumbnail.height >> 1) - (_title.height >> 1);
				} else {
					_thumbnail.y = (_title.height >> 1) - (_thumbnail.height >> 1);
				}
				addChild(_thumbnail);
				
				_title.x = _thumbnail.width + 4;
			} else {
				_title.x = 0;
			}
			
			align();
		}
		/** thumbnail 을 지운다 */
		public function removeThumbnail() : void
		{
			if (_thumbnail != null && contains(_thumbnail)) {
				removeChild(_thumbnail);
				_thumbnail = null;
				align();
			}
		}
		// 정렬
		private function align() : void
		{
			var obj : DisplayObject = (_roll) ? _rollTitle : _title;
			if (_width > 0) {
				var w : Number = _width;
				if (_thumbnail != null) w -= _thumbnail.width + 4;
				obj.width = w;
			} else {
				_width = obj.x + obj.width;
			}
		}
		/** @copy lance.core.text.ITextObject#length */
		public function get length() : int
		{
			return _title.text.length;
		}
		/** @copy lance.core.text.ITextObject#text */
		public function get text() : String
		{
			return _title.text;
		}
		public function set text(value : String) : void
		{
			_title.text = value;
		}
		/** @copy lance.core.text.ITextObject#appendText() */
		public function appendText(newText : String) : void
		{
			_title.appendText(newText);
		}
		/** @copy lance.core.text.ITextObject#replaceText() */
		public function replaceText(beginIndex : int, endIndex : int, newText : String) : void
		{
			_title.replaceText(beginIndex, endIndex, newText);
		}
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			if (_roll && _title.fixWidth < value) {
				rollStop();
			}
			_width = value;
			align();
		}
		/** text 에 맞춰서 자동으로 폭을 맞춘다 */
		public function autoSizeWidth() : void
		{
			if (_roll) {
				rollStop();
			}
			_title.autoSizeWidth();
			_width = 0;
			align();
		}
		/** @copy lance.core.skinObject#skinning() */
		public function skinning(modeName : String = SkinMode.DEFAULT) : void
		{
			_textStyle.color = _textStyle.colors[modeName];
			_title.setTextFormat(_textStyle);
			_title.defaultTextFormat = _textStyle;
			
			if (_isSkinSprite) {
				var skinsp : SkinSprite = _thumbnail as SkinSprite;
				skinsp.skinning(modeName);
			} else if (_thumbnail != null) {
				if (modeName == SkinMode.DISABLE) {
					_thumbnail.filters = [new ColorMatrixFilter(FavoriteColorMatrix.GRAY)];
				} else {
					_thumbnail.filters = null;
				}
			}
			_flag = modeName;
		}
		/** @copy lance.core.skinObject#flag */
		public function get flag() : String
		{
			return _flag;
		}
		/** @copy lance.core.skinObject#skinList */
		public function get skinList() : Array
		{
			var arr : Array = new Array();
			var name : String;
			for (name in _textStyle.colors) {
				arr.push(name);
			}
			return arr;
		}
		/** label 의 textStyle 을 교체한다 */
		public function get textStyle() : TextStyle
		{
			return _textStyle;
		}
		public function set textStyle(textStyle : TextStyle) : void
		{
			_textStyle = textStyle;
			_textStyle.color = _textStyle.colors[_flag];
			_title.defaultTextFormat = textStyle;
			_title.setTextFormat(textStyle);
		}
		public function rollStop(modeName : String = "default") : void
		{
			if (_roll) {
				_roll = false;
				_textStyle.color = _textStyle.colors[modeName];
				_flag = modeName;
				var h : Number = _title.height;
				addChildTo(_title, _rollTitle);
				_title.height = h;
				_rollTitle = null;
				skinning(_flag);
			}
		}
		public function rollStart(modeName : String = "default") : void
		{
			if (!_roll && _title.fixWidth > _width) {
				_roll = true;
				_textStyle.color = _textStyle.colors[modeName];
				_rollTitle = new RollText(_title.text, _title.width, _title.height, _textStyle, null, VerticalAlign.TOP);
				var h : Number = _rollTitle.height;
				_flag = modeName;
				addChildTo(_rollTitle, _title);
				_rollTitle.height = h;
				_rollTitle.roll = true;
			}
		}
		public function get roll() : Boolean
		{
			return _roll;
		}
	}
}
