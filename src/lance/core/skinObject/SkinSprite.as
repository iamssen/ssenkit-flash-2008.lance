package lance.core.skinObject 
{
	import lance.core.skinObject.SkinMode;	
	
	import flash.display.DisplayObject;	

	import lance.core.graphics.LanceSprite;
	import lance.core.skinObject.ISkinObject;
	/**
	 * SkinObject : 여러장의 DisplayObject 를 SkinMode 에 따라 보여준다
	 * @author SSen
	 */
	public class SkinSprite extends LanceSprite implements ISkinObject 
	{
		private var _display : DisplayObject;
		private var _skins : Array;
		private var _flag : String;

		public function SkinSprite(skins : Array)
		{
			super();
			_display = skins[SkinMode.DEFAULT];
			_skins = skins;
			_flag = SkinMode.DEFAULT;
			addChild(_display);
		}
		/** @copy lance.component.skin.ISkinObject#skinning() */
		public function skinning(modeName : String = SkinMode.DEFAULT) : void
		{
			if (_flag != modeName) {
				var child : DisplayObject = _skins[modeName];
				addChildTo(child, _display);
				_display = child;
				_flag = modeName;
			}
		}
		/** @copy lance.component.skin.ISkinObject#flag */
		public function get flag() : String
		{
			return _flag;
		}
		/** @copy lance.component.skin.ISkinObject#skinList */
		public function get skinList() : Array
		{
			var arr : Array = new Array();
			var name : String;
			for (name in _skins) {
				arr.push(name);
			}
			return arr;
		}
	}
}
