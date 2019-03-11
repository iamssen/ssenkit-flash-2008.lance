package lance.component.parts 
{
	import fl.motion.easing.Quadratic;
	
	import gs.TweenLite;
	
	import lance.component.skin.ToolTipSkin;
	import lance.core.contents.Content;
	import lance.core.events.LanceEvent;
	import lance.core.geom.Position9;
	import lance.core.graphics.LanceSprite;
	import lance.core.text.TextStyle;
	import lance.lance;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;	
	use namespace lance;

	/** @copy lance.core.events.LanceEvent#ENABLE */
	[Event(name="enable", type="lance.core.events.LanceEvent")]

	/** @copy lance.core.events.LanceEvent#DISABLE */
	[Event(name="disable", type="lance.core.events.LanceEvent")]

	/** @copy lance.core.events.LanceEvent#RESIZE */
	[Event(name="resize", type="lance.core.events.LanceEvent")]
	/**
	 * LanceComponent 기본형
	 * @author SSen
	 */
	public class LanceComponent extends LanceSprite 
	{
		private var _eventEnabled : Boolean;
		private var _enabled : Boolean = true;
		private var _tooltip : ToolTip;
		/** component width storage */
		protected var _width : int;
		/** component height storage */
		protected var _height : int; 

		public function LanceComponent(width : int = 0, height : int = 0)
		{
			_width = (width <= 0) ? 100 : width;
			_height = (height <= 0) ? 100 : height;
			
			focusRect = false;
			tabChildren = false;
			tabEnabled = false;
			
			// scale = 1
			scaleX = scaleY = 1;
		}
		/* *********************************************************************
		 * Interface setter
		 ********************************************************************* */
		/** 
		 * component 의 활성, 비활성
		 * @default true
		 * @see lance.component.events.ComponentEvent#ENABLED
		 * @see lance.component.events.ComponentEvent#DISABLED
		 */
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		public function set enabled(bool : Boolean) : void
		{
			_enabled = bool;
			if (bool) {
				mouseEnabled = true;
				mouseChildren = true;
				dispatchEvent(new LanceEvent(LanceEvent.ENABLE));
				if (tabEnabled && tabIndex > 0) {
					tabChildren = true;
					tabEnabled = true;
				}
			} else {
				mouseEnabled = false;
				mouseChildren = false;
				dispatchEvent(new LanceEvent(LanceEvent.DISABLE));
				tabChildren = false;
				tabEnabled = false;
			}
		}
		/** width */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			dispatchEvent(new LanceEvent(LanceEvent.RESIZE));
		}
		/** height */
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			dispatchEvent(new LanceEvent(LanceEvent.RESIZE));
		}
		/* *********************************************************************
		 * Interface Methods and getter
		 ********************************************************************* */
		/** control 내부의 리소스들을 제거한다, null 처리 이전에 실행해주면 좋다. */
		public function kill() : void
		{
		}
		/** 이벤트의 활성화 여부 */
		public function get eventEnabled() : Boolean
		{
			return _eventEnabled;
		}
		/**
		 * tooltip 을 보여준다.
		 * @param content tooltip 의 내용, String, DisplayObject, BitmapData 가 허용된다.
		 * @param mouseMode 마우스를 중심으로 나타날 것인가, 컴포넌트를 중식으로 나타날 것인가를 결정
		 * @param position9 tooltip 의 position9 위치 #lance.core.geom.Position9
		 * @param skin tooltip 의 스킨
		 * @param alpha tooltip 의 투명도
		 * @param contentWidth String 일때 TextField 의 크기를 조절한다.
		 * @param closeButton 닫음 버튼을 보여준다, mouseMode 가 true 일때나 skin 에 closeButton 이 null 이면 false 로 자동 조정된다
		 */
		public function tooltipOpen(content : Content, skin : ToolTipSkin, style : TextStyle = null, mouseMode : Boolean = false, position9 : String = Position9.TR, alpha : Number = 1, contentWidth : int = -1, closeButton : Boolean = false) : void
		{
			if (_tooltip == null) {
				if (mouseMode || !skin.isCloseButton) closeButton = false;
				_tooltip = new ToolTip(content, skin, mouseMode, position9, style, contentWidth, closeButton);
				_tooltip.alpha = alpha;
				_tooltip.alpha = 0;
				stage.addChild(_tooltip);
				tooltipXY();
				
				if (_tooltip.mouseMode) stage.addEventListener(MouseEvent.MOUSE_MOVE, tooltipMouseMove, false, 0, true);
				if (closeButton) _tooltip.addEventListener(LanceEvent.CLOSE, tooltipOff, false, 0, true);
				TweenLite.to(_tooltip, 0.3, {alpha:alpha, ease:Quadratic});
			}
		}
		/** tooltip 을 종료한다 */ 
		public function tooltipOff(event : Event = null) : void
		{
			if (_tooltip != null) {
				if (_tooltip.mouseMode) stage.removeEventListener(MouseEvent.MOUSE_MOVE, tooltipMouseMove);
				if (_tooltip.hasEventListener(LanceEvent.CLOSE)) _tooltip.removeEventListener(LanceEvent.CLOSE, tooltipOff);
				stage.removeChild(_tooltip);
				_tooltip = null;
			}
		}
		// tooltip 의 위치를 조절한다.
		private function tooltipXY() : void
		{
			var rect : Rectangle;
			var p : Point;
			var position9 : String = _tooltip.position9;
			if (_tooltip.mouseMode) {
				rect = new Rectangle(stage.mouseX - 1, stage.mouseY - 1, 10, 10);
			} else {
				p = globalPosition;
				switch (position9) {
					case Position9.TL :
					case Position9.BL :
					case Position9.TR :
					case Position9.BR :
						var blank : int = width >> 2;
						rect = new Rectangle(p.x + blank, p.y, width - (blank * 2), height);
						break;
					default :
						rect = new Rectangle(p.x, p.y, width, height);
						break;
				}
			}
			p = getTooltipXY(rect, position9, _tooltip.width, _tooltip.height);
			if (isObjectBehindX(p.x, _tooltip.width, stage.stageWidth)) {
				position9 = Position9.reverseX(position9);
				p = getTooltipXY(rect, position9, _tooltip.width, _tooltip.height);
			}
			if (isObjectBehindY(p.y, _tooltip.height, stage.stageHeight)) {
				position9 = Position9.reverseY(position9);
				p = getTooltipXY(rect, position9, _tooltip.width, _tooltip.height);
			}
			if (p.x < 0) {
				p.x = 5;
			} else if (p.x + _tooltip.width > stage.stageWidth) {
				p.x = stage.stageWidth - _tooltip.width - 5;
			}
			if (p.y < 0) {
				p.y = 5;
			} else if (p.y + _tooltip.height > stage.stageHeight) {
				p.x = stage.stageHeight - _tooltip.height - 5;
			}
			_tooltip.x = p.x;
			_tooltip.y = p.y;
		}
		// tooltip 의 xy 위치를 계산한다.
		private function getTooltipXY(rect : Rectangle, position9 : String, width : int, height : int) : Point
		{
			var x : int;
			var y : int;
			const B : int = 5;
			switch (position9) {
				case Position9.TL :
				case Position9.ML :
				case Position9.BL :
					x = rect.x - width - B;
					break;
				case Position9.TC :
				case Position9.MC :
				case Position9.BC :
					x = ((rect.width >> 1) - (width >> 1)) + rect.x;
					break;
				case Position9.TR :
				case Position9.MR :
				case Position9.BR :
					x = rect.x + rect.width + B;
					break;
			}
			switch (position9) {
				case Position9.TL :
				case Position9.TC :
				case Position9.TR :
					y = rect.y - height - B;
					break;
				case Position9.ML :
				case Position9.MC :
				case Position9.MR :
					y = ((rect.height >> 1) - (height >> 1)) + rect.y;
					break;
				case Position9.BL :
				case Position9.BC :
				case Position9.BR :
					y = rect.y + rect.height + B;
					break;
			}
			
			return new Point(x, y);
		}
		// mouse move handler
		private function tooltipMouseMove(event : MouseEvent) : void
		{
			tooltipXY();
		}
		/* *********************************************************************
		 * Event 
		 ********************************************************************* */
		/** 이벤트의 활성화 */
		lance function eventOn() : void
		{
			_eventEnabled = true;
		}
		/** 이벤트의 비활성화 */
		lance function eventOff() : void
		{
			_eventEnabled = false;
		}
	}
}
