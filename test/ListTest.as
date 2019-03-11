package  
{
	import lance.component.events.ListEvent;
	import lance.component.parts.IListCell;
	import lance.component.parts.LabelList;
	import lance.component.parts.LabelListCell;
	import lance.component.skin.LabelListSkin;
	import lance.core.contents.BitmapDataContent;
	import lance.core.contents.Content;
	import lance.core.events.LanceEvent;
	import lance.core.graphics.LanceSprite;
	import lance.core.number.MathEx;
	import lance.core.skinObject.BitmapDataSet;
	import lance.core.skinObject.BitmapSplitSet;
	import lance.core.skinObject.SkinMode;
	import lance.core.skinObject.SkinSprite;
	import lance.core.text.TextStyle;
	import lance.debug.TestButton;

	import thumb.IconSet;
	import thumb.PaperBitmap;

	import flash.display.Graphics;
	import flash.display.Shape;	
	/**
	 * Description
	 * @author SSen
	 */
	public class ListTest extends LanceSprite 
	{
		private var list : LabelList;
		private var labelSkin : LabelListSkin;
		private var labelSkin2 : LabelListSkin;

		public function ListTest()
		{
			super();
			
			var style : TextStyle = new TextStyle();
			style.colors = new Object();
			style.colors[SkinMode.DEFAULT] = 0x555555;
			style.colors[SkinMode.OVER] = 0x000000;
			style.colors[SkinMode.ACTION] = 0xcccccc;
			style.colors[SkinMode.DISABLE] = 0xffffff;
			var thumb : Content;
			var bgs : Array;
			var bg : SkinSprite;
			
			var pre : LabelListCell;
			var cell : LabelListCell;
			for (var f : int = 0;f <= 10; f++) {
				thumb = new BitmapDataContent(new PaperBitmap(0, 0));
				bgs = new Array();
				bgs[SkinMode.DEFAULT] = getShape(0xeeeeee);
				bgs[SkinMode.OVER] = getShape(0xbbbbbb);
				bgs[SkinMode.ACTION] = getShape(0x000000);
				bgs[SkinMode.DISABLE] = getShape(0xffffff);
				bg = new SkinSprite(bgs);
				cell = new LabelListCell("테스트로 만드는 리스트쎌 이랍니다. 하하하하하하 ListCell", bg, style, 150, 22, null);
				cell.x = 10;
				cell.y = (pre == null) ? 10 : pre.nextY();
				cell.values["value"] = "1111122223322221111";
				pre = cell;
				addChild(pre);
				trace(pre.name, pre.x, pre.y);
			}
			
			trace(cell.searchValue("title", "만드"), cell.searchValue("value", "22433"));
			
			var iconSet : BitmapDataSet = new BitmapDataSet(new BitmapSplitSet(new IconSet(0, 0), 16, 16, ["icon1", "icon2", "icon3"]));
			var arr1 : Array = [0x678CBD, 0x4971A5, 0x4971A5, 0xB7B7B7, 0xCBDEF7, 0xFAE6AC, 0xFED497, 0xEAEEF0];
			var arr2 : Array = [0x555555, 0x000000, 0xcccccc, 0xaaaaaa, 0xeeeeee, 0xbbbbbb, 0x000000, 0xeeeeee];
			labelSkin = new LabelListSkin(arr1, arr2);
			labelSkin2 = new LabelListSkin(arr2, arr1);
			list = new LabelList(labelSkin, <xml />, style, iconSet, 150, 25);
			list.multiSelect = true;
			addChild(list);
			list.x = 200;
			list.y = 10;
			list.tabIndex = 5;
			list.addEventListener(ListEvent.CELL_SELECT, listSelect);
			list.addEventListener(LanceEvent.RESIZE, resized);
			
			trace(list.data);
			
			var t1 : TestButton = new TestButton("get values", getValues);
			t1.position = list.nextPositionBr(20);
			var t2 : TestButton = new TestButton("random height", randomHeight);
			t2.position = t1.endPosition;
			var t3 : TestButton = new TestButton("enable toggle", enableToggle);
			t3.position = t2.endPosition;
			var t4 : TestButton = new TestButton("width change", widthChange);
			t4.position = t1.endPositionBr;
			var t5 : TestButton = new TestButton("skin change", skinChange);
			t5.position = t4.endPosition;
			var t6 : TestButton = new TestButton("add cell", addCell);
			t6.position = t5.endPosition;
			var t7 : TestButton = new TestButton("get value", getValue);
			t7.position = t4.endPositionBr;
			var t8 : TestButton = new TestButton("change data", changeData);
			t8.position = t7.endPosition;
			addChildren(t1, t2, t3, t4, t5, t6, t7, t8);
		}
		private function changeData() : void
		{
			var xml : XML = <list>
				<cell title="한글데이터1" thumbnail="icon1" value1="value1" />
				<cell title="한글데이터2한글데이터2한글데이터2한글데이터2한글데이터2한글데이터2한글데이터2한글데이터2한글데이터2한글데이터2" thumbnail="icon1" value1="value1" />
				<cell title="한글데이터3" thumbnail="icon1" value1="value1" />
			</list>;
			list.data = xml; 
		}
		private function getValue() : void
		{
			trace(list.valueType, list.value);
		}
		private function addCell() : void
		{
			list.addList("test cell", null, "icon2");
		}
		private function skinChange() : void
		{
			list.skin = labelSkin2;
		}
		private function resized(event : LanceEvent) : void
		{
			trace("resized");
		}
		private function widthChange() : void
		{
			var w : Number = MathEx.rand(150, 300);
			list.width = w;
			trace(w, list.width);
		}
		private function enableToggle() : void
		{
			list.enabled = (list.enabled) ? false : true;
		}
		private function randomHeight() : void
		{
			var h : Number = MathEx.rand(100, 300);
			list.height = h;
			trace(h, list.height);
		}
		private function getValues() : void
		{
			for each (var cell:IListCell in list.selectedCells()) {
				trace(cell.valuesXML.toXMLString());
			}
		}
		private function listSelect(event : ListEvent) : void
		{
			var cell : IListCell = event.cell;
			trace(cell.id, cell.preCell().id, cell.nextCell().id, event);
		}
		public function getShape(color : uint) : Shape
		{
			var s : Shape = new Shape();
			var g : Graphics = s.graphics;
			g.beginFill(color);
			g.drawRect(0, 0, 10, 10);
			g.endFill();
			return s;
		}
	}
}
