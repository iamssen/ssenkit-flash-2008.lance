package lance.component.parts 
{
	import lance.component.properties.ValueType;	
	import lance.component.events.ListEvent;
	import lance.component.parts.IList;
	import lance.component.parts.LanceInputComponent;
	import lance.component.skin.LanceSkin;
	import lance.core.array.ArrayEx;

	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;		

	/** @copy lance.component.events.ListEvent#CELL_SELECT */
	[Event(name="cellSelect", type="lance.component.events.ListEvent")]

	/** @copy lance.component.events.ListEvent#CHANGE_LIST */
	[Event(name="changeList", type="lance.component.events.ListEvent")]
	/**
	 * @author SSen
	 */
	public class AbstList extends LanceInputComponent implements IList 
	{
		protected var _cells : Array;
		protected var _multiSelect : Boolean;

		public function AbstList(skin : LanceSkin, width : int = 0, height : int = 0, list : Array = null)
		{
			super(skin, width, height, ValueType.XML);
			_cells = list;
			init();
		}
		protected function init() : void
		{
			var cell : IListCell;
			var f : int;
			for (f = 0;f < _cells.length; f++) {
				cell = _cells[f];
				cell.tabIndex = f;
				cell.id = f;
				cell.addEventListener(MouseEvent.CLICK, cellClick, false, 0, true);
				cell.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
			}
			tabChildren = true;
			tabEnabled = true;
		}
		private function keyDown(event : KeyboardEvent) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
			
			var cell : IListCell = event.target as IListCell;
			
			switch (event.keyCode) {
				case 37 :
				case 38 :
					if (cell.id <= 0) {
						stage.focus = _cells[_cells.length - 1] as InteractiveObject;
					} else {
						stage.focus = preCell(cell) as InteractiveObject;
					}
					break;
				case 39 : 
				case 40 :
					if (cell.id >= _cells.length - 1) {
						stage.focus = _cells[0] as InteractiveObject;
					} else {
						stage.focus = nextCell(cell) as InteractiveObject;
					}
					break;
			}
		}
		private function cellClick(event : MouseEvent) : void
		{
			var cell : IListCell = event.target as IListCell;
			
			if (!_multiSelect) { 
				var f : int;
				for (f = 0;f < _cells.length; f++) {
					cell = _cells[f];
					cell.selected = false;
				}
			}
			
			cell.selected = (!cell.selected) ? true : false;
			dispatchEvent(new ListEvent(ListEvent.CELL_SELECT, cell.x, cell.y, cell.values, cell, event.ctrlKey, event.altKey, event.shiftKey));
		}
		/** @private */
		override public function get value() : Object
		{
			return data;
		}
		override public function set value(value : Object) : void
		{
			if (value is XML) data = value as XML;
		}
		/*
		 * implements IList
		 */
		public function refresh() : void
		{
			var cell : IListCell;
			
			var f : int;
			for (f = 0;f < _cells.length; f++) {
				cell = _cells[f];
				cell.tabIndex = f;
				cell.id = f;
			}
		}
		public function selectedCells() : Array
		{
			var cells : Array = new Array();
			var cell : IListCell;
			for each (cell in _cells) {
				if (cell.selected) cells.push(cell);
			}
			return (cells.length > 0) ? cells : null;
		}
		public function searchValue(valueName : String, text : String) : Array
		{
			var cells : Array = new Array();
			var cell : IListCell;
			for each (cell in _cells) {
				if (cell.searchValue(valueName, text)) cells.push(cell);
			}
			return (cells.length > 0) ? cells : null;
		}
		public function selectCell(cell : IListCell, select : Boolean) : void
		{
			cell.selected = select;
		}
		public function findValue(valueName : String, text : String) : Array
		{
			var cells : Array = new Array();
			var cell : IListCell;
			for each (cell in _cells) {
				if (cell.findValue(valueName, text)) cells.push(cell);
			}
			return (cells.length > 0) ? cells : null;
		}
		public function sortValue(valueName : Object, options : Object = null) : void
		{
			trace(valueName, options);
		}
		public function get multiSelect() : Boolean
		{
			return _multiSelect;
		}
		public function get cells() : Array
		{
			return _cells;
		}
		public function set cells(cells : Array) : void
		{
			var cell : DisplayObject;
			for each (cell in _cells) {
				removeChild(cell);
			}
			_cells = cells;
			init();
			refresh();
			dispatchEvent(new ListEvent(ListEvent.CHANGE_LIST));
		}
		public function get data() : XML
		{
			var xml : XML = <list />;
			var cell : IListCell;
			for each (cell in _cells) {
				xml["cell"] += cell.valuesXML;
			}
			return xml;
		}
		public function set data(data : XML) : void
		{
			trace(data);
		}
		public function set multiSelect(multiSelect : Boolean) : void
		{
			if (_multiSelect != multiSelect) {
				_multiSelect = multiSelect;
				
				if (!_multiSelect) {
					var cell : IListCell;
					for each (cell in _cells) {
						cell.selected = false;
					}
				}
			}
		}
		/** cell 의 이전 cell */
		public function preCell(cell : IListCell) : IListCell
		{
			var id : int = cell.id;
			if (id <= 0) {
				return cell;
			}
			var f : int;
			for (f = id;f >= 0; f--) {
				cell = _cells[f];
				if (id - 1 == cell.id) return cell;
			}
			return null;
		}
		/** cell 의 이후 cell */
		public function nextCell(cell : IListCell) : IListCell
		{
			var id : int = cell.id;
			if (id >= _cells.length - 1) {
				return cell;
			}
			var f : int;
			for (f = id;f < _cells.length; f++) {
				cell = _cells[f];
				if (id + 1 == cell.id) return cell;
			}
			return null;
		}
		/** 해당 id 값을 가진 cell */
		public function getCell(id : int) : IListCell
		{
			return _cells[id];
		}
		/*
		 * overriding public interface
		 */
		/** list cell 을 지운다 */
		protected function removeListCell(child : IListCell) : IListCell
		{
			var cell : IListCell = removeChild(DisplayObject(child)) as IListCell;
			if (cell.hasEventListener(MouseEvent.CLICK)) cell.removeEventListener(MouseEvent.CLICK, cellClick);
			if (cell.hasEventListener(KeyboardEvent.KEY_DOWN)) cell.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_cells = ArrayEx.delElement(child, _cells);
			
			refresh();
			dispatchEvent(new ListEvent(ListEvent.CHANGE_LIST));
			return cell;
		}
		/** 특정 index 의 list cell 을 지운다 */
		protected function removeListCellAt(index : int) : IListCell
		{
			var cell : IListCell = getChildAt(index) as IListCell;
			_cells = ArrayEx.delElement(cell, _cells);
			cell = removeChildAt(index) as IListCell;
			if (cell.hasEventListener(MouseEvent.CLICK)) cell.removeEventListener(MouseEvent.CLICK, cellClick);
			if (cell.hasEventListener(KeyboardEvent.KEY_DOWN)) cell.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			refresh();
			dispatchEvent(new ListEvent(ListEvent.CHANGE_LIST));
			return cell;
		}
		/** list cell 을 추가한다 */
		protected function addListCell(child : IListCell) : IListCell
		{
			var cell : IListCell = addChild(DisplayObject(child)) as IListCell;
			cell.addEventListener(MouseEvent.CLICK, cellClick, false, 0, true);
			cell.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
			cell.tabIndex = cell.id = _cells.length;
			cell.enabled = enabled;
			
			refresh();
			dispatchEvent(new ListEvent(ListEvent.CHANGE_LIST));
			return cell;
		}
		/** 특정 index 의 위치로 list cell 을 추가한다 */
		protected function addListCellAt(child : IListCell, index : int) : IListCell
		{
			var cell : IListCell = addChildAt(DisplayObject(child), index) as IListCell;
			cell.addEventListener(MouseEvent.CLICK, cellClick, false, 0, true);
			cell.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
			cell.tabIndex = cell.id = _cells.length;
			cell.enabled = enabled;
			
			refresh();
			dispatchEvent(new ListEvent(ListEvent.CHANGE_LIST));
			return cell;
		}
	}
}
