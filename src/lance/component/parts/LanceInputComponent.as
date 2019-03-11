package lance.component.parts 
{
	import lance.component.skin.LanceSkin;	
	import lance.component.parts.IInput;
	/**
	 * Data input 컴포넌트의 최하위
	 * @author SSen
	 */
	public class LanceInputComponent extends LanceSkinComponent implements IInput
	{
		/** value 저장소 */
		protected var _value : Object;
		/** 
		 * valueType 저장소 
		 * @see lance.component.properties.ValueType
		 */
		protected var _valueType : String;

		public function LanceInputComponent(skin : LanceSkin, width : int = 0, height : int = 0, valueType : String = "string")
		{
			super(skin, width, height);
			_valueType = valueType;
		}
		/** @copy lance.component.parts.IInput#value */
		public function get value() : Object
		{
			return _value;
		}
		public function set value(value : Object) : void
		{
			_value = value;
		}
		/** @copy lance.component.parts.IInput#valueType */
		public function get valueType() : String
		{
			return _valueType;
		}
	}
}
