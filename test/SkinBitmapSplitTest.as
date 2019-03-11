package  
{
	import lance.core.skinObject.BitmapSplitSet;	
	import lance.core.array.RandomProperty;	
	
	import flash.events.MouseEvent;	
	
	import lance.core.skinObject.SkinMode;	
	import lance.core.skinObject.SkinBitmapSplit;	
	
	import flash.display.BitmapData;	
	import flash.net.URLRequest;	
	import flash.events.Event;	
	import flash.display.Loader;	
	import flash.display.Sprite;
	/**
	 * @author SSen
	 */
	public class SkinBitmapSplitTest extends Sprite 
	{
		private var rand : RandomProperty; 
		private var bsp : SkinBitmapSplit;

		public function SkinBitmapSplitTest()
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.load(new URLRequest("skin/bitmapSplit.png"));
		}
		private function complete(event : Event) : void
		{
			var bmd : BitmapData = event.target.loader.content.bitmapData;
			bsp = new SkinBitmapSplit(new BitmapSplitSet(bmd, 30, 30, [SkinMode.DEFAULT, SkinMode.OVER, SkinMode.ACTION, SkinMode.DISABLE]));
			bsp.x = bsp.y = 10;
			bsp.addEventListener(MouseEvent.CLICK, random);
			rand = new RandomProperty(SkinMode.DEFAULT, SkinMode.OVER, SkinMode.ACTION, SkinMode.DISABLE);
			addChild(bsp);
		}
		private function random(event : MouseEvent) : void
		{
			var mode : String = rand.random();
			trace(bsp.flag, mode);
			if (bsp.flag != mode) bsp.skinning(mode);
		}
	}
}
