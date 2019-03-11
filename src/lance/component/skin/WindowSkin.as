package lance.component.skin 
{
	import lance.core.geom.InnerGrid;	
	import lance.core.skinObject.SkinGridSprite;	
	import lance.core.graphics.GridBitmap;	
	import lance.core.skinObject.SkinMode;	
	import lance.core.graphics.BitmapEx;	
	
	import flash.geom.Rectangle;	
	
	import lance.core.skinObject.BitmapSplitSet;	

	import flash.display.BitmapData;
	/**
	 * Window Skin
	 * @author SSen
	 */
	public class WindowSkin extends PanelSkin 
	{
		protected var _panel_bg_disable : BitmapData;
		protected var _panel_titleGrid : InnerGrid;

		public function WindowSkin(skinBitmap : BitmapData, closeButton : BitmapSplitSet = null)
		{
			super(skinBitmap, closeButton);
		}
		/** @private */
		override protected function init() : void
		{
			_panel_9grid = get9GridFromBitmapData(new Rectangle(0, 0, 50, 50));
			_panel_innerGrid = getInnerGridFromBitmapData(new Rectangle(50, 0, 50, 50));
			_panel_titleGrid = getInnerGridFromBitmapData(new Rectangle(100, 0, 50, 50));
			_content_fontColor = getColor(152, 52);
			_panel_bg = BitmapEx.getSlice(_skinBitmap, 150, 0, 50, 50);
			_panel_bg_disable = BitmapEx.getSlice(_skinBitmap, 200, 0, 50, 50);
		}
		/** @private */
		override public function panel_bg() : SkinGridSprite
		{
			var skins : Array = new Array();
			skins[SkinMode.DEFAULT] = new GridBitmap(_panel_bg, 100, 100, _panel_9grid);
			skins[SkinMode.DISABLE] = new GridBitmap(_panel_bg_disable, 100, 100, _panel_9grid);
			return new SkinGridSprite(skins);
		}
		/** title 과 window 버튼들이 들어갈 위치 그리드 */
		public function get panel_titleGrid() : InnerGrid
		{
			return _panel_titleGrid;
		}
	}
}
