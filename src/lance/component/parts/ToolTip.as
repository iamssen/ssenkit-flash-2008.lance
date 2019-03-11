package lance.component.parts 
{
	import lance.core.contents.Content;	
	import lance.core.text.TextStyle;	
	import lance.component.skin.ToolTipSkin;
	/**
	 * ToolTip Component Skin
	 * @author SSen
	 */
	public class ToolTip extends AbstPanel 
	{
		private var _mouseMode : Boolean;
		private var _position9 : String;

		/**
		 * tooltip
		 * @param content tooltip 의 내용, String, DisplayObject, BitmapData 가 허용된다.
		 * @param mouseMode 마우스를 중심으로 나타날 것인가, 컴포넌트를 중식으로 나타날 것인가를 결정
		 * @param position9 tooltip 의 position9 위치 #lance.core.geom.Position9
		 * @param skin tooltip 의 스킨
		 * @param textFieldWidth String 일때 TextField 의 가로 크기
		 * @param textStyle String 일때 TextField 의 Style
		 * @param closeButton 닫음 버튼은 넣을지 여부
		 */
		public function ToolTip(content : Content, 
								skin : ToolTipSkin,
								mouseMode : Boolean, 
								position9 : String,
								textStyle : TextStyle = null,
								textFieldWidth : int = -1,
								closeButton : Boolean = false
								)
		{
			super(content, skin, textStyle, textFieldWidth, closeButton);
			
			// 인터렉티브 설정
			if (!closeButton || mouseMode) {
				mouseChildren = false;
			}
			mouseEnabled = false;
			tabChildren = false;
			tabEnabled = false;
			
			// 부가정보 설정
			_mouseMode = mouseMode;
			_position9 = position9;
			
			align();
		}
		/** @private */
		protected override function align() : void
		{
			super.align();
			if (_closeButton != null) {
				_closeButton.x = _bg.width - _closeButton.width - skin.panel_innerGrid.right;
				_closeButton.y = skin.panel_innerGrid.top;
				addChild(_closeButton);
			}
		}
		/** 마우스를 중심으로 나타날 것인가, 컴포넌트를 중식으로 나타날 것인가 */
		public function get mouseMode() : Boolean
		{
			return _mouseMode;
		}
		/** tooltip 의 position9 위치 #lance.core.geom.Position9 */
		public function get position9() : String
		{
			return _position9;
		}
		private function get skin() : ToolTipSkin
		{
			return _skin as ToolTipSkin;
		}
	}
}
