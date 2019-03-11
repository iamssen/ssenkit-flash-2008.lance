package lance.component.parts 
{
	import lance.component.parts.AbstButton;
	import lance.component.properties.ButtonType;
	import lance.core.array.Values;
	import lance.core.skinObject.ISkinObject;
	import lance.lance;		
	
	use namespace lance;
	/**
	 * @author SSen
	 */
	public class AbstListCell extends AbstButton implements IListCell
	{
		protected var _content : ISkinObject;
		protected var _values : Values;
		private var _id : int;

		public function AbstListCell(width : int = 0, height : int = 0, content : ISkinObject = null)
		{
			super(null, width, height, ButtonType.NORMAL); 
			_content = content;
			_values = new Values();
		}
		/** @private */
		override public function kill() : void
		{
			eventOff();
			_content = null;
		}
		/** @private */
		override lance function skinning(modeName : String = null) : void
		{
			if (modeName != null) _skinMode = modeName;
			super.skinning(_skinMode);
			_content.skinning(_skinMode);
		}
		/** @copy lance.component.parts.IListCell#searchValue() */
		public function searchValue(valueName : String, text : String) : Boolean
		{
			var reg : RegExp = new RegExp(text, "g");
			return reg.test(_values[name]);
		}
		/** @copy lance.component.parts.IListCell#findValue() */
		public function findValue(valueName : String, text : String) : Boolean
		{
			return _values[name] == text;
		}
		/** @copy lance.component.parts.IListCell#values */
		public function get values() : Values
		{
			return _values;
		}
		public function set values(values : Values) : void
		{
			_values = values;
		}
		/** @copy lance.component.parts.IListCell#valuesXML */
		public function get valuesXML() : XML
		{
			var xml : XML = <cell />;
			var f : String;
			for (f in _values) {
				xml["@" + f] = _values[f];
			}
			return xml;
		}
		public function preCell() : IListCell
		{
			if (parent != null && parent is IList) {
				return IList(parent).preCell(this);
			}
			return null;
		}
		public function nextCell() : IListCell
		{
			if (parent != null && parent is IList) {
				return IList(parent).nextCell(this);
			}
			return null;
		}
		public function get id() : int
		{
			return _id;
		}
		public function set id(id : int) : void
		{
			_id = id;
		}
		public function get minHeight() : Number
		{
			return 0;
		}
		public function get minWidth() : Number
		{
			return 0;
		}
	}
}
