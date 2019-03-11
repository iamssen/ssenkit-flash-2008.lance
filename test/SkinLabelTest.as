package  
{
	import lance.core.array.RandomProperty;	
	import lance.core.graphics.LanceSprite;	
	import lance.debug.TestButton;	
	import lance.core.contents.DisplayObjectContent;	

	import flash.display.DisplayObject;	

	import lance.core.number.MathEx;	

	import flash.display.Graphics;	
	import flash.display.Shape;	

	import lance.core.skinObject.SkinMode;	
	import lance.core.text.TextStyle;	
	import lance.core.skinObject.SkinLabel;	

	import flash.display.Sprite;
	/**
	 * @author SSen
	 */
	public class SkinLabelTest extends LanceSprite 
	{
		private var sl : SkinLabel;
		
		public function SkinLabelTest()
		{
			var colors : Object = new Object();
			colors[SkinMode.DEFAULT] = 0x666666;
			colors[SkinMode.OVER] = 0x00ff00;
			colors[SkinMode.ACTION] = 0xff00ff;
			colors[SkinMode.DISABLE] = 0xaaaaaa;
			
			sl = new SkinLabel("window 테스트 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", new TextStyle(false, colors, 0, 0, false, 0, false, 0, "돋움", 11, 0x666666, true), new DisplayObjectContent(getDisplayObject()), true);
			sl.x = sl.y = 10;
			addChild(sl);

			var t1 : TestButton = new TestButton("width change 100 ~ 300", t1f);
			t1.x = 10;
			t1.y = 100;
			var t2 : TestButton = new TestButton("auto width", t2f);
			t2.position = t1.endPosition;
			var t3 : TestButton = new TestButton("get info", t3f);
			t3.position = t2.endPosition;
			var t4 : TestButton = new TestButton("skin change", t4f);
			t4.position = t3.endPosition;
			var t5 : TestButton = new TestButton("roll toggle", t5f);
			t5.position = t4.endPosition;
			addChildren(t1, t2, t3, t4, t5);
		}
		private function t5f() : void
		{
			if (sl.roll) {
				sl.rollStop();
			} else {
				sl.rollStart();
			}
		}
		private function t4f() : void
		{
			var rp : RandomProperty = new RandomProperty(SkinMode.DEFAULT, SkinMode.DISABLE, SkinMode.OVER, SkinMode.ACTION);
			sl.skinning(rp.random());
		}
		private function t3f() : void
		{
			trace(sl.flag);
			trace(sl.skinList);
			trace(sl.text);
			trace(sl.length);
		}
		private function t2f() : void
		{
			sl.autoSizeWidth();
		}
		private function t1f() : void
		{
			sl.width = MathEx.rand(100, 600);
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
