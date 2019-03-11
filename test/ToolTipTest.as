package  
{
	import lance.component.BitmapSplitButton;	
	import lance.core.skinObject.BitmapSplitSet;	
	import lance.core.contents.StringContent;	
	import lance.core.geom.Position9;	
	import lance.core.text.TextStyle;	
	
	import flash.display.BitmapData;	
	import flash.net.URLRequest;	
	import flash.events.Event;	
	import flash.display.Loader;	

	import lance.component.skin.ToolTipSkin;	

	import flash.events.MouseEvent;	
	import flash.display.Graphics;	

	import lance.component.parts.LanceComponent;	

	import flash.display.Sprite;
	/**
	 * Description
	 * @author SSen
	 */
	public class ToolTipTest extends Sprite 
	{
		private var skin : ToolTipSkin;
		private var style : TextStyle;
		private var position : String;
		private var tw : int;
		private var bmd1 : BitmapData;
		private var bmd2 : BitmapData;

		public function ToolTipTest()
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete1);
			loader.load(new URLRequest("skin/tooltip.png"));
		}
		private function complete1(event : Event):void
		{
			bmd1 = event.target.loader.content.bitmapData as BitmapData;
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.load(new URLRequest("skin/closeButton.png"));
		}
		private function complete(event : Event) : void
		{
			bmd2 = event.target.loader.content.bitmapData as BitmapData;
			skin = new ToolTipSkin(bmd1, new BitmapSplitSet(bmd2, 9, 9, BitmapSplitButton.NAME_SET));
			style = new TextStyle(false);
			position = Position9.TR;
			tw = 200;
			
			trace(skin.skinClassName);
			
			var comp : LanceComponent = new LanceComponent(100, 100);
			var g : Graphics = comp.graphics;
			g.beginFill(0x000000, 0.1);
			g.drawRect(0, 0, 100, 100);
			g.endFill();
			comp.x = 220;
			comp.y = 150;
			
			addChild(comp);
			
			//comp.addEventListener(MouseEvent.ROLL_OVER, rollover);
			//comp.addEventListener(MouseEvent.ROLL_OUT, rollout);
			comp.addEventListener(MouseEvent.CLICK, click);
			
			var sp : Sprite = new Sprite();
			g = sp.graphics;
			g.beginFill(0x000000, 0.9);
			g.drawRect(0, 0, 2, 2);
			g.endFill();
			
			addChild(sp);
			sp.x = 125;
			sp.y = 270;
		}
		private function click(event : MouseEvent) : void
		{
			LanceComponent(event.target).tooltipOpen(new StringContent("<font size='20' color='#ff0000'>되나<br> 한 번</font> 볼까요? <b>하하하</b>하하...<br>aaaaaaaaaaaab<br>aaaaaaaaaaaaaaaaaaaaaaaaaaaaa", true), 
													skin, style, false, position, 0.4, tw, true);
		}
		private function rollout(event : MouseEvent) : void
		{
			LanceComponent(event.target).tooltipOff();
		}
		private function rollover(event : MouseEvent) : void
		{
			LanceComponent(event.target).tooltipOpen(new StringContent("<font size='20' color='#ff0000'>되나<br> 한 번</font> 볼까요? <b>하하하</b>하하...<br>aaaaaaaaaaaab<br>aaaaaaaaaaaaaaaaaaaaaaaaaaaaa", true), 
													skin, style, false, position, 0.4, tw, true);
		}
	}
}
