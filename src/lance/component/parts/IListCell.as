package lance.component.parts 
{
	import lance.core.graphics.ILanceSprite;	
	import lance.core.array.Values;		
	/**
	 * @author SSen
	 */
	public interface IListCell extends ILanceSprite
	{
		/** cell 의 value 에 text 가 포함되어 있는지 확인 */
		function searchValue(valueName : String, text : String) : Boolean;
		/** cell 의 value 가 text 인지 확인 */
		function findValue(valueName : String, text : String) : Boolean;
		/** cell 의 선택된 상태*/
		function get selected() : Boolean;
		function set selected(selected : Boolean) : void;
		/** cell 에 저장된 값 */
		function get values() : Values;
		function set values(values : Values) : void;
		/** cell 에 저장된 값을 XML type 으로 변환한 값 */
		function get valuesXML() : XML;
		function preCell() : IListCell;
		function nextCell() : IListCell;
		function get id() : int;
		function set id(id : int) : void;
		function get minHeight() : Number;
		function get minWidth() : Number;
		function get enabled() : Boolean;
		function set enabled(bool : Boolean) : void;
	}
}
