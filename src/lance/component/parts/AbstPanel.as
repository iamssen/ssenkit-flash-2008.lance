package lance.component.parts 
{
	import lance.component.skin.PanelSkin;
	import lance.core.contents.Content;
	import lance.core.contents.ContentType;
	import lance.core.events.LanceEvent;
	import lance.core.graphics.LanceSprite;
	import lance.core.skinObject.SkinGridSprite;
	import lance.core.text.LanceTextField;
	import lance.core.text.TextStyle;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;	

	/*
	 * 단순 컨텐츠 보여주기 기능 AbstPanel --> 닫기버튼 Panel --> 타이틀바 썸네일, 제목, 포커스 하일라이트 Window
	 * 마우스 모드 특화 ToolTip
	 * 
	 */
	
	/** @copy lance.core.events.LanceEvent#CLOSE */
	[Event(name="close", type="lance.core.events.LanceEvent")]
	/**
	 * Panel 의 기본형
	 * @author SSen
	 */
	public class AbstPanel extends LanceSprite 
	{
		/** panel 의 내용 */
		protected var _content : DisplayObject;
		/** panel 의 배경그림 */
		protected var _bg : SkinGridSprite;
		/** skin */
		protected var _skin : PanelSkin;
		/** 닫음 버튼 */
		protected var _closeButton : AbstButton;

		public function AbstPanel(content : Content, skin : PanelSkin, textStyle : TextStyle = null, textFieldWidth : int = -1, closeButton : Boolean = false)
		{
			super();
			
			_bg = skin.panel_bg();
			
			_skin = skin;
			if (!skin.isCloseButton) closeButton = false;
			
			if (content.type != ContentType.STRING) {
				_content = content.getDisplayObject();
			} else {
				if (textStyle == null) textStyle = new TextStyle();
				if (textStyle.color == -1) textStyle.color = skin.content_fontColor;
				content.setTextStyle(textStyle, true, true);
				var txt : LanceTextField = content.getDisplayObject() as LanceTextField;
				txt.autoSize = TextFieldAutoSize.LEFT;
				if (textFieldWidth > 10) {
					txt.width = textFieldWidth;
				}
				_content = txt;
			}
			
			if (closeButton) {
				_closeButton = _skin.panel_closeButton();
				_closeButton.addEventListener(MouseEvent.CLICK, closeButtonClick, false, 0, true);
			}
		}
		/** 닫음 이벤트 리스너, close event 를 이 메서드로 건다 */
		protected function closeButtonClick(event : Event) : void
		{
			dispatchEvent(new LanceEvent(LanceEvent.CLOSE));
		}
		/** 정렬 */
		protected function align() : void
		{
			_bg.width = _content.width + _skin.panel_innerGrid.left + _skin.panel_innerGrid.right;
			_bg.height = _content.height + _skin.panel_innerGrid.top + _skin.panel_innerGrid.bottom;
			addChild(_bg);
			_content.x = _skin.panel_innerGrid.left;
			_content.y = _skin.panel_innerGrid.top;
			addChild(_content);
		}
	}
}
