package  
{
	import lance.core.skinObject.BitmapSplitSet;	
	import lance.component.properties.ButtonType;	
	
	import flash.events.MouseEvent;	
	
	import lance.component.BitmapSplitButton;	
	
	import flash.display.BitmapData;	
	import flash.net.URLRequest;	
	import flash.events.Event;	
	import flash.display.Loader;	
	import flash.display.Sprite;
	
	/**
	 * Description
	 * @author SSen
	 */
	public class BitmapSplitButtonTest extends Sprite 
	{
		public function BitmapSplitButtonTest()
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.load(new URLRequest("skin/bitmapSplitButton.png"));
		}
		private function complete(event : Event) : void
		{
			var bmd : BitmapData = event.target.loader.content.bitmapData as BitmapData;
			var btn : BitmapSplitButton = new BitmapSplitButton(new BitmapSplitSet(bmd, 21, 21, BitmapSplitButton.NAME_SET), ButtonType.TOGGLE);
			btn.addEventListener(MouseEvent.CLICK, click);
			btn.x = btn.y = 10;
			addChild(btn);
		}
		private function click(event : MouseEvent) : void
		{
			trace(BitmapSplitButton(event.target).selected);
		}
	}
}
