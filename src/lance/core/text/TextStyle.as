package lance.core.text 
{
	import flash.text.TextFormat;
	/**
	 * TextStyle
	 * @author SSen
	 */
	public class TextStyle extends TextFormat 
	{
		private var _embedFont : Boolean;
		private var _colors : Object;
		private var _sharpness : Number;
		private var _thickness : Number;
		private var _border : Boolean;
		private var _borderColor : uint;
		private var _background : Boolean;
		private var _backgroundColor : uint;

		public function TextStyle(embedFont : Boolean = false, colors : Object = null, sharpness : Number = 0, thickness : Number = 0, border : Boolean = false, borderColor : uint = 0, background : Boolean = false, backgroundColor : uint = 0xffffff, 
									font : String = "돋움", size : Object = 11, color : Object = -1, bold : Object = false, 
									italic : Object = false, underline : Object = false, url : String = null, target : String = null, align : String = null, leftMargin : Object = null, rightMargin : Object = null, indent : Object = null, leading : Object = null
									)
		{
			super(font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
			_embedFont = embedFont;
			_colors = colors;
			_sharpness = sharpness;
			_thickness = thickness;
			_border = border;
			_borderColor = borderColor;
			_background = background;
			_backgroundColor = backgroundColor;
		}
		/** clone */
		public function clone() : TextStyle
		{
			return new TextStyle(embedFonts, colors, sharpness, thickness, border, borderColor, background, backgroundColor, font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
		}
		/** embed font 사용여부 */
		public function get embedFonts() : Boolean
		{
			return _embedFont;
		}
		public function set embedFonts(embedFont : Boolean) : void
		{
			_embedFont = embedFont;
		}
		/** interactive colors */
		public function get colors() : Object
		{
			return _colors;
		}
		public function set colors(colors : Object) : void
		{
			_colors = colors;
		}
		/** 텍스트 필드의 글리프 가장자리 선명도 -400 ~ 400 */
		public function get sharpness() : Number
		{
			return _sharpness;
		}
		public function set sharpness(sharpness : Number) : void
		{
			_sharpness = sharpness;
		}
		/** 텍스트 필드의 글리프 가장자리 두께 -200 ~ 200 */
		public function get thickness() : Number
		{
			return _thickness;
		}
		public function set thickness(thickness : Number) : void
		{
			_thickness = thickness;
		}
		/** border */
		public function get border() : Boolean
		{
			return _border;
		}
		public function set border(border : Boolean) : void
		{
			_border = border;
		}
		/** border color */
		public function get borderColor() : uint
		{
			return _borderColor;
		}
		public function set borderColor(borderColor : uint) : void
		{
			_borderColor = borderColor;
		}
		/** background */
		public function get background() : Boolean
		{
			return _background;
		}
		public function set background(background : Boolean) : void
		{
			_background = background;
		}
		/** background color */
		public function get backgroundColor() : uint
		{
			return _backgroundColor;
		}
		public function set backgroundColor(backgroundColor : uint) : void
		{
			_backgroundColor = backgroundColor;
		}
	}
}
