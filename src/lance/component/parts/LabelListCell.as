package lance.component.parts 
{
	import flash.display.DisplayObject;

	import lance.component.parts.AbstListCell;
	import lance.core.contents.Content;
	import lance.core.skinObject.ISkinObject;
	import lance.core.skinObject.SkinLabel;
	import lance.core.skinObject.SkinMode;
	import lance.core.text.TextStyle;
	import lance.lance;		
	use namespace lance;
	/**
	 * Description
	 * @author SSen
	 */
	public class LabelListCell extends AbstListCell 
	{
		private var _bg : ISkinObject;
		private static const TITLE_ID : String = "title";

		/*
		 * Initializer
		 */
		public function LabelListCell(title : String, bg : ISkinObject, textStyle : TextStyle, width : int = 0, height : int = 0, thumbnail : Content = null)
		{
			var label : SkinLabel = new SkinLabel(title, textStyle, thumbnail, false);
			super(width, height, label);
			_bg = bg;
			_values[TITLE_ID] = label.text;
			init();
			eventOn();
		}
		/** @private */
		override protected function init() : void
		{
			super.init();
			
			addChild(DisplayObject(_bg));
			addChild(DisplayObject(_content));
			
			label.x = 2;
			
			width = _width;
			height = _height;
		}
		/*
		 * Interface
		 */
		/** label 의 title */
		public function get title() : String
		{
			return _values[TITLE_ID];
		}
		public function set title(title : String) : void
		{
			_values[TITLE_ID] = title;
			label.text = title;
		}
		/** title 에서 검색한다 */
		public function searchTitle(text : String) : Boolean
		{
			return searchValue(TITLE_ID, text);
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			_bg.width = value;
			label.width = value - 4;
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			if (minHeight > value) value = minHeight;
			super.height = value;
			_bg.height = value;
			
			label.y = (_bg.height >> 1) - (label.height >> 1);
		}
		override public function get minHeight() : Number
		{
			return label.height + 4;
		}
		/*
		 * SkinLabel Interface
		 */
		public function setThumbnail(thumbnail : Content = null, thumbnailResize : Boolean = true) : void
		{
			label.setThumbnail(thumbnail, thumbnailResize);
		}
		public function removeThumbnail() : void
		{
			label.removeThumbnail();
		}
		public function get textStyle() : TextStyle
		{
			return label.textStyle;
		}
		public function set textStyle(textStyle : TextStyle) : void
		{
			label.textStyle = textStyle;
		}
		/*
		 * Skinning Interface
		 */
		/** bg */
		public function get bg() : ISkinObject
		{
			return _bg;
		}
		public function set bg(bg : ISkinObject) : void
		{
			addChildTo(DisplayObject(bg), DisplayObject(_bg));
			_bg = bg;
		}
		/** @private */
		override lance function skinning(modeName : String = null) : void
		{
			if (modeName != null) _skinMode = modeName;
			super.skinning();
			_bg.skinning(_skinMode);
			
			if (_skinMode == SkinMode.OVER && !label.roll) {
				label.rollStart(_skinMode);
			} else if (_skinMode != SkinMode.OVER) {
				label.rollStop(_skinMode);
			}
		}
		/** _content as SkinLabel */
		protected function get label() : SkinLabel
		{
			return _content as SkinLabel;
		}
	}
}
