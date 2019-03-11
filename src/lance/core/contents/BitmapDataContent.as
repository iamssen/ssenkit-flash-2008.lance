package lance.core.contents 
{
	import lance.core.contents.ContentType;
	import flash.display.DisplayObject;	
	import flash.display.Bitmap;	
	import flash.display.BitmapData;	

	import lance.core.contents.Content;
	/**
	 * BitmapData Content
	 * @author SSen
	 */
	public class BitmapDataContent extends Content 
	{
		private var _bitmapData : BitmapData;

		public function BitmapDataContent(bitmapData : BitmapData)
		{
			super(ContentType.BITMAP_DATA);
			_bitmapData = bitmapData;
		}
		/** @private */
		override public function getObject() : Object
		{
			return _bitmapData;
		}
		/** @private */
		override public function getDisplayObject() : DisplayObject
		{
			return new Bitmap(_bitmapData);
		}
		/** @private */
		override public function toString() : String
		{
			return "[BitmapDataContent]";
		}
	}
}
