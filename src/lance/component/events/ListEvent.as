package lance.component.events 
{
	import lance.component.parts.IListCell;	
	import lance.core.array.Values;	

	import flash.events.Event;
	/**
	 * List 에서 발생하는 이벤트
	 * @author SSen
	 */
	public class ListEvent extends Event 
	{
		/** cell 이 선택(클릭, 엔터키, 스페이스키) 될때 */
		public static const CELL_SELECT : String = "cellSelect";
		/** list 내부의 cell list 가 추가, 삭제 등 변경되면 */
		public static const CHANGE_LIST : String = "changeList";
		private var _cellX : Number;
		private var _cellY : Number;
		private var _values : Values;
		private var _cell : IListCell;
		private var _ctrlKey : Boolean;
		private var _altKey : Boolean;
		private var _shiftKey : Boolean;

		public function ListEvent(type : String, cellX : Number = 0, cellY : Number = 0, values : Values = null, cell : IListCell = null, ctrlKey : Boolean = false, altKey : Boolean = false, shiftKey : Boolean = false, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_cellX = cellX;
			_cellY = cellY;
			_values = values;
			_cell = cell;
			_ctrlKey = ctrlKey;
			_altKey = altKey;
			_shiftKey = shiftKey;
		}
		/** select 된 cell 의 x 위치 */
		public function get cellX() : Number
		{
			return _cellX;
		}
		/** select 된 cell 의 y 위치 */
		public function get cellY() : Number
		{
			return _cellY;
		}
		/** select 된 cell 의 values object */
		public function get values() : Values
		{
			return _values;
		}
		/** select 된 cell */
		public function get cell() : IListCell
		{
			return _cell;
		}
		/** mouse click event 시에 ctrlKey 가 눌러져 있었는지 확인 */  
		public function get ctrlKey() : Boolean
		{
			return _ctrlKey;
		}
		/** mouse click event 시에 altKey 가 눌러져 있었는지 확인 */
		public function get altKey() : Boolean
		{
			return _altKey;
		}
		/** mouse click event 시에 shiftKey 가 눌러져 있었는지 확인 */
		public function get shiftKey() : Boolean
		{
			return _shiftKey;
		}
		/** toString() */
		public override function toString() : String
		{
			return '[ListEvent type="' + type + '" cellX="' + _cellX + '" cellY="' + _cellY + '" ctrlKey="' + _ctrlKey + '" altKey="' + _altKey + '" shiftKey="' + _shiftKey + '"]';
		}
	}
}
