package lance.core.skinObject 
{
	import flash.display.BitmapData;	
	/**
	 * BitmapSplit 에 필요한 데이터들을 패키징 할 수 있는 셋트 파일
	 * @author SSen
	 */
	public class BitmapSplitSet 
	{
		private var _bitmapData : BitmapData;
		private var _width : int;
		private var _height : int;
		private var _names : Array;
		private var _pixelSnapping : String;
		private var _smoothing : Boolean;

		public function BitmapSplitSet(bitmapData : BitmapData, width : int, height : int, names : Array, pixelSnapping : String = "auto", smoothing : Boolean = false) 
		{
			_bitmapData = bitmapData;
			_width = width;
			_height = height;
			_names = names;
			_pixelSnapping = pixelSnapping;
			_smoothing = smoothing;
		}
		/** 이미지 */
		public function get bitmapData() : BitmapData
		{
			return _bitmapData;
		}
		/** 가로사이즈 */
		public function get width() : int
		{
			return _width;
		}
		/** 세로사이즈 */
		public function get height() : int
		{
			return _height;
		}
		/** 이름들 */
		public function get names() : Array
		{
			return _names;
		}
		/** 비트맵 옵션 */
		public function get pixelSnapping() : String
		{
			return _pixelSnapping;
		}
		/** 비트맵 옵션 : 안티앨리어싱 처리 */
		public function get smoothing() : Boolean
		{
			return _smoothing;
		}
	}
}
