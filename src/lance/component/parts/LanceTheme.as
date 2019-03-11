package lance.component.parts 
{
	import flash.utils.Dictionary;	

	import lance.component.skin.LanceSkin;	
	/**
	 * @author SSen
	 */
	public class LanceTheme 
	{
		/** theme 의 저장소 */
		static protected var themeCollection : Dictionary = new Dictionary(true);
		/** 기본 theme 의 이름, 해당 이름의 theme 는 필수적으로 있어야함 */
		static private const DEFAULT_THEME_NAME : String = "DefaultTheme";

		/** theme 을 가져온다 */
		static public function getTheme(themeName : String) : LanceTheme
		{
			if (hasTheme(themeName)) {
				return themeCollection[themeName];
			} else {
				return themeCollection[DEFAULT_THEME_NAME];
			}
		}
		/** theme 이 존재하는지 확인한다 */
		static public function hasTheme(themeName : String) : Boolean
		{
			return (themeCollection[themeName] != undefined) ? true : false;
		}

		/** skin 의 저장소 */
		protected var skinCollection : Dictionary;

		public function LanceTheme()
		{	
		}
		/** skin 들을 수동생성 하는 곳 */
		protected function create() : void
		{
			skinCollection = new Dictionary(true);
		}
		/** skin 을 가져온다 */
		public function getSkin(componentName : String) : LanceSkin
		{
			return skinCollection[componentName];
		}
		/** skin 이 존재하는지 확인한다 */
		public function hasSkin(componentName : String) : Boolean
		{
			return (skinCollection[componentName] != undefined) ? true : false;
		}
	}
}
