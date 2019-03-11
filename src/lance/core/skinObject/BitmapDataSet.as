package lance.core.skinObject 
{
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import lance.core.graphics.BitmapEx;		
	/**
	 * @author SSen
	 */
	public dynamic class BitmapDataSet extends Dictionary
	{
		public function BitmapDataSet(splitSet : BitmapSplitSet)
		{
			var name : String;
			var bmd : BitmapData;
			var cnt : int = 0;
			for each (name in splitSet.names) {
				bmd = BitmapEx.getSlice(splitSet.bitmapData, splitSet.width * cnt, 0, splitSet.width, splitSet.height);
				this[name] = bmd;
				cnt++;
			}
		}
	}
}
