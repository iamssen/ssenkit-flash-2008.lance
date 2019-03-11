package lance.component.properties
{
	/**
	 * Input 의 입력형태 상수들
	 * @author SSen
	 */
	public class InputType 
	{
		/** 보통 입력 */
		static public const NORMAL : String = "normal";
		/** 숫자 입력, 넘패드 지원 */
		static public const NUMBER : String = "number";
		/** 제한값이 존재하는 숫자입력, 슬라이드 지원 */
		static public const NUMBER_SLIDE : String = "numberSlide";
		/** 영문 입력만 됨 */
		static public const ENGLISH : String = "english";
		/** 패스워드, 키로거를 피하기 위해 키입력이 지원됨 */
		static public const PASSWORD : String = "password";
	}
}
