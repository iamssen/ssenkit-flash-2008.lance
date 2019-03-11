package lance.component.parts 
{
	import lance.component.parts.ISlider;
	/**
	 * ScrollTrack, ScrollBar 의 확장 인터페이스
	 * @author SSen
	 */
	public interface IScroller extends ISlider 
	{
		/** scroll container */
		function get container() : IScrollContainer
		function set container(container : IScrollContainer) : void
		/** thumb / track 의 비율값 */
		function get sight() : Number
		/** 
		 * page (화면의 보여지는 영역이 한페이지) 단위로 이동합니다
		 * @param delta 몇 페이지를 어느 방향으로 이동시킬지 지정합니다, 상방향 이동은 -1 등으로 지정
		 */
		function page(delta : int) : void
	}
}
