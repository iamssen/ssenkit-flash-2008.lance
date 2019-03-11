package  
{
	import lance.component.ScrollBar;
	import lance.component.events.ScrollEvent;
	import lance.component.parts.ScrollContainer;
	import lance.component.parts.ScrollPane;
	import lance.component.properties.DirectionMode;
	import lance.component.properties.TrackMode;
	import lance.component.skin.ScrollBarSkin;
	import lance.core.contents.DisplayObjectContent;
	import lance.core.graphics.LanceSprite;
	import lance.core.number.MathEx;
	import lance.core.skinObject.BitmapSplitSet;
	import lance.core.skinObject.SkinMode;
	import lance.debug.TestButton;
	
	import skin.ScrollArrowDown;
	import skin.ScrollArrowUp;
	import skin.ScrollTrackBitmap;
	import skin.ScrollTrackBitmap2;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;		
	/**
	 * @author SSen
	 */
	public class ScrollBarTest extends LanceSprite 
	{
		private var skin1 : ScrollBarSkin;
		private var skin2 : ScrollBarSkin;
		private var sbV : ScrollBar;
		private var sbH : ScrollBar;
		private var sc : ScrollContainer;
		private var sp : ScrollPane;

		public function ScrollBarTest()
		{
			super();
			
			sc = new ScrollContainer(getDisplayObject(), 300, 200);
			sc.x = sc.y = 10;
			addChild(sc);
			
			var upSet : BitmapSplitSet = new BitmapSplitSet(new ScrollArrowUp(0, 0), 15, 16, [SkinMode.DEFAULT, SkinMode.OVER, SkinMode.ACTION, SkinMode.DISABLE]);
			var downSet : BitmapSplitSet = new BitmapSplitSet(new ScrollArrowDown(0, 0), 15, 16, [SkinMode.DEFAULT, SkinMode.OVER, SkinMode.ACTION, SkinMode.DISABLE]);
			skin1 = new ScrollBarSkin(new ScrollTrackBitmap(0, 0), upSet, downSet);
			skin2 = new ScrollBarSkin(new ScrollTrackBitmap2(0, 0), upSet, downSet);
			sbV = new ScrollBar(skin1, sc, 15, 200, DirectionMode.VERTICAL, 0, 10, TrackMode.POINT, 100, 1000);
			sbH = new ScrollBar(skin1, sc, 300, 15, DirectionMode.HORIZONTAL, 0, 10, TrackMode.PAGE, 0, 50);
			sbV.addEventListener(ScrollEvent.SCROLL, scroll);
			sbV.x = 310;
			sbV.y = 10;
			sbH.x = 10;
			sbH.y = 210;
			addChildren(sbV, sbH);
			
			var t1 : TestButton = new TestButton("skin Change", skinChange);
			t1.position = sbH.nextPositionBr(15);
			var t2 : TestButton = new TestButton("width Change", widthChange);
			t2.position = t1.endPosition;
			var t3 : TestButton = new TestButton("enable toggle", enableToggle);
			t3.position = t2.endPosition;
			var t4 : TestButton = new TestButton("container change", containerChange);
			t4.position = t1.endPositionBr;
			var t5 : TestButton = new TestButton("min, max value change", minmaxChange);
			t5.position = t4.endPosition;
			var t6 : TestButton = new TestButton("setSec05", setSec);
			t6.position = t5.endPosition;
			addChildren(t1, t2, t3, t4, t5, t6);
			
			sp = new ScrollPane(skin1, DirectionMode.VERTICAL_AND_HORIZONTAL, new DisplayObjectContent(getDisplayObject()), 300, 200);
			sp.x = 500;
			sp.y = 10;
			addChildren(sp);
		}
		private function setSec() : void
		{
			sbH.sec = 0.5;
			sbV.sec = 0.5;
		}
		private function minmaxChange() : void
		{
			sbH.minValue = 1000;
			sbH.maxValue = 5000;
			sbV.minValue = 0;
			sbV.maxValue = -300;
		}
		private function containerChange() : void
		{
			sc.content = getDisplayObject();
		}
		private function scroll(event : ScrollEvent) : void
		{
			var s : ScrollBar = ScrollBar(event.target);
			trace(event.secX, event.secY, s.value, s.minValue, s.maxValue);
		}
		private function enableToggle() : void
		{
			var bool : Boolean = (sbV.enabled) ? false : true;
			sbH.enabled = bool;
			sbV.enabled = bool;
		}
		private function widthChange() : void
		{
			sbH.width = (sbH.width == 300) ? 200 : 300;
		}
		private function skinChange() : void
		{
			sbV.skin = (sbV.skin == skin1) ? skin2 : skin1;
		}
		private function getDisplayObject() : DisplayObject
		{
			var s : Shape = new Shape();
			var g : Graphics = s.graphics;
			var w : int = MathEx.rand(600, 4500);
			var h : int = MathEx.rand(600, 4500);
			g.beginFill(MathEx.rand(0x000000, 0xffffff));
			g.drawRect(0, 0, w, h);
			g.endFill();
			g.beginFill(0xC5D5FC);
			g.drawRect(0, 0, w, 10);
			g.drawRect(0, 10, 10, h - 20);
			g.drawRect(w - 10, 10, 10, h - 20);
			g.drawRect(0, h - 10, w, 10);
			g.endFill();
			
			return s;
		}
	}
}
