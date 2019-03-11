package lance.core.text 
{
	import flash.text.TextFormat;	
	/**
	 * FavoriteTextFormats
	 * @author SSen
	 */
	public class FavoriteTextFormats 
	{
		/**
		 * 돋움 11px 로 된 기본 글씨
		 * @param color 색상
		 * @param bold 굵기
		 */
		public static function dotum11px(color : uint = 0xaaaaaa, bold : Boolean = false) : TextFormat
		{
			return new TextFormat("돋움", 11, color, bold);
		}
	}
}
