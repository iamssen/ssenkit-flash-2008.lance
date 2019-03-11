package  
{
	import lance.component.Input;
	import lance.component.skin.InputSkin;
	import lance.core.contents.DisplayObjectContent;
	import lance.core.events.LanceEvent;
	import lance.core.number.MathEx;
	import lance.core.text.TextStyle;
	import lance.debug.TestButton;
	
	import skin.InputBitmap;
	import skin.InputBitmap2;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;		
	/**
	 * @author SSen
	 */
	public class InputTest extends Sprite 
	{
		private var skin : InputSkin;
		private var skin2 : InputSkin;
		private var style : TextStyle;
		private var input : Input;

		public function InputTest()
		{
			skin = new InputSkin(new InputBitmap(0, 0));
			skin2 = new InputSkin(new InputBitmap2(0, 0));
			
			style = new TextStyle();
			input = new Input(skin, 120, 30, "가나다라", new DisplayObjectContent(getThumb()), style); 
			input.x = input.y = 10;
			addChild(input);
			
			//input.addEventListener(ComponentEvent.INPUT_START, inputStart);
			//input.addEventListener(ComponentEvent.INPUT_END, inputEnd);
			var btn : TestButton = new TestButton("skin change", skinChange);
			btn.x = 10;
			btn.y = input.y + input.height + 5;
			addChild(btn);
		}
		private function skinChange() : void
		{
			if (input.skin == skin) {
				input.skin = skin2;
			} else {
				input.skin = skin;
			}
		}
		private function inputEnd(event : LanceEvent) : void
		{
			input.skin = skin;
			
		}
		private function inputStart(event : LanceEvent) : void
		{
			input.skin = skin2;
		}
		private function getThumb() : DisplayObject
		{
			var thum : Shape = new Shape();
			var g : Graphics = thum.graphics;
			g.beginFill(MathEx.rand(0x000000, 0xffffff));
			g.drawRect(0, 0, MathEx.rand(10, 30), MathEx.rand(10, 30));
			g.endFill();
			g.beginFill(MathEx.rand(0x000000, 0xffffff));
			g.drawRect(4, 4, 4, 4);
			g.endFill();
			
			thum.alpha = 0.5;
			
			return thum;
		}
	}
}
