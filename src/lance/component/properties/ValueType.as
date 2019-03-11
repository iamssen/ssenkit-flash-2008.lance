package lance.component.properties 
{
	/**
	 * 데이터 타입들
	 * @author SSen
	 */
	public class ValueType 
	{
		/** 문자형 데이터 */
		static public const STRING : String = "string";
		/** 숫자형 데이터 */
		static public const NUMBER : String = "number";
		/** 참, 거짓 타입 데이터 */
		static public const BOOLEAN : String = "boolean";
		/** 날짜 19800721 형태의 숫자 데이터 */
		static public const DATE_YYYYMMDD : String = "dateYYYYMMDD";
		/** 컬러 ffffff 형태의 16진수 숫자 데이터 */
		static public const COLOR_HEX : String = "colorHex";
		/** Values (연관배열 형식) 의 데이터 */
		static public const VALUES : String = "values";
		/** Vector 형식의 데이터 */
		static public const VECTOR : String = "vector";
		/** XML 형식의 데이터 */
		static public const XML : String = "xml";
	}
}
