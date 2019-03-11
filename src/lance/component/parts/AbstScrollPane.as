package lance.component.parts 
{
	import lance.component.parts.LanceSkinComponent;
	import lance.component.properties.DirectionMode;
	import lance.component.skin.LanceSkin;		
	/**
	 * @author SSen
	 */
	public class AbstScrollPane extends LanceSkinComponent 
	{
		protected var _container : ScrollContainer;
		protected var _scrollV : IScroller;
		protected var _scrollH : IScroller;
		protected var _directionMode : String;

		public function AbstScrollPane(skin : LanceSkin, width : int = 0, height : int = 0)
		{
			super(skin, width, height);
		}
		
		protected function resize() : void
		{
			switch (_directionMode) {
				case DirectionMode.VERTICAL_AND_HORIZONTAL :
					trace(_scrollV.width, _scrollV.height, _scrollH.width, _scrollH.height);
					_container.width = _width - _scrollV.width;
					_container.height = _height - _scrollH.height;
					trace(_scrollV.width, _scrollV.height, _scrollH.width, _scrollH.height);
					_scrollV.height = _container.height;
					trace(_scrollV.width, _scrollV.height, _scrollH.width, _scrollH.height);
					_scrollH.width = _container.width;
					_scrollV.x = _container.width;
					_scrollH.y = _container.height;
					trace(_scrollV.width, _scrollV.height, _scrollH.width, _scrollH.height);
					break; 
				case DirectionMode.VERTICAL :
					_container.width = _width - _scrollV.width;
					_container.height = _height;
					_scrollV.x = _container.width;
					break; 
				case DirectionMode.HORIZONTAL : 
					_container.width = _width;
					_container.height = _height - _scrollH.height;
					_scrollH.y = _container.height;
					break;
			}
		}
		
		
	}
}
