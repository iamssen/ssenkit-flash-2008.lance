package lance.component.skin 
{
	import lance.component.properties.DirectionMode;	
	import lance.component.BitmapSplitButton;	
	import lance.component.parts.AbstButton;	
	import lance.core.skinObject.BitmapSplitSet;	

	import flash.display.BitmapData;	

	import lance.component.skin.ScrollTrackSkin;
	/**
	 * ScrollBar Skin
	 * @author SSen
	 */
	public class ScrollBarSkin extends ScrollTrackSkin 
	{
		private var _moveUp : BitmapSplitSet;
		private var _moveDown : BitmapSplitSet;
		private var _pageUp : BitmapSplitSet;
		private var _pageDown : BitmapSplitSet;
		private var _moveUp_h : BitmapSplitSet;
		private var _moveDown_h : BitmapSplitSet;
		private var _pageUp_h : BitmapSplitSet;
		private var _pageDown_h : BitmapSplitSet;

		public function ScrollBarSkin(skinBitmap : BitmapData, 
										moveUp : BitmapSplitSet = null, 
										moveDown : BitmapSplitSet = null, 
										pageUp : BitmapSplitSet = null, 
										pageDown : BitmapSplitSet = null,
										moveUp_h : BitmapSplitSet = null, 
										moveDown_h : BitmapSplitSet = null, 
										pageUp_h : BitmapSplitSet = null, 
										pageDown_h : BitmapSplitSet = null)
		{
			super(skinBitmap, true);
			
			_moveUp = moveUp;
			_moveDown = moveDown;
			_pageUp = pageUp;
			_pageDown = pageDown;
			_moveUp_h = moveUp_h;
			_moveDown_h = moveDown_h;
			_pageUp_h = pageUp_h;
			_pageDown_h = pageDown_h;
		}
		/** 누르고 있으면 감소하는 버튼 */
		public function button_moveUp(direction : String = "vertical") : AbstButton
		{
			return getButton(direction, _moveUp, _moveUp_h);
		}
		/** 누르고 있으면 증가하는 버튼 */
		public function button_moveDown(direction : String = "vertical") : AbstButton
		{
			return getButton(direction, _moveDown, _moveDown_h);
		}
		/** 누르면 한페이지 감소하는 버튼 */
		public function button_pageUp(direction : String = "vertical") : AbstButton
		{
			return getButton(direction, _pageUp, _pageUp_h);
		}
		/** 누르면 한페이지 증가하는 버튼 */
		public function button_pageDown(direction : String = "vertical") : AbstButton
		{
			return getButton(direction, _pageDown, _pageDown_h);
		}
		private function getButton(direction : String, setV : BitmapSplitSet, setH : BitmapSplitSet) : AbstButton
		{
			if (setV != null || setH != null) {
				var btn : BitmapSplitButton;
				if (direction == DirectionMode.VERTICAL) {
					if (setV != null) {
						btn = new BitmapSplitButton(setV);
					} else {
						btn = new BitmapSplitButton(setH);
						btn.rotation = 90;
					}
				} else {
					if (setH != null) {
						btn = new BitmapSplitButton(setH);
					} else {
						btn = new BitmapSplitButton(setV);
						btn.rotation = -90;
					}
				}
				return btn;
			} else {
				return null;
			}
		}
	}
}
