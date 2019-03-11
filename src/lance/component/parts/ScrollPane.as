package lance.component.parts 
{
	import flash.display.DisplayObject;	

	import lance.component.skin.ScrollBarSkin;	
	import lance.component.properties.DirectionMode;	
	import lance.component.ScrollBar;	
	import lance.core.contents.Content;		
	/**
	 * @author SSen
	 */
	public class ScrollPane extends AbstScrollPane 
	{
		public function ScrollPane(skin : ScrollBarSkin, directionMode : String, content : Content, width : int = 200, height : int = 200)
		{
			super(skin, width, height);
			
			_container = new ScrollContainer(content.getDisplayObject(), width, height);
			addChild(_container);
			if (directionMode == DirectionMode.VERTICAL_AND_HORIZONTAL || directionMode == DirectionMode.VERTICAL) {
				_scrollV = new ScrollBar(skin, _container, 15, _height, DirectionMode.VERTICAL);
				trace(_scrollV.width, _scrollV.height);
				addChild(DisplayObject(_scrollV));
			}
			if (directionMode == DirectionMode.VERTICAL_AND_HORIZONTAL || directionMode == DirectionMode.HORIZONTAL) {
				_scrollH = new ScrollBar(skin, _container, _width, 15, DirectionMode.HORIZONTAL);
				addChild(DisplayObject(_scrollH));
			}
			_directionMode = directionMode;
			trace(_scrollV, _scrollH);
			
			resize();
		}
	}
}
