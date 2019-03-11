package  
{
	import lance.core.array.Values;	
	import lance.core.graphics.LanceSprite;

	/**
	 * Description
	 * @author SSen
	 */
	public class ValuesTest extends LanceSprite 
	{
		private var v : Values;

		public function ValuesTest()
		{
			super();
			
			v = new Values();
			v.abc = 123;
			v.bbc = "aac";
			v.ccc = "34zz";
			//trace(v.abc, v._names);
			delete v.abc;
			//trace(v.abc, v._names);
			for (var xx:String in v) {
				trace("name :", xx, "value :", v[xx]);
			}
			trace("=====================");
			for each (var yy:* in v) {
				trace(yy);
			}
			
			
			var arr : Array = ["ccc", "ddd", "aaa", "bbb"];
			//trace(arr);
			arr.sort();
			//trace(arr);
		}
	}
}
