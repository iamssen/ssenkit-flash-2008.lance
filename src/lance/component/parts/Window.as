package lance.component.parts 
{
	import lance.component.skin.WindowSkin;
	import lance.core.contents.Content;
	import lance.core.events.LanceEvent;
	import lance.core.graphics.FavoriteColorMatrix;
	import lance.core.skinObject.SkinLabel;
	import lance.core.skinObject.SkinMode;
	import lance.core.text.TextStyle;
	
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;		

	/** @copy lance.core.events.LanceEvent#ENABLE */
	[Event(name="enable", type="lance.core.events.LanceEvent")]

	/** @copy lance.core.events.LanceEvent#DISABLE */
	[Event(name="disable", type="lance.core.events.LanceEvent")]
	/**
	 * Window Object
	 * @author SSen
	 */
	public class Window extends AbstPanel
	{
		private var _label : SkinLabel;
		private var _enabled : Boolean;

		public function Window(content : Content,
								skin : WindowSkin,
								label : SkinLabel = null,
								textStyle : TextStyle = null,
								textFieldWidth : int = -1,
								closeButton : Boolean = true,
								enabled : Boolean = true
								)
		{
			super(content, skin, textStyle, textFieldWidth, closeButton);
			
			mouseEnabled = false;
			mouseChildren = true;
			tabChildren = false;
			tabEnabled = false;
			
			_label = label;
			_enabled = enabled;
			
			align();
		}
		/** 활성, 비활성 */
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		public function set enabled(enabled : Boolean) : void
		{
			_enabled = enabled;
			
			if (enabled) {
				_bg.skinning(SkinMode.DEFAULT);
				_label.skinning(SkinMode.DEFAULT);
				_closeButton.enabled = true;
				_content.filters = null;
				_content.alpha = 1;
				mouseChildren = true;
				dispatchEvent(new LanceEvent(LanceEvent.ENABLE));
			} else {
				_bg.skinning(SkinMode.DISABLE);
				_label.skinning(SkinMode.DISABLE);
				_closeButton.enabled = false;
				_content.filters = [new ColorMatrixFilter(FavoriteColorMatrix.GRAY)];
				_content.alpha = 0.5;
				mouseChildren = false;
				dispatchEvent(new LanceEvent(LanceEvent.DISABLE));
			}
		}
		/** @private */
		protected override function align() : void
		{
			super.align();
			
			if (_label != null) {
				_label.x = skin.panel_titleGrid.left;
				_label.y = skin.panel_titleGrid.top;
				addChild(_label);
				
				_label.filters = [new DropShadowFilter(1, 45, 0, 0.4, 2, 2)];
			}
			if (_closeButton != null) {
				_closeButton.x = _bg.width - _closeButton.width - skin.panel_titleGrid.right;
				_closeButton.y = skin.panel_titleGrid.top;
				if (_closeButton.height < skin.panel_titleGrid.height) {
					_closeButton.y += (skin.panel_titleGrid.height >> 1) - (_closeButton.height >> 1);
				}
				addChild(_closeButton);
			}
			
			var width : int = _bg.width - skin.panel_innerGrid.left - skin.panel_innerGrid.right;
			if (_closeButton != null) width -= _closeButton.width - 2;
			_label.width = width;
			
			enabled = _enabled;
		}
		private function get skin() : WindowSkin
		{
			return _skin as WindowSkin;
		}
	}
}
