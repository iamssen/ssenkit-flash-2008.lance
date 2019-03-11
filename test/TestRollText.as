package  
{
	import lance.core.geom.VerticalAlign;	
	import lance.core.number.MathEx;	
	import lance.core.graphics.LanceSprite;	
	import lance.debug.TestButton;	
	import lance.core.text.TextStyle;	
	import lance.core.text.RollText;	
	/**
	 * @author SSen
	 */
	public class TestRollText extends LanceSprite 
	{
		private var rt : RollText;
		
		public function TestRollText()
		{
			super();
			var style : TextStyle = new TextStyle();
			style.color = 0x666666;
			rt = new RollText("aaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbb", 150, 40, style, null, VerticalAlign.MIDDLE, true, true, 0xeeeeee, 0xaaaaaa);
			rt.x = rt.y = 10;
			addChild(rt);
			
			var t1 : TestButton = new TestButton("change text", changeText);
			t1.position = rt.nextPositionBr(15);
			var t2 : TestButton = new TestButton("change width", changeWidth);
			t2.position = t1.endPosition;
			addChildren(t1, t2);
		}
		private function changeWidth() : void
		{
			rt.width = MathEx.rand(50, 300);
		}
		private function changeText() : void
		{
			rt.text = "가나다라마바사아자차카타파하가나다라마바사아자차카타파하";
		}
	}
}
