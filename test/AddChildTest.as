package  
{
	import lance.core.graphics.LanceSprite;	
	
	import flash.display.Graphics;	
	import flash.display.Shape;	
	
	import lance.debug.TestButton;	
	import lance.core.events.ValueEvent;	
	import lance.core.array.Values;	
	
	import flash.display.Sprite;
	/**
	 * Description
	 * @author SSen
	 */
	public class AddChildTest extends LanceSprite 
	{
		private var sp : Sprite;
		
		public function AddChildTest()
		{
			sp = new Sprite();
			sp.graphics.beginFill(0x000000, 0.3);
			sp.graphics.drawRect(0, 0, 100, 100);
			sp.graphics.endFill();
			
			var co1 : Sprite = new Sprite();
			co1.x = 10;
			co1.y = 10;
			addChild(co1);
			
			var co2 : Sprite = new Sprite();
			co2.x = 200;
			co2.y = 10;
			addChild(co2);
			
			co1.addChild(sp);
			co2.addChild(sp);
			
			sp.x = 10;
			sp.y = 10;
			
			addChild(sp);
			
			
			var xml : XML = <cell />;
			xml["@aaaa"] = "bbb";
			
			trace(xml.toXMLString());
			
			var values : Values = new Values();
			values.addEventListener(ValueEvent.VALUE_CHANGE, valueChange);
			values["abc"] = "title";
			values["abc"] = "value";
			
			for (var f:String in values) {
				trace(f, values[f]);
			}
			
			var t1 : TestButton = new TestButton("addChildTo", test1);
			t1.x = 10;
			t1.y = sp.y + sp.height + 5;
			addChildren(t1);
			
			trace("test 3.1");
		}
		private function test1() : void
		{
			var shape : Shape = new Shape();
			var g : Graphics = shape.graphics;
			g.beginFill(0x000000);
			g.drawRect(0, 0, 10, 10);
			g.endFill();
			
			trace("sp", sp.x, sp.y, sp.width, sp.height, getChildIndex(sp));
			addChildTo(shape, sp);
			trace("shape", shape.x, shape.y, shape.width, shape.height, getChildIndex(shape));
			trace("sp", sp.x, sp.y, sp.width, sp.height);
		}
		private function valueChange(event : ValueEvent) : void
		{
			trace(event.valueName, event.value);
		}
	}
}
