package lance.component.skin 
{
	import lance.component.parts.AbstButton;	
	import lance.component.BitmapSplitButton;	
	import lance.core.skinObject.BitmapSplitSet;	
	import lance.core.skinObject.SkinGridSprite;	
	import lance.core.graphics.GridBitmap;	
	import lance.core.skinObject.SkinMode;	
	import lance.core.graphics.BitmapEx;	
	import lance.core.geom.InnerGrid;	

	import flash.geom.Rectangle;	
	import flash.display.BitmapData;	

	import lance.component.skin.LanceSkin;
	/**
	 * Panel 모듈 그룹의 기본 스킨
	 * @author SSen
	 */
	public class PanelSkin extends LanceSkin 
	{
		protected var _panel_9grid : Rectangle;
		protected var _panel_innerGrid : InnerGrid;
		protected var _content_fontColor : uint;
		protected var _panel_bg : BitmapData;
		protected var _panel_closeButton : BitmapSplitSet;

		public function PanelSkin(skinBitmap : BitmapData, closeButton : BitmapSplitSet = null)
		{
			super(skinBitmap);
			_panel_closeButton = closeButton;
			init();
		}
		/** @private */
		override protected function init() : void
		{
			_panel_9grid = get9GridFromBitmapData(new Rectangle(0, 0, 50, 50));
			_panel_innerGrid = getInnerGridFromBitmapData(new Rectangle(50, 0, 50, 50));
			_content_fontColor = getColor(102, 52);
			_panel_bg = BitmapEx.getSlice(_skinBitmap, 100, 0, 50, 50);
		}
		/** panel bg */
		public function panel_bg() : SkinGridSprite
		{
			var skins : Array = new Array();
			skins[SkinMode.DEFAULT] = new GridBitmap(_panel_bg, 100, 100, _panel_9grid);
			return new SkinGridSprite(skins); 
		}
		/** panel close button */
		public function panel_closeButton() : AbstButton
		{
			return new BitmapSplitButton(_panel_closeButton);
		}
		/** panel 의 scale9Grid */
		public function get panel_9grid() : Rectangle
		{
			return _panel_9grid;
		}
		/** panel 의 innerGrid */
		public function get panel_innerGrid() : InnerGrid
		{
			return _panel_innerGrid;
		}
		/** content 의 fontcolor */
		public function get content_fontColor() : uint
		{
			return _content_fontColor;
		}
		/** 현재 스킨에 closeButton 스킨이 있는지 확인 */
		public function get isCloseButton() : Boolean
		{
			return (_panel_closeButton != null) ? true : false;
		}
	}
}
