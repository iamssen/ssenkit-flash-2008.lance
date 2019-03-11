package  
{
	import flash.geom.Matrix;	
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	import flash.display.BitmapData;	
	import flash.display.Bitmap;	

	import lance.core.text.FavoriteTextFormats;	

	import flash.text.TextField;	

	import lance.core.graphics.LanceSprite;
	/**
	 * @author SSen
	 */
	public class TestBitmapTextRoll extends LanceSprite 
	{
		private const W : int = 300;
		private const X : int = 30;
		private var txt : TextField;
		private var bit : Bitmap;
		private var timer : Timer;
		private var bmd : BitmapData;

		public function TestBitmapTextRoll()
		{
			super();
			
			trace(stage.frameRate);
			stage.frameRate = 60;
			
			graphics.beginFill(0x9A9B9F);
			graphics.drawRect(0, 0, 550, 400);
			graphics.endFill();
			
			txt = new TextField();
			txt.defaultTextFormat = FavoriteTextFormats.dotum11px(0xffffff);
			txt.text = "가나다라마바사아자차카타파하가나다라마바사아자차카타파하";
			txt.width = txt.textWidth + 4;
			txt.height = txt.textHeight + 4;
			txt.x = X;
			txt.y = 20;
			
			bmd = new BitmapData(txt.width, txt.height, false, 0x9A9B9F);
			bmd.draw(txt);
			bit = new Bitmap(bmd);
			bit.x = X;
			bit.y = txt.y + bit.height + 5; 
			
			var mask1 : Bitmap = new Bitmap(new BitmapData(W, 500));
			var mask2 : Bitmap = new Bitmap(new BitmapData(W, 500));
			mask1.x = mask2.x = X;
			bit.mask = mask1;
			txt.mask = mask2;
			
			addChildren(txt, bit);
			
			timer = new Timer(20);
			timer.addEventListener(TimerEvent.TIMER, timerListener);
			timer.start();
		}

		private function timerListener(event : TimerEvent) : void
		{
			var speed : Number = 2;
			txt.x -= speed;
			bit.x -= speed;
			
			if (txt.x < -txt.width) {
				txt.x = W + X;
			}
			if (bit.x < -bit.width) {
				bit.x = W + X;
			}
			event.updateAfterEvent();
		}
	}
}
