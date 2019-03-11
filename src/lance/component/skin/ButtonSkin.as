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
	 * ButtonSkin
	 * @author SSen
	 */
	public class ButtonSkin extends LanceSkin 
	{
		private var _button_9grid : Rectangle;
		private var _button_innerGrid : InnerGrid;
		private var _button_fontColor_default : uint;
		private var _button_fontColor_over : uint;
		private var _button_fontColor_action : uint;
		private var _button_fontColor_disable : uint;
		private var _button_bg_default : BitmapData;
		private var _button_bg_over : BitmapData;
		private var _button_bg_action : BitmapData;
		private var _button_bg_disable : BitmapData;

		public function ButtonSkin(skinBitmap : BitmapData)
		{
			super(skinBitmap);
			init();
		}
		/** @private */
		override protected function init() : void
		{
			_button_9grid = get9GridFromBitmapData(new Rectangle(0, 0, 50, 50));
			_button_innerGrid = getInnerGridFromBitmapData(new Rectangle(50, 0, 50, 50));
			_button_fontColor_default = getColor(102, 52);
			_button_fontColor_over = getColor(152, 52);
			_button_fontColor_action = getColor(202, 52);
			_button_fontColor_disable = getColor(252, 52);
			_button_bg_default = BitmapEx.getSlice(_skinBitmap, 100, 0, 50, 50);
			_button_bg_over = BitmapEx.getSlice(_skinBitmap, 150, 0, 50, 50);
			_button_bg_action = BitmapEx.getSlice(_skinBitmap, 200, 0, 50, 50);
			_button_bg_disable = BitmapEx.getSlice(_skinBitmap, 250, 0, 50, 50);
		}
		/** button bg */
		public function button_bg() : SkinGridSprite
		{
			var skins : Array = new Array();
			skins[SkinMode.DEFAULT] = new GridBitmap(_button_bg_default, 100, 100, _button_9grid);
			skins[SkinMode.OVER] = new GridBitmap(_button_bg_over, 100, 100, _button_9grid);
			skins[SkinMode.ACTION] = new GridBitmap(_button_bg_action, 100, 100, _button_9grid);
			skins[SkinMode.DISABLE] = new GridBitmap(_button_bg_disable, 100, 100, _button_9grid);
			return new SkinGridSprite(skins);
		}
		/** button 의 scale9Grid */
		public function get button_9grid() : Rectangle
		{
			return _button_9grid;
		}
		/** button 의 innerGrid */
		public function get button_innerGrid() : InnerGrid
		{
			return _button_innerGrid;
		}
		public function get button_fontColors() : Object
		{
			var colors : Object = new Object();
			colors[SkinMode.DEFAULT] = _button_fontColor_default;
			colors[SkinMode.OVER] = _button_fontColor_over;
			colors[SkinMode.ACTION] = _button_fontColor_action;
			colors[SkinMode.DISABLE] = _button_fontColor_disable;
			return colors;
		}
	}
}
