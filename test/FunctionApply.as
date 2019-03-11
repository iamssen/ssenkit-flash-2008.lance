package  
{
	import flash.utils.Dictionary;	
	import flash.external.ExternalInterface;	
	
	import lance.core.graphics.LanceSprite;
	/**
	 * @author SSen
	 */
	public class FunctionApply extends LanceSprite 
	{
		public function FunctionApply()
		{
			super();
			
			abc.apply(null, [1, 2, 3, 4]);
			ExternalInterface.call.apply(null, ["alert", 1]);
			
			var dic : Dictionary = new Dictionary();
			dic["aaa"] = 1;
			dic["bbb"] = 2;
			
			for each (var c:* in dic) {
				trace(c); 
			}
		}
		private function abc(...rest):void
		{
			trace(rest);
		}
	}
}
