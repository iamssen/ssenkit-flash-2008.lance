package lance.component 
{
	import lance.component.skin.LanceSkin;	
	import lance.core.skinObject.BitmapSplitSet;	
	import lance.core.skinObject.SkinMode;	
	import lance.core.skinObject.SkinBitmapSplit;
	import lance.component.parts.AbstButton;
	import lance.lance;
	use namespace lance;
	/**
	 * 간단한 BitmapSplit 버튼
	 * @author SSen
	 */
	public class BitmapSplitButton extends AbstButton 
	{
		public static const NAME_SET : Array = [SkinMode.DEFAULT, SkinMode.OVER, SkinMode.ACTION, SkinMode.DISABLE];
		private var _bs : SkinBitmapSplit;

		/**
		 * 생성자
		 * @param splitSet bitmapSplitButton 에 필요한 bitmapSplitSet
		 * @param buttonType button 의 작동 방식
		 */
		public function BitmapSplitButton(splitSet : BitmapSplitSet, buttonType : String = "normal")
		{
			super(null, splitSet.width, splitSet.height, buttonType);
			_bs = new SkinBitmapSplit(splitSet);
			addChild(_bs);
			
			init();
			eventOn();
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		override public function set skin(skin : LanceSkin) : void
		{
			throw new Error("BitmapSplitButton 은 LanceSkin 을 지원하지 않습니다. bitmapSplitSet 멤버를 사용해주세요.");
		}
		/** bitmapSplitSet 을 통해 스킨을 교체한다 */
		public function setBitmapSplitSet(splitSet : BitmapSplitSet) : void
		{
			var bs : SkinBitmapSplit = new SkinBitmapSplit(splitSet);
			addChildTo(bs, _bs);
			_bs = bs;
			skinning();
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			super.width = value;
			_bs.width = value;
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			super.height = value;
			_bs.height = value;
		}
		/** @private */
		override public function kill() : void
		{
			eventOff();
			_bs = null;
		}
		/** @private */
		override lance function skinning(modeName : String = null) : void
		{
			if (modeName != null) _skinMode = modeName;
			super.skinning(_skinMode);
			_bs.skinning(_skinMode);
		}
	}
}
