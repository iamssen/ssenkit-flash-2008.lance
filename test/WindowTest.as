package  
{
	import skin.CloseButton;	
	import skin.WindowBitmap;	
	import skin.WindowBitmap2;	

	import lance.debug.TestButton;	
	import lance.core.skinObject.SkinMode;	
	import lance.core.events.LanceEvent;	
	import lance.component.BitmapSplitButton;	
	import lance.core.skinObject.BitmapSplitSet;	

	import flash.geom.Rectangle;	

	import lance.core.text.TextStyle;	
	import lance.core.skinObject.SkinLabel;	
	import lance.core.contents.StringContent;	
	import lance.component.parts.Window;	
	import lance.component.skin.WindowSkin;	

	import flash.display.BitmapData;	
	import flash.net.URLRequest;	
	import flash.events.Event;	
	import flash.display.Loader;	
	import flash.display.Sprite;

	/**
	 * @author SSen
	 */
	public class WindowTest extends Sprite 
	{
		private var _bmd1 : BitmapData;
		private var _bmd2 : BitmapData;
		private var win : Window;

		public function WindowTest()
		{
			_bmd1 = new WindowBitmap(0, 0);
			_bmd2 = new WindowBitmap2(0, 0);
			var skin : WindowSkin = new WindowSkin(_bmd2, new BitmapSplitSet(new CloseButton(0, 0), 9, 9, BitmapSplitButton.NAME_SET));
			
			var colors : Object = new Object();
			colors[SkinMode.DEFAULT] = 0xffffff;
			colors[SkinMode.DISABLE] = 0xeeeeee;
			var sc : StringContent = new StringContent("<font size='20' color='#ff0000'>되나<br> 한 번</font> 볼까요? <b>하하하하하하하하하하하하하하하하하하하하하하하하</b>하하...<br>aaaaaaaaaaaab<br>aaaaaaaaaaaaaaaaaaaaaaaaaaaaa", true);
			var sl : SkinLabel = new SkinLabel("window 테스트 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", new TextStyle(false, colors, 0, 0, false, 0, false, 0, "돋움", 11, 0xffffff, true));
			win = new Window(sc, skin, sl, null, 200, true, false);
			trace(win.width);
			win.x = win.y = 10;
			addChild(win);
			
			graphics.beginFill(0xeeeeee);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			win.addEventListener(LanceEvent.CLOSE, closed);
			
			var t1 : TestButton = new TestButton("enable toggle", enableToggle);
			t1.x = 10;
			t1.y = 180;
			addChild(t1);
		}
		private function enableToggle() : void
		{
			win.enabled = (win.enabled) ? false : true;
		}
		private function closed(event : LanceEvent) : void
		{
			trace("close");
		}
	}
}
