package lance.core.skinObject 
{
	import lance.core.skinObject.SkinMode;	
	import lance.core.skinObject.ISkinObject;
	import lance.core.graphics.GridSprite;
	/**
	 * SkinObject : 여러장의 GridBitmap 을 SkinMode 에 따라 보여준다
	 * @author SSen
	 */
	public class SkinGridSprite extends GridSprite implements ISkinObject 
	{
		private var _skins : Array;
		private var _flag : String;

		public function SkinGridSprite(skins : Array)
		{
			super(skins[SkinMode.DEFAULT]);
			_skins = skins;
			_flag = SkinMode.DEFAULT;
		}
		/** @copy lance.component.skin.ISkinObject#skinning() */
		public function skinning(modeName : String = SkinMode.DEFAULT) : void
		{
			gridBitmap = _skins[modeName];
			_flag = modeName;
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
