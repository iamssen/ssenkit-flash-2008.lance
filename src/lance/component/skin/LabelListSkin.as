package lance.component.skin 
{
	import lance.core.skinObject.SkinSprite;	
	import lance.core.skinObject.SkinMode;	
	
	import flash.display.Graphics;	
	import flash.display.Shape;	
	import flash.display.BitmapData;	

	import lance.component.skin.LanceSkin;
	/**
	 * @author SSen
	 */
	public class LabelListSkin extends LanceSkin 
	{
		private var _list_font_default : Array;
		private var _list_font_over : Array;
		private var _list_font_action : Array;
		private var _list_font_disable : Array;
		private var _list_bg_default : Array;
		private var _list_bg_over : Array;
		private var _list_bg_action : Array;
		private var _list_bg_disable : Array;
		private var _length : int;

		public function LabelListSkin(...colors)
		{
			super(null);
			_list_font_default = new Array();
			_list_font_over = new Array();
			_list_font_action = new Array();
			_list_font_disable = new Array();
			_list_bg_default = new Array();
			_list_bg_over = new Array();
			_list_bg_action = new Array();
			_list_bg_disable = new Array();
			_length = 0;
			
			if (colors[0] is BitmapData) {
				// TODO 비트맵 파일을 읽어서 가져오기
			} else if (colors[0] is Array) {
				var arr : Array;
				for each (arr in colors) {
					_list_font_default.push(arr[0]);
					_list_font_over.push(arr[1]);
					_list_font_action.push(arr[2]);
					_list_font_disable.push(arr[3]);
					_list_bg_default.push(arr[4]);
					_list_bg_over.push(arr[5]);
					_list_bg_action.push(arr[6]);
					_list_bg_disable.push(arr[7]);
					_length++;
				}
			}
		}
		public function fontColors(count : int) : Object
		{
			count = count % _length;
			var colors : Object = new Object();
			colors[SkinMode.DEFAULT] = _list_font_default[count];
			colors[SkinMode.OVER] = _list_font_over[count];
			colors[SkinMode.ACTION] = _list_font_action[count];
			colors[SkinMode.DISABLE] = _list_font_disable[count];
			return colors;
		}
		public function bgs(count : int) : SkinSprite
		{
			count = count % _length;
			var bgs : Array = new Array();
			bgs[SkinMode.DEFAULT] = getShape(_list_bg_default[count]);
			bgs[SkinMode.OVER] = getShape(_list_bg_over[count]);
			bgs[SkinMode.ACTION] = getShape(_list_bg_action[count]);
			bgs[SkinMode.DISABLE] = getShape(_list_bg_disable[count]);
			return new SkinSprite(bgs);
		}
		private function getShape(color : uint) : Shape
		{
			var s : Shape = new Shape();
			var g : Graphics = s.graphics;
			g.beginFill(color);
			g.drawRect(0, 0, 100, 100);
			g.endFill();
			return s;
		}
		public function get length() : int
		{
			return _length;
		}
	}
}
