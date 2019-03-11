package lance.core.skinObject 
{
	import lance.core.graphics.BitmapEx;	

	import flash.display.Bitmap;	
	import flash.display.BitmapData;	

	import lance.core.skinObject.SkinSprite;

	/**
	 * 한장의 bitmap 을 잘라서 SkinSprite 를 구성한다
	 * @author SSen
	 */
	public class SkinBitmapSplit extends SkinSprite 
	{
		public function SkinBitmapSplit(splitSet : BitmapSplitSet)
		{
			var skins : Array = new Array();
			var name : String;
			var bmd : BitmapData;
			var cnt : int = 0;
			for each (name in splitSet.names) {
				bmd = BitmapEx.getSlice(splitSet.bitmapData, splitSet.width * cnt, 0, splitSet.width, splitSet.height);
				skins[name] = new Bitmap(bmd, splitSet.pixelSnapping, splitSet.smoothing);
				cnt++;
			}
			super(skins);
		}
	}
}
