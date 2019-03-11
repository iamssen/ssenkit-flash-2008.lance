package lance.component.skin 
{
	import lance.core.skinObject.BitmapSplitSet;	
	
	import flash.display.BitmapData;

	/**
	 * ToolTipSkin
	 * @author SSen
	 */
	public class ToolTipSkin extends PanelSkin 
	{
		public function ToolTipSkin(skinBitmap : BitmapData, closeButton : BitmapSplitSet = null)
		{
			super(skinBitmap, closeButton);
		}
	}
}
