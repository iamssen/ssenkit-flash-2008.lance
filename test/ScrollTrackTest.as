package  
{
	import lance.debug.TestButton;	

	import skin.ScrollTrackBitmap2;	
	import skin.ScrollTrackBitmap;	

	import flash.events.KeyboardEvent;	

	import lance.component.events.ScrollEvent;	
	import lance.component.properties.TrackMode;	
	import lance.component.properties.DirectionMode;	

	import flash.display.DisplayObject;	

	import lance.core.number.MathEx;	

	import flash.display.Graphics;	
	import flash.display.Shape;	

	import lance.component.parts.ScrollContainer;	
	import lance.component.parts.ScrollTrack;	

	import flash.events.Event;	
	import flash.net.URLRequest;	
	import flash.display.Loader;	
	import flash.display.BitmapData;	

	import lance.component.skin.ScrollTrackSkin;	
	import lance.core.graphics.LanceSprite;
	/**
	 * Description
	 * @author SSen
	 */
	public class ScrollTrackTest extends LanceSprite 
	{
		private var skin1 : ScrollTrackSkin;
		private var skin2 : ScrollTrackSkin;
		private var sc : ScrollContainer;
		private var stV : ScrollTrack;
		private var stH : ScrollTrack;

		public function ScrollTrackTest()
		{
			super();
			
			skin1 = new ScrollTrackSkin(new ScrollTrackBitmap(0, 0), true);
			skin2 = new ScrollTrackSkin(new ScrollTrackBitmap2(0, 0), true);
			sc = new ScrollContainer(getDisplayObject(), 300, 200);
			stV = new ScrollTrack(skin1, sc, 15, 200, DirectionMode.VERTICAL, 0, false, TrackMode.POINT, 10, 110);
			stH = new ScrollTrack(skin1, sc, 300, 15, DirectionMode.HORIZONTAL, 0, false, TrackMode.PAGE, 0, -2);
			stV.addEventListener(ScrollEvent.SCROLL, scroll);
			stH.addEventListener(ScrollEvent.SCROLL, scroll);
			addChild(sc);
			sc.x = sc.y = 10;
			addChild(stV);
			stV.x = 310;
			stV.y = 10;
			addChild(stH);
			stH.x = 10;
			stH.y = 210;
			
			graphics.beginFill(0xeeeeee);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			var t1 : TestButton = new TestButton("skin change", skinChange);
			t1.x = 400;
			t1.y = 10;
			addChild(t1);
		}
		private function skinChange() : void
		{
			stV.skin = (stV.skin == skin1) ? skin2 : skin1;
		}
		private function keyDown(event : KeyboardEvent) : void
		{
			stV.value = 60;
		}
		private function scroll(event : ScrollEvent) : void
		{
			var st : ScrollTrack = ScrollTrack(event.target);
			trace(st.value, st.minValue, st.maxValue, st.sight, st.sec);
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
			
			s.width = 1000;
			s.height = 1000;
			
			return s;
		}
	}
}
