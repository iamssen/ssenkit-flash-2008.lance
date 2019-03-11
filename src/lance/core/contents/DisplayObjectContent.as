package lance.core.contents 
{
	import lance.core.contents.ContentType;
	import flash.display.DisplayObject;	

	import lance.core.contents.Content;
	/**
	 * DisplayObject Content
	 * @author SSen
	 */
	public class DisplayObjectContent extends Content 
	{
		private var _displayObject : DisplayObject;

		public function DisplayObjectContent(displayObject : DisplayObject)
		{
			super(ContentType.DISPLAY_OBJECT);
			_displayObject = displayObject;
		}
		override public function getObject() : Object
		{
			return _displayObject;
		}
		override public function getDisplayObject() : DisplayObject
		{
			return _displayObject;
		}
		override public function toString() : String
		{
			return "[DisplayObjectContent]";
		}
	}
}
