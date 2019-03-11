package  
{
		

	import lance.core.graphics.LanceSprite;	

	import flash.display.Sprite;
	/**
	 * Description
	 * @author SSen
	 */
	public class GlobalAndLocalPoint extends Sprite 
	{
		public function GlobalAndLocalPoint()
		{
			super();
			
			var sp1 : Sprite = new Sprite();
			sp1.x = sp1.y = 10;
			addChild(sp1);
			
			var sp2 : Sprite = new Sprite();
			sp2.x = sp2.y = 10;
			sp1.addChild(sp2);
			
			var sp3 : LanceSprite = new LanceSprite();
			sp3.x = sp3.y = 10;
			sp2.addChild(sp3);
			
			trace(sp3.x);
			trace(sp3.globalX);
			
			sp3.globalX = 10;
			
			trace(sp3.x);
			trace(sp3.globalX);
		}
	}
}
