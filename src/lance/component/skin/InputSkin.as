package lance.component.skin 
{
	import lance.core.skinObject.SkinMode;
	import lance.core.skinObject.SkinGridSprite;
	import lance.core.graphics.GridBitmap;	
	import lance.core.graphics.BitmapEx;	
	import lance.core.geom.InnerGrid;	

	import flash.geom.Rectangle;	
	import flash.display.BitmapData;	

	import lance.component.skin.LanceSkin;
	/**
	 * InputSkin
	 * @author SSen
	 */
	public class InputSkin extends LanceSkin 
	{
		private var _input_9grid : Rectangle;
		private var _input_innerGrid : InnerGrid;
		private var _input_fontColor_default : uint;
		private var _input_fontColor_action : uint;
		private var _input_fontColor_disable : uint;
		private var _input_bg_default : BitmapData;
		private var _input_bg_action : BitmapData;
		private var _input_bg_disable : BitmapData;

		public function InputSkin(skinBitmap : BitmapData)
		{
			super(skinBitmap);
			init();
		}
		/** @private */
		override protected function init() : void
		{
			_input_9grid = get9GridFromBitmapData(new Rectangle(0, 0, 50, 50));
			_input_innerGrid = getInnerGridFromBitmapData(new Rectangle(50, 0, 50, 50));
			_input_fontColor_default = getColor(102, 52);
			_input_fontColor_action = getColor(152, 52);
			_input_fontColor_disable = getColor(202, 52);
			_input_bg_default = BitmapEx.getSlice(_skinBitmap, 100, 0, 50, 50);
			_input_bg_action = BitmapEx.getSlice(_skinBitmap, 150, 0, 50, 50);
			_input_bg_disable = BitmapEx.getSlice(_skinBitmap, 200, 0, 50, 50);
		}
		/** tooltip bg */
		public function input_bg() : SkinGridSprite
		{
			var skins : Array = new Array();
			skins[SkinMode.DEFAULT] = new GridBitmap(_input_bg_default, 100, 100, _input_9grid);
			skins[SkinMode.ACTION] = new GridBitmap(_input_bg_action, 100, 100, _input_9grid);
			skins[SkinMode.DISABLE] = new GridBitmap(_input_bg_disable, 100, 100, _input_9grid);
			return new SkinGridSprite(skins);
		}
		public function input_colors() : Object
		{
			var colors : Object = new Object();
			colors[SkinMode.DEFAULT] = _input_fontColor_default;
			colors[SkinMode.ACTION] = _input_fontColor_action;
			colors[SkinMode.DISABLE] = _input_fontColor_disable;
			return colors;
		}
		/** tooltip 의 scale9Grid */
		public function get input_9grid() : Rectangle
		{
			return _input_9grid;
		}
		/** tooltip 의 innerGrid */
		public function get input_innerGrid() : InnerGrid
		{
			return _input_innerGrid;
		}
	}
}
