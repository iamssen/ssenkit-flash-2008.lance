package  
{
	import flash.text.TextFieldType;	
	import flash.events.KeyboardEvent;	
	import flash.text.TextFieldAutoSize;	
	import flash.text.TextField;	
	import flash.display.Sprite;
	/**
	 * @author SSen
	 */
	public class TextTest extends Sprite 
	{
		public function TextTest()
		{
			super();
			
			var date : Date = new Date();
			date.month += 24;
			trace(date.fullYear, date.month);
			
			var txt : TextField = new TextField();
			txt.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			txt.type = TextFieldType.INPUT;
			
			txt.text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
			trace(txt.textWidth, txt.textHeight, txt.width, txt.height);
			txt.autoSize = TextFieldAutoSize.LEFT;
			trace(txt.textWidth, txt.textHeight, txt.width, txt.height);
			//txt.multiline = true;
			//txt.wordWrap = true;
			txt.width = 100;
			trace(txt.textWidth, txt.textHeight, txt.width, txt.height);
			
			addChild(txt);
		}
		private function keyDown(event : KeyboardEvent) : void
		{
			trace(event.keyCode);
		}
	}
}
