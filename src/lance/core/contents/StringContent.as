package lance.core.contents 
{
	import lance.core.text.LanceTextField;	
	import lance.core.contents.ContentType;
	import lance.core.text.TextStyle;	

	import flash.display.DisplayObject;	

	import lance.core.contents.Content;
	/**
	 * String Content
	 * @author SSen
	 */
	public class StringContent extends Content 
	{
		private var _string : String;
		private var _html : Boolean;
		private var _textStyle : TextStyle;
		private var _multiline : Boolean = true;
		private var _wordWrap : Boolean = true;

		public function StringContent(string : String, html : Boolean = false)
		{
			super(ContentType.STRING);
			_string = string;
			_html = html;
		}
		/** @private */
		override public function getObject() : Object
		{
			return _string;
		}
		/** @private */
		override public function getDisplayObject() : DisplayObject
		{
			var txt : LanceTextField = new LanceTextField();
			txt.multiline = _multiline;
			txt.wordWrap = _wordWrap;
			if (_textStyle != null) {
				txt.defaultTextFormat = _textStyle;
			}
			if (_html) {
				txt.htmlText = _string;
			} else {
				txt.text = _string;
			}
			return txt;
		}
		/** @private */
		override public function setTextStyle(textStyle : TextStyle = null, multiline : Boolean = true, wordWrap : Boolean = true) : void
		{
			_textStyle = textStyle;
			_multiline = multiline;
			_wordWrap = wordWrap;
		}
		/** @private */
		override public function get html() : Boolean
		{
			return _html;
		}
		/** @private */
		override public function toString() : String
		{
			return _string;
		}
	}
}
