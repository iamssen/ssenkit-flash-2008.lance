package examples.text 
{
	import examples.Example;
	/**
	 * XML 의 search 예제
	 * @author SSen
	 */
	public class XMLSearch extends Example 
	{
		private var xml : XML = <xml>
									<a bbb="123" />
									<a ccc="223" />
									<a>
										<bb>35</bb>
										<bb cc="125">Schall</bb>
										<bb>Smith</bb>
										<bb>Schala</bb>
										<cc aa="123">55</cc>
									</a>
									<a bbb="145" />
									<a bbb="1234" />
									<bb>66</bb>
								</xml>;

		public function XMLSearch()
		{
			var xlist : XMLList = xml.*;
			tracer("정규식을 사용한 노드네임 검사", xlist.(new RegExp("b.*?", "")["test"](name())).toXMLString());
			xlist = xml.a.bb;
			tracer("정규식을 사용한 노드밸류 검사", xlist.(new RegExp("Sch.*?", "")["test"](toString())).toXMLString());
			xlist = xml.a;
			tracer("어트리뷰트 네임 검사", xlist.attribute("bbb").toXMLString());
			xlist = xml.a.*;
			tracer("정규식을 사용한 어트리뷰트 밸류 검사", xlist.(new RegExp("12.*?", "")["test"](attributes())).toXMLString());
			xlist = xml.a[2].cc;
			tracer("어트리뷰트 밸류 검사", xlist.(@aa == "123"));
			xlist = xml..bb;
			tracer("특정 이름의 노드리스트에서 밸류검사", xlist.(new RegExp("Schala", "")["test"](toString())).toXMLString());
		}
	}
}
