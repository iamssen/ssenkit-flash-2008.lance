package lance.component.parts 
{
	import lance.component.properties.DirectionMode;	
	import lance.component.parts.IList;
	import lance.component.parts.ScrollPane;
	import lance.component.skin.LanceSkin;	
	/**
	 * @author SSen
	 */
	public class LabelListBox extends ScrollPane implements IList 
	{
		public function LabelListBox(skin : LanceSkin, width : int = 0, height : int = 0)
		{
			super(null, DirectionMode.VERTICAL_AND_HORIZONTAL, null, width, height);
		}
		public function refresh() : void
		{
		}
		public function selectedCells() : Array
		{
			return null;
		}
		public function searchValue(valueName : String, text : String) : Array
		{
			return null;
		}
		public function selectCell(cell : IListCell, select : Boolean) : void
		{
		}
		public function findValue(valueName : String, text : String) : Array
		{
			return null;
		}
		public function sortValue(valueName : Object, options : Object = null) : void
		{
		}
		public function preCell(cell : IListCell) : IListCell
		{
			return null;
		}
		public function nextCell(cell : IListCell) : IListCell
		{
			return null;
		}
		public function getCell(id : int) : IListCell
		{
			return null;
		}
		public function get multiSelect() : Boolean
		{
			return false;
		}
		public function get cells() : Array
		{
			return null;
		}
		public function get data() : XML
		{
			return null;
		}
		public function get value() : Object
		{
			return null;
		}
		public function get valueType() : String
		{
			return null;
		}
		public function set multiSelect(multiSelect : Boolean) : void
		{
		}
		public function set cells(cells : Array) : void
		{
		}
		public function set data(data : XML) : void
		{
		}
		public function set value(value : Object) : void
		{
		}
	}
}
