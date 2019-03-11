package  
{
	import lance.core.array.RandomProperty;	
	import lance.core.text.TextStyle;	
	import lance.core.number.MathEx;	
	import lance.core.graphics.LanceSprite;	
	import lance.debug.TestButton;	
	import lance.core.text.LanceTextField;

	/**
	 * Description
	 * @author SSen
	 */
	public class AutoReplaceTest extends LanceSprite 
	{
		// TODO 테스트를 좀 더 꼼꼼히 해보기
		private var txt : LanceTextField;

		public function AutoReplaceTest()
		{
			txt = new LanceTextField();
			var ts : TextStyle = new TextStyle();
			ts.border = true;
			ts.borderColor = 0xcccccc;
			ts.color = 0xaaaaaa;
			txt.defaultTextFormat = ts;
			txt.text = "abcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstu";
			txt.x = txt.y = 10;
			txt.height = 50;
			addChild(txt);
			
			var t1 : TestButton = new TestButton("autoReplace toggle", t1f);
			t1.x = 10;
			t1.y = 100;
			var t2 : TestButton = new TestButton("width change 50 ~ 400", t2f);
			t2.position = t1.endPosition;
			var t3 : TestButton = new TestButton("textChange", t3f);
			t3.position = t2.endPosition;
			var t4 : TestButton = new TestButton("auto width", t4f);
			t4.position = t3.endPosition;
			
			var e1 : TestButton = new TestButton("get Text", e1f);
			e1.position = t1.endPositionBr;
			addChildren(t1, t2, t3, t4, e1);
		}
		private function t4f() : void
		{
			txt.autoSizeWidth();
		}
		private function t3f() : void
		{
			var rand : RandomProperty = new RandomProperty("aaaa", "cccccccccccccccccc", "abcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstu");
			txt.text = rand.random();
		}
		private function e1f() : void
		{
			trace(txt.text);
		}
		private function t2f() : void
		{
			txt.width = MathEx.rand(50, 400);
		}
		private function t1f() : void
		{
			txt.autoReplaceOverText = (txt.autoReplaceOverText) ? false : true;
		}
	}
}
