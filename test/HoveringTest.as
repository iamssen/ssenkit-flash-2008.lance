package  
{
	import flash.filters.BlurFilter;	
	import flash.events.MouseEvent;	
	import flash.display.Shape;	
	
	import lance.debug.TestButton;	
	
	import flash.display.Sprite;	
	import flash.events.Event;	
	
	import lance.core.graphics.LanceSprite;
	/**
	 * @author SSen
	 */
	public class HoveringTest extends LanceSprite 
	{
		private var lp : LanceSprite;
		private var sh : Shape;

		public function HoveringTest()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void
		{
			trace(event.type);
			lp = new LanceSprite();
			lp.graphics.beginFill(0xcccccc);
			lp.graphics.drawRect(0, 0, 100, 100);
			lp.graphics.endFill();
			lp.x = 100;
			lp.y = 50;
			lp.buttonMode = true;
			lp.addEventListener(MouseEvent.CLICK, click);
			
			addChild(lp);
			
			
			trace(parent, stage, stage.stageWidth, stage.stageHeight);
			sh = new Shape();
			sh.graphics.beginFill(0x000000, 0.5);
			sh.graphics.drawRect(0, 0, 500, 400);
			sh.graphics.endFill();
			
			var t1 : TestButton = new TestButton("hover toggle", hoverToggle);
			t1.x = 10;
			t1.y = lp.nextY(20);
			addChildren(t1);
		}
		private function click(event : MouseEvent) : void
		{
			hoverToggle();
		}
		private function hoverToggle() : void
		{
			if (lp.hover) {
				filters = null;
				mouseChildren = true;
				removeChild(sh);
				lp.hover = false;
			} else {
				filters = [new BlurFilter(3, 3)];
				mouseChildren = false;
				addChild(sh);
				lp.hover = true;
			}
			trace(lp.parent, stage.stageWidth, stage.stageHeight);
		}
	}
}
