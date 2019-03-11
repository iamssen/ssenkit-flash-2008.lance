package  
{
	import lance.debug.DebugRegExp;	
	import lance.core.date.DateFormatter;	
	import lance.core.date.DateEx;	
	
	import flash.display.Sprite;
	/**
	 * @author SSen
	 */
	public class DateFormatterTest extends Sprite 
	{
		public function DateFormatterTest()
		{
			super();
	
			var date : Date = new Date();
			trace(DateEx.dateToDelimiter(date));
			trace(DateEx.dateToNumbers(date));
			trace(DateEx.dateToStrings(date));
			trace(DateEx.dateToYyyymmdd(date));
			trace(DateFormatter.formatting(date, "YYYY MMMM DD S HH A"));
			
			trace(DebugRegExp.isMetaCharacter("["));
			trace(DebugRegExp.isMetaCharacter("]"));
		}
	}
}
