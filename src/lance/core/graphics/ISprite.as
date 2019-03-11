package lance.core.graphics 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.text.TextSnapshot;
	import flash.ui.ContextMenu;
	
	import lance.core.graphics.IDisplayObject;		
	/**
	 * @author SSen
	 */
	public interface ISprite extends IDisplayObject 
	{
		function get contextMenu() : ContextMenu;
		function set contextMenu(menu : ContextMenu) : void;
		function get doubleClickEnabled() : Boolean;
		function set doubleClickEnabled(bool : Boolean) : void;
		function get focusRect() : Object;
		function set focusRect(obj : Object) : void;
		function get mouseEnabled() : Boolean;
		function set mouseEnabled(bool : Boolean) : void;
		function get tabEnabled() : Boolean;
		function set tabEnabled(bool : Boolean) : void;
		function get tabIndex() : int;
		function set tabIndex(value : int) : void;
		function get mouseChildren() : Boolean;
		function set mouseChildren(bool : Boolean) : void;
		function get numChildren() : int;
		function get tabChildren() : Boolean;
		function set tabChildren(bool : Boolean) : void;
		function get textSnapshot() : TextSnapshot;
		function addChild(child : DisplayObject) : DisplayObject;
		function addChildAt(child : DisplayObject, index : int) : DisplayObject; 
		function areInaccessibleObjectsUnderPoint(point : Point) : Boolean ;
		function contains(child : DisplayObject) : Boolean ;
		function getChildAt(index : int) : DisplayObject ;
		function getChildByName(name : String) : DisplayObject; 
		function getChildIndex(child : DisplayObject) : int ;
		function getObjectsUnderPoint(point : Point) : Array ;
		function removeChild(child : DisplayObject) : DisplayObject; 
		function removeChildAt(index : int) : DisplayObject ;
		function setChildIndex(child : DisplayObject, index : int) : void; 
		function swapChildren(child1 : DisplayObject, child2 : DisplayObject) : void; 
		function swapChildrenAt(index1 : int, index2 : int) : void
		function get buttonMode() : Boolean;
		function set buttonMode(bool : Boolean) : void;
		function get dropTarget() : DisplayObject;
		function get graphics() : Graphics; 
		function get hitArea() : Sprite;
		function set hitArea(value : Sprite) : void;
		function get soundTransform() : SoundTransform;
		function set soundTransform(transform : SoundTransform) : void;
		function get useHandCursor() : Boolean;
		function set useHandCursor(bool : Boolean) : void;
		function startDrag(lockCenter : Boolean = false, bounds : Rectangle = null) : void;
		function stopDrag() : void;
	}
}
