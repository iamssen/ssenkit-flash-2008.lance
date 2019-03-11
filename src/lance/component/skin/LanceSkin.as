package lance.component.skin 
{
	import flash.geom.Rectangle;	

	import lance.core.geom.InnerGrid;	
	import lance.core.geom.GeomEx;	

	import flash.display.BitmapData;
	import flash.utils.getQualifiedClassName;	
	/**
	 * BitmapSkin 원시형
	 * @author SSen
	 */
	public class LanceSkin 
	{
		/** skin 의 bitmapData */
		protected var _skinBitmap : BitmapData;

		public function LanceSkin(skinBitmap : BitmapData)
		{
			_skinBitmap = skinBitmap;
		}
		/** 초기화 설정 */
		protected function init() : void
		{
		}
		/** bitmapData 에서 color 를 뽑아온다 */
		protected function getColor(x : int, y : int) : uint
		{
			return _skinBitmap.getPixel(x, y);
		}
		/** bitmapData 에서 innerGrid 를 뽑아온다 */
		protected function getInnerGridFromBitmapData(source : Rectangle) : InnerGrid
		{
			var bmdWidth : int = source.width;
			var bmdHeight : int = source.height;
			// var bmdMiddle : int = source.height >> 1;
			var bmdCenter : int = source.width >> 1;
			
			var l : int;
			var r : int;
			var t : int;
			var b : int;
			
			var f : int;
			var color : uint = 0xffffff;
			// 080905 : 중앙점이 흔들릴 가능성이 없는 y line 먼저 체크한 뒤, t 값으로 x line 을 체크한다.
			for (f = 1;f <= bmdHeight; f++) {
				if (_skinBitmap.getPixel(bmdCenter + source.x, f + source.y) >= color) {
					t = f;
					break;
				}
			}
			for (f = bmdHeight;f >= 1; f--) {
				if (_skinBitmap.getPixel(bmdCenter + source.x, f + source.y) >= color) {
					b = bmdHeight - f - 1;
					break;
				}
			}
			for (f = 1;f <= bmdWidth; f++) {
				if (_skinBitmap.getPixel(f + source.x, t + source.y) >= color) {
					l = f;
					break;
				}
			}
			for (f = bmdWidth;f >= 1; f--) {
				if (_skinBitmap.getPixel(f + source.x, t + source.y) >= color) {
					r = bmdWidth - f - 1;
					break;
				}
			}
			
			return new InnerGrid(l, r, t, b, bmdWidth, bmdHeight);
		}
		/** bitmapData 에서 scale9Grid 를 뽑아온다 */
		protected function get9GridFromBitmapData(source : Rectangle) : Rectangle
		{
			return GeomEx.innerTo9Grid(getInnerGridFromBitmapData(source));
		}

		/** skin 의 classname 을 리턴한다 */
		public function get skinClassName() : String
		{
			var skinName : String = getQualifiedClassName(this);
			return skinName.substring(22, skinName.length);
		}
	}
}
