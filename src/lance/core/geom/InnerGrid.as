package lance.core.geom  
{ 
	import flash.geom.Point;	

	/**
	 * Thumbnail 이 위치할 공간좌표에 대한 Grid
	 * @author SSen
	 */
	public class InnerGrid 
	{
		private var _left : int;
		private var _right : int;
		private var _top : int;
		private var _bottom : int;
		private var _gridWidth : int;
		private var _gridHeight : int;
		private var _width : int;
		private var _height : int;

		public function InnerGrid(left : int = 0, right : int = 0, top : int = 0, bottom : int = 0, gridWidth : int = 0, gridHeight : int = 0)
		{
			_left = left;
			_right = right;
			_top = top;
			_bottom = bottom;
			_gridWidth = (gridWidth > 0) ? gridWidth : _left + _right;
			_gridHeight = (gridHeight > 0) ? gridHeight : _top + _bottom;
			_width = _gridWidth - _left - _right;
			_height = _gridHeight - _top - _bottom;
		}
		/** clone */
		public function clone() : InnerGrid
		{
			return new InnerGrid(_left, _right, _top, _bottom, _gridWidth, _gridHeight);
		}
		/** 왼쪽 끝에서의 여백 */
		public function get left() : int
		{
			return _left;
		}
		/** 오른쪽 끝에서의 여백 */ 
		public function get right() : int
		{
			return _right;
		}
		/** 상단에서의 여백 */
		public function get top() : int
		{
			return _top;
		}
		/** 하단에서의 여백 */
		public function get bottom() : int
		{
			return _bottom;
		}
		/** 총 가로 사이즈 */
		public function get gridWidth() : int
		{
			return _gridWidth;
		}
		/** 총 세로 사이즈 */
		public function get gridHeight() : int
		{
			return _gridHeight;
		}
		/** 내용물의 가로 사이즈 */
		public function get width() : int
		{
			return _width;
		}
		/** 내용물의 세로 사이즈 */
		public function get height() : int
		{
			return _height;
		}
		/** 
		 * 썸네일이 위치해야 할 x, y 좌표 point 를 계산한다
		 * @param position 썸네일의 위치
		 * @param boxWidth 썸네일이 위치할 박스의 가로 크기
		 * @param boxHeight 썸네일이 위치할 박스의 세로 크기
		 * @param thumbWidth 썸네일의 가로 크기
		 * @param thumbHeight 썸네일의 세로 크기
		 * @return thumb 이 위치해야할 x, y 좌표 
		 */ 
		public function getPosition(position : String, boxWidth : Number, boxHeight : Number, thumbWidth : int, thumbHeight : int) : Point
		{
			var x : int;
			var y : int;
			
			switch (position) {
				case Position9.TL :
				case Position9.ML :
				case Position9.BL :
					x = left;
					break;
				case Position9.TC :
				case Position9.MC :
				case Position9.BC :
					x = (boxWidth >> 1) - (thumbWidth >> 1);
					break;
				case Position9.TR :
				case Position9.MR :
				case Position9.BR :
					x = boxWidth - right - thumbWidth;
					break;
			}
			switch (position) {
				case Position9.TL :
				case Position9.TC :
				case Position9.TR :
					y = top;
					break;
				case Position9.ML :
				case Position9.MC :
				case Position9.MR :
					y = (boxHeight >> 1) - (thumbHeight >> 1);
					break;
				case Position9.BL :
				case Position9.BC :
				case Position9.BR :
					y = boxHeight - bottom - thumbHeight;
					break;
			}
			
			return new Point(x, y);
		}
		public function toString() : String
		{
			return '(l=' + _left + ', t=' + _top + ', r=' + _right + ', b=' + _bottom + ', gridWidth=' + _gridWidth + ', gridHeight=' + _gridHeight + ')';
		}
	}
}
