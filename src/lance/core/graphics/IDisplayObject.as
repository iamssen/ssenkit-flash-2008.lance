package lance.core.graphics 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	import flash.geom.Transform;		
	/**
	 * @author SSen
	 */
	public interface IDisplayObject extends IEventDispatcher
	{
		/** Alpha */
		function get alpha() : Number;
		function set alpha(value : Number) : void;
		function get blendMode() : String;
		function set blendMode(value : String) : void;
		function get cacheAsBitmap() : Boolean;
		function set cacheAsBitmap(value : Boolean) : void;
		function get filters() : Array;
		function set filters(value : Array) : void;
		function get loaderInfo() : LoaderInfo;
		function get mask() : DisplayObject;
		function set mask(mask : DisplayObject) : void;
		function get mouseX() : Number;
		function get mouseY() : Number;
		function get name() : String;
		function set name(value : String) : void;
		function get parent() : DisplayObjectContainer;
		function get root() : DisplayObject;
		function get stage() : Stage;
		function get rotation() : Number;
		function set rotation(value : Number) : void;
		function get scale9Grid() : Rectangle;
		function set scale9Grid(rect : Rectangle) : void;
		function get scaleX() : Number;
		function set scaleX(value : Number) : void;
		function get scaleY() : Number;
		function set scaleY(value : Number) : void;
		function get scrollRect() : Rectangle;
		function set scrollRect(rect : Rectangle) : void;
		function get transform() : Transform;
		function set transform(transform : Transform) : void;
		function get visible() : Boolean;
		function set visible(value : Boolean) : void;
		/** 가로 사이즈 */
		function get width() : Number;
		function set width(value : Number) : void;
		/** 세로 사이즈 */
		function get height() : Number;
		function set height(value : Number) : void;
		/** 가로 위치 */
		function get x() : Number;
		function set x(value : Number) : void;
		/** 세로 위치 */
		function get y() : Number;
		function set y(value : Number) : void;
	}
}
