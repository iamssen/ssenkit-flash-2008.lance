package  
{
	import lance.core.date.DateFormatter;	
	import lance.core.number.NumberEx;	
	import lance.core.graphics.LanceSprite;

	/**
	 * @author SSen
	 */
	public class DateCalc extends LanceSprite 
	{
		public const MICROTIME_1SECOND : int = 1000;
		public const MICROTIME_1MINUTE : int = 60000;
		public const MICROTIME_1HOUR : int = 3600000;
		public const MICROTIME_1DAY : int = 86400000;
		public const MICROTIME_1WEEK : int = 604800000;

		public function DateCalc()
		{
			super();
			
			trace(stage.getChildByName("root1"));
			
			var d1 : Date = new Date(2007, 10 - 1, 24, 10, 30, 20);
			var d2 : Date = new Date(2008, 5 - 1, 12, 11, 20, 40);
			
			// 몇 달 차이인지 계산
			var x1 : int = ((d2.fullYear - d1.fullYear) * 12) + ((d2.month - d1.month));
			/*
			 * 10 --> 11월 부터
			 * 11, 12, 1, 2, 3, 4, 5 = 7개월
			 */
			trace(x1);
			
			// 특정 기간동안 월납비 내는날이 몇번 발생하는지를 체크
			var x2 : int = x1 + 1; 
			// 몇달 차이인지 계산하고, 최초월 스스로를 계산해 넣기 위해 1을 더한다
			var day : int = 30;
			if (d1.date < day) x2--; 
			// d1 최초일이 이미 지났다면 1을 빼고
			if (d2.date < day) x2--; 
			// d2 의 마감일이 날보다 작아 그 이전에 먼저 끝난다면 1을 더 뺀다
			trace(x2);
			
			// 시작일로부터 월납비를 내면 끝나는 날이 몇일인지 계산
			var end : Date = new Date(d1.fullYear, d1.month, day, d1.hours, d1.minutes, d1.seconds);
			var m : int = 6;
			if (d1.date > end.date) { 
				// d1 의 날짜가 이미 지나갔으면 (end 보다 더 크다면) 월을 다음달로 넘긴다
				end.month++;
			}
			end.month += m - 1; 
			// 최초월 스스로를 카운트 해야 하기 때문에 1을 뺀다
			trace(end.fullYear, end.month + 1, end.date);
			
			trace("======================================================");
			
			trace(DateFormatter.formatting(d1));
			trace(DateFormatter.formatting(d1, "YY MMMM D NN S"));
		}
	}
}
