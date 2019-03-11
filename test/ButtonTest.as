package  
{
	import lance.core.graphics.LanceSprite;	
	import lance.debug.TestButton;	

	import skin.ButtonBitmap2;	
	import skin.ButtonBitmap;	

	import lance.component.BitmapSplitButton;	
	import lance.component.properties.ButtonType;	
	import lance.core.skinObject.SkinSprite;	
	import lance.core.skinObject.ISkinObject;	
	import lance.core.skinObject.SkinMode;	
	import lance.core.skinObject.SkinLabel;	

	import flash.filters.ColorMatrixFilter;	

	import com.gskinner.geom.ColorMatrix;	

	import flash.events.MouseEvent;	

	import lance.core.contents.DisplayObjectContent;	
	import lance.core.number.MathEx;	

	import flash.display.Graphics;	
	import flash.display.Shape;	
	import flash.display.DisplayObject;	
	import flash.display.BitmapData;	
	import flash.net.URLRequest;	
	import flash.events.Event;	
	import flash.display.Loader;	

	import lance.component.Button;	
	import lance.core.text.TextStyle;	
	import lance.component.skin.ButtonSkin;	

	import flash.display.Sprite;
	/**
	 * Description
	 * @author SSen
	 */
	public class ButtonTest extends LanceSprite 
	{
		private var skin1 : ButtonSkin;
		private var skin2 : ButtonSkin;
		private var style : TextStyle;
		private var btn : Button;
		private var aaa : DisplayObject;
		private var color : ColorMatrix;
		private var bool : Boolean = false;
		private var label : SkinLabel;
		private var btn1 : Button;

		public function ButtonTest()
		{
			super();
			
			var bmd1 : BitmapData = new ButtonBitmap(0, 0);
			var bmd2 : BitmapData = new ButtonBitmap2(0, 0);
			skin1 = new ButtonSkin(bmd1); 
			skin2 = new ButtonSkin(bmd2);
			style = new TextStyle();
			trace(skin1.button_fontColors);
			style.colors = skin1.button_fontColors;
			var so : ISkinObject;
			so = new SkinLabel("button click me", style);
			btn = new Button(skin1, 120, 30, so, false, false, ButtonType.NORMAL);
			btn.tabIndex = 1;
			btn.x = btn.y = 10;
			btn.addEventListener(MouseEvent.CLICK, click);
			var so2 : ISkinObject;
			so2 = new SkinLabel("button click me", style);
			btn1 = new Button(skin1, 120, 30, so2, false, false, ButtonType.NORMAL);
			btn1.tabIndex = 1;
			btn1.position = btn.nextPosition();
			btn1.addEventListener(MouseEvent.CLICK, click);
			trace(btn.index);
			addChildren(btn, btn1);
			
			label = new SkinLabel("button", style, new DisplayObjectContent(getThumb()), false);
			label.x = 10;
			label.y = 80;
			//addChild(label);
			aaa = getThumb();
			//addChild(aaa);
			aaa.x = 10;
			aaa.y = 150;
			
			color = new ColorMatrix();
			color.adjustBrightness(10);
			color.adjustContrast(15);
			color.adjustSaturation(-100);
			
			var t1 : TestButton = new TestButton("skin change", skinChange);
			t1.x = 400;
			t1.y = 10;
			addChild(t1);
			trace(getChildIndex(t1));
			
			trace(btn.containerMode);
			
			containerMode = true;
		}
		private function skinChange() : void
		{
			//btn.skin = (btn.skin == skin1) ? skin2 : skin1;
			stage.focus = this;
		}
		private function click(event : MouseEvent) : void
		{
			trace(new Date().time, btn.tabIndex, btn1.tabIndex, btn.index, btn1.index, numChildren);
			//btn1.index = 5;
			/*
			if (bool) {
				aaa.filters = [new ColorMatrixFilter(color)];
				label.skinning(SkinMode.DISABLE);
			} else {
				aaa.filters = null;
				label.skinning(SkinMode.DEFAULT);
			}
			bool = (bool) ? false : true;
			 * 
			 */
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
