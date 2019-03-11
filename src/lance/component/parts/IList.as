package lance.component.parts 
{
	import lance.core.graphics.ILanceSprite;	
	/**
	 * @author SSen
	 */
	public interface IList extends ILanceSprite, IInput
	{
		/*
		 * 부가 옵션
		 */
		/** 다중선택 가능 */
		function get multiSelect() : Boolean;
		function set multiSelect(multiSelect : Boolean) : void;
		/** 새로고침, skin, align */
		function refresh() : void;
		/*
		 * 읽기, 추가, 삭제
		 */
		/** 내부의 listCell */
		function get cells() : Array;
		function set cells(cells : Array) : void;
		/** 내부의 list data */
		function get data() : XML;
		function set data(data : XML) : void;
		/*
		 * 선택, 검색
		 */
		/** 선택된 cell 들을 가져온다 */
		function selectedCells() : Array;
		/** value 중 문자열을 포함하는 cell 들을 가져온다 */
		function searchValue(valueName : String, text : String) : Array;
		/** 특정 cell 을 선택된 상태로 바꾼다 */
		function selectCell(cell : IListCell, select : Boolean) : void;
		/** value 가 문자열과 일치하는 cell 들을 가져온다 */
		function findValue(valueName : String, text : String) : Array;
		/** Value 를 기준으로 정렬한다, Array.sortOn 참고 */
		function sortValue(valueName : Object, options : Object = null) : void;
		function preCell(cell : IListCell) : IListCell;
		function nextCell(cell : IListCell) : IListCell;
		function getCell(id : int) : IListCell;
	}
}
