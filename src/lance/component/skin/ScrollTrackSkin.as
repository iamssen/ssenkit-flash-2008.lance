package lance.component.skin 
{
	import lance.component.properties.DirectionMode;	
	import lance.core.graphics.GridBitmap;	
	import lance.core.skinObject.SkinMode;	
	import lance.core.graphics.BitmapEx;	
	import lance.core.geom.InnerGrid;	

	import flash.geom.Rectangle;	

	import lance.core.skinObject.SkinGridSprite;	

	import flash.display.BitmapData;	

	import lance.component.skin.LanceSkin;

	/**
	 * ScrollTrackSkin
	 * @author SSen
	 */
	public class ScrollTrackSkin extends LanceSkin 
	{
		/** geom */
		private var _thumb_9grid : Rectangle;
		private var _thumb_innerGrid : InnerGrid;
		private var _track_9grid : Rectangle;
		private var _track_innerGrid : InnerGrid;
		/** bitmapDatas */
		private var _thumb_bg_default : BitmapData;
		private var _thumb_bg_over : BitmapData;
		private var _thumb_bg_action : BitmapData;
		private var _thumb_bg_disable : BitmapData;
		private var _track_bg_default : BitmapData;
		private var _track_bg_action : BitmapData;
		private var _track_bg_disable : BitmapData;
		/** bitmapDatas horizontal */
		private var _thumb_bg_default_h : BitmapData;
		private var _thumb_bg_over_h : BitmapData;
		private var _thumb_bg_action_h : BitmapData;
		private var _thumb_bg_disable_h : BitmapData;
		private var _track_bg_default_h : BitmapData;
		private var _track_bg_action_h : BitmapData;
		private var _track_bg_disable_h : BitmapData;
		/** info */
		private var _trackSkin : Boolean;

		public function ScrollTrackSkin(skinBitmap : BitmapData, trackSkin : Boolean = false)
		{
			super(skinBitmap);
			_trackSkin = trackSkin;
			init();
		}
		/** @private */
		override protected function init() : void
		{
			_thumb_9grid = get9GridFromBitmapData(new Rectangle(0, 0, 50, 50));
			_thumb_innerGrid = getInnerGridFromBitmapData(new Rectangle(50, 0, 50, 50));
			_thumb_bg_default = BitmapEx.getSlice(_skinBitmap, 100, 0, 50, 50);
			_thumb_bg_over = BitmapEx.getSlice(_skinBitmap, 150, 0, 50, 50);
			_thumb_bg_action = BitmapEx.getSlice(_skinBitmap, 200, 0, 50, 50);
			_thumb_bg_disable = BitmapEx.getSlice(_skinBitmap, 250, 0, 50, 50);
			if (_trackSkin) {
				_track_9grid = get9GridFromBitmapData(new Rectangle(0, 50, 50, 50));
				_track_innerGrid = getInnerGridFromBitmapData(new Rectangle(50, 50, 50, 50));
				_track_bg_default = BitmapEx.getSlice(_skinBitmap, 100, 50, 50, 50);
				_track_bg_action = BitmapEx.getSlice(_skinBitmap, 150, 50, 50, 50);
				_track_bg_disable = BitmapEx.getSlice(_skinBitmap, 200, 50, 50, 50);
			}
		}
		/** scroll thumb */
		public function scroll_thumb(direction : String = "vertical") : SkinGridSprite
		{
			var bmdDefault : BitmapData;
			var bmdOver : BitmapData;
			var bmdAction : BitmapData;
			var bmdDisable : BitmapData;
			if (direction == DirectionMode.VERTICAL) {
				bmdDefault = _thumb_bg_default;
				bmdOver = _thumb_bg_over;
				bmdAction = _thumb_bg_action;
				bmdDisable = _thumb_bg_disable;
			} else {
				if (_thumb_bg_default_h == null) {
					_thumb_bg_default_h = BitmapEx.rotate(_thumb_bg_default, BitmapEx.ROTATE_N90);
					_thumb_bg_default_h = BitmapEx.flip(_thumb_bg_default_h, BitmapEx.FLIP_VERTICAL);
					_thumb_bg_over_h = BitmapEx.rotate(_thumb_bg_over, BitmapEx.ROTATE_N90);
					_thumb_bg_over_h = BitmapEx.flip(_thumb_bg_over_h, BitmapEx.FLIP_VERTICAL);
					_thumb_bg_action_h = BitmapEx.rotate(_thumb_bg_action, BitmapEx.ROTATE_N90);
					_thumb_bg_action_h = BitmapEx.flip(_thumb_bg_action_h, BitmapEx.FLIP_VERTICAL);
					_thumb_bg_disable_h = BitmapEx.rotate(_thumb_bg_disable, BitmapEx.ROTATE_N90);
					_thumb_bg_disable_h = BitmapEx.flip(_thumb_bg_disable_h, BitmapEx.FLIP_VERTICAL);
				}
				
				bmdDefault = _thumb_bg_default_h;
				bmdOver = _thumb_bg_over_h;
				bmdAction = _thumb_bg_action_h;
				bmdDisable = _thumb_bg_disable_h;
			}
			
			var skins : Array = new Array();
			skins[SkinMode.DEFAULT] = new GridBitmap(bmdDefault, 100, 100, _thumb_9grid, _thumb_innerGrid);
			skins[SkinMode.OVER] = new GridBitmap(bmdOver, 100, 100, _thumb_9grid, _thumb_innerGrid);
			skins[SkinMode.ACTION] = new GridBitmap(bmdAction, 100, 100, _thumb_9grid, _thumb_innerGrid);
			skins[SkinMode.DISABLE] = new GridBitmap(bmdDisable, 100, 100, _thumb_9grid, _thumb_innerGrid);
			
			return new SkinGridSprite(skins);
		}
		/** scroll track */
		public function scroll_track(direction : String = "vertical") : SkinGridSprite
		{
			if (_trackSkin) {
				var bmdDefault : BitmapData;
				var bmdAction : BitmapData;
				var bmdDisable : BitmapData;
				if (direction == DirectionMode.VERTICAL) {
					bmdDefault = _track_bg_default;
					bmdAction = _track_bg_action;
					bmdDisable = _track_bg_disable;
				} else {
					if (_track_bg_default_h == null) {
						_track_bg_default_h = BitmapEx.rotate(_track_bg_default, BitmapEx.ROTATE_N90);
						_track_bg_default_h = BitmapEx.flip(_track_bg_default_h, BitmapEx.FLIP_VERTICAL);
						_track_bg_action_h = BitmapEx.rotate(_track_bg_action, BitmapEx.ROTATE_N90);
						_track_bg_action_h = BitmapEx.flip(_track_bg_action_h, BitmapEx.FLIP_VERTICAL);
						_track_bg_disable_h = BitmapEx.rotate(_track_bg_disable, BitmapEx.ROTATE_N90);
						_track_bg_disable_h = BitmapEx.flip(_track_bg_disable_h, BitmapEx.FLIP_VERTICAL);
					}
					
					bmdDefault = _track_bg_default_h;
					bmdAction = _track_bg_action_h;
					bmdDisable = _track_bg_disable_h;
				}
				
				var skins : Array = new Array();
				skins[SkinMode.DEFAULT] = new GridBitmap(bmdDefault, 100, 100, _track_9grid, _track_innerGrid);
				skins[SkinMode.ACTION] = new GridBitmap(bmdAction, 100, 100, _track_9grid, _track_innerGrid);
				skins[SkinMode.DISABLE] = new GridBitmap(bmdDisable, 100, 100, _track_9grid, _track_innerGrid);
				return new SkinGridSprite(skins);
			} else {
				return null;
			}
		}
		/** track 에 대한 skin 이 존재하는지 유무 */
		public function get trackSkin() : Boolean
		{
			return _trackSkin;
		}
		/** thumb 의 scale9Grid */
		public function get thumb_9grid() : Rectangle
		{
			return _thumb_9grid;
		}
		/** thumb 의 innerGrid */
		public function get thumb_innerGrid() : InnerGrid
		{
			return _thumb_innerGrid;
		}
		/** track 의 scale9Grid */
		public function get track_9grid() : Rectangle
		{
			if (_trackSkin) {
				return _track_9grid;
			} else {
				return null;
			}
		}
		/** track 의 innerGrid */
		public function get track_innerGrid() : InnerGrid
		{
			if (_trackSkin) {
				return _track_innerGrid;
			} else {
				return null;
			}
		}
	}
}
