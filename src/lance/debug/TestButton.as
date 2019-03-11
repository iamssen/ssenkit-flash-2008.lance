package lance.debug
{
	import lance.core.number.MathEx;	
	
	import flash.events.MouseEvent;	

		import flash.geom.Point;	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class TestButton extends Sprite
	{
		private var _txt : TextField;
		private var _listener : Function;

		/** 단순 테스트 버튼을 만든다. */
		public function TestButton(str : String, listener : Function)
		{
			super();
			_listener = listener;
			
			this.buttonMode = true;
			
			_txt = getTextfield(str);
			
			var w : int = _txt.width + 10;
			var h : int = _txt.height + 10;
			var m : int = 5;
			 
			var g : Graphics = this.graphics;
			var mat : Matrix = new Matrix();
			mat.createGradientBox(w, h, MathEx.deg2rad(270));
			g.beginGradientFill(GradientType.LINEAR, [0x333333,0x888888], null, [1,255], mat);
			g.moveTo(0, m);
			g.curveTo(0, 0, m, 0);
			g.lineTo(w - m, 0);
			g.curveTo(w, 0, w, m);
			g.lineTo(w, h - m);
			g.curveTo(w, h, w - m, h);
			g.lineTo(m, h);
			g.curveTo(0, h, 0, h - m);
			g.lineTo(0, m);
			g.endFill();
			
			_txt.x = m;
			_txt.y = m;
			
			this.addChild(_txt);
			
			addEventListener(MouseEvent.CLICK, click);
		}
		private function click(event : MouseEvent) : void
		{
			_listener();
		}
		private function getTextfield(str : String) : TextField
		{
			var tf : TextFormat = new TextFormat("돋움", 11, 0xffffff, true);
			tf.align = TextFormatAlign.CENTER;
			
			var txt : TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.defaultTextFormat = tf;
			txt.text = str;
			txt.selectable = false;
			txt.mouseEnabled = false;
			
			return txt;
		}
		/** x+width 의 끝점을 가져온다 */ 
		public function get endX() : int
		{
			return this.x + this.width;
		}
		public function get position() : Point
		{
			var point : Point = new Point();
			point.x = x;
			point.y = y;
			return point;
		}
		public function set position(point : Point) : void
		{
			x = point.x;
			y = point.y;
		}
		public function get endPosition() : Point
		{
			var point : Point = new Point();
			point.x = x + width + 5;
			point.y = y;
			return point;
		}
		public function get endPositionBr() : Point
		{
			var point : Point = new Point();
			point.x = x;
			point.y = y + height + 5;
			return point;
		}
	}
}