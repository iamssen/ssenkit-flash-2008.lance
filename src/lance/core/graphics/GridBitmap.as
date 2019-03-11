package lance.core.graphics  
{
	import lance.core.geom.InnerGrid;	

	import flash.geom.Rectangle;	
	import flash.display.BitmapData; 
	/**
	 * Scale9Grid 기능을 하는 Bitmap
	 * @author SSen
	 */
	public class GridBitmap extends LanceBitmap 
	{
		// scale9grid
		private var _scale9Grid : Rectangle;

		/**
		 * GridBitmap
		 * @param source 소스가 될 BitmapData
		 * @param width width
		 * @param height height
		 * @param scale9Grid Scale9Grid
		 * @param thumbGrid Thumbnail 의 위치 Grid
		 * @param tl Thumnail bitmapData - top left
		 * @param tc Thumnail bitmapData - top center
		 * @param tr Thumnail bitmapData - top right
		 * @param ml Thumnail bitmapData - middle left
		 * @param mc Thumnail bitmapData - middle center
		 * @param mr Thumnail bitmapData - middle right
		 * @param bl Thumnail bitmapData - bottom left
		 * @param bc Thumnail bitmapData - bottom center
		 * @param br Thumnail bitmapData - bottom right
		 */
		public function GridBitmap(source : BitmapData,
								width : int, 
								height : int,
								scale9Grid : Rectangle = null, 
								thumbGrid : InnerGrid = null,  
								tl : BitmapData = null, 
								tc : BitmapData = null, 
								tr : BitmapData = null, 
								ml : BitmapData = null, 
								mc : BitmapData = null, 
								mr : BitmapData = null, 
								bl : BitmapData = null, 
								bc : BitmapData = null, 
								br : BitmapData = null
								)
		{
			_scale9Grid = (scale9Grid == null) ? new Rectangle(0, 0, width, height) : scale9Grid;
			super(source, width, height, thumbGrid, tl, tc, tr, ml, mc, mr, bl, bc, br);
		}
		/** 같은 설정의 GridBitmap 을 복사한다 */
		public function clone() : GridBitmap
		{
			return new GridBitmap(_source, _width, _height, _scale9Grid, _thumbGrid, _tl, _tc, _tr, _ml, _mc, _mr, _bl, _bc, _br);
		}
		/** Scale9Grid */
		override public function get scale9Grid() : Rectangle
		{
			return _scale9Grid;
		}
		override public function set scale9Grid(grid : Rectangle) : void
		{
			_scale9Grid = grid;
			draw();
		}
		/** @private */
		override protected function draw() : void
		{
			clear();
			_canvas.draw(BitmapEx.gridBitmapDraw(_source, _scale9Grid, _width, _height));
			super.draw();
		}
	}
}
