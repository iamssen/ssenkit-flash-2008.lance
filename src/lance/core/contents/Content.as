package lance.core.contents 
{
	import lance.core.text.TextStyle;
	
	import flash.display.DisplayObject;	
	/**
	 * Content
	 * @author SSen
	 */
	public class Content
	{
		private var _type : String;

		public function Content(type : String)
		{
			_type = type;
		}
		/** content 의 원형을 가져온다 */
		public function getObject() : Object
		{
			return null;
		}
		/** content 를 DisplayObject 형식으로 가져온다 */
		public function getDisplayObject() : DisplayObject
		{
			return null;
		}
		/** string 일 경우 textfiled 의 style 을 지정해준다 */
		public function setTextStyle(textStyle : TextStyle = null, multiline : Boolean = true, wordWrap : Boolean = true) : void
		{
			trace("abstract for StringContent");
		}
		/** toString */
		public function toString() : String
		{
			return "";
		}
		/** String 일 경우 html 옵션 */
		public function get html() : Boolean
		{
			return false;
		}
		/** 
		 * content 의 type
		 * @see lance.core.contents.ContentType
		 */
		public function get type() : String
		{
			return _type;
		}
	}
}
