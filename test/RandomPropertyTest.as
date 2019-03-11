package  
{
	import fl.motion.easing.Quadratic;	

	import lance.core.graphics.ColorEx;	
	import lance.debug.TestButton;	
	import lance.core.array.RandomProperty;	

	import flash.display.Sprite;
	/**
	 * @author SSen
	 */
	public class RandomPropertyTest extends Sprite 
	{
		private var rp : RandomProperty;

		public function RandomPropertyTest()
		{
			rp = new RandomProperty("a", "b", "c", "d");
			
			var t1 : TestButton = new TestButton("get Random", getRandom);
			t1.x = t1.y = 10;
			addChild(t1);
			
			var color : Vector.<uint> = ColorEx.gradate(0xffffff, 0x000000, 10, Quadratic.easeIn);
			for each (var a:uint in color) {
				trace(a.toString(16));
			}
		}
		private function getRandom() : void
		{
			trace(rp.random(true), rp.excludeList);
		}
	}
}
