package  
{
	import flash.display.DisplayObject;	
	
	import lance.core.array.Values;	
	import lance.core.array.VectorCompareFunctions;	

	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;	
	/**
	 * @author SSen
	 */
	public class VectorTest extends Sprite 
	{
		public function VectorTest()
		{
			var vi : Vector.<int> = new Vector.<int>();
			var vs : Vector.<String> = new Vector.<String>();
			var vd : Vector.<DisplayObject> = new Vector.<DisplayObject>();
			trace(getQualifiedSuperclassName(vi), getQualifiedSuperclassName(vs), getQualifiedSuperclassName(vd));
			
			var vec : Vector.<int> = new Vector.<int>();
			vec.push(50, 20, 30);
			trace(vec);
			
			vec.sort(VectorCompareFunctions.ASC_NUMBER);
			trace(vec);
			vec.sort(VectorCompareFunctions.DESC_NUMBER);
			trace(vec);
			
			trace(getQualifiedClassName(vec), getQualifiedSuperclassName(vec));
			
			var vec2 : Vector.<String> = new Vector.<String>();
			vec2.push("가나다", "나나나", "abcd");
			trace(vec2);
			vec2.sort(VectorCompareFunctions.DESC_STRING);
			trace(vec2);
			vec2.sort(VectorCompareFunctions.ASC_STRING);
			trace(vec2);
			vec2.sort(VectorCompareFunctions.SHAKE);
			trace(vec2);
			vec2.sort(VectorCompareFunctions.SHAKE);
			trace(vec2);
			vec2.sort(VectorCompareFunctions.SHAKE);
			trace(vec2);
			trace(getQualifiedClassName(vec2), getQualifiedSuperclassName(vec2));
			
			var vec3 : Vector.<Number> = new Vector.<Number>();
			trace(getQualifiedClassName(vec3), getQualifiedSuperclassName(vec3));
			
			var arr : Array = [1,2,3,4,5];
			var vec4 : Vector.<int> = Vector.<int>(arr);
			trace(getQualifiedClassName(vec4), vec4);
			
			var v : Values = new Values();
			v["a"] = 15;
			v["b"] = 24;
			v["c"] = 45;
			v["d"] = 15;
			trace(v);
			
			trace("find :", v.findIndexByValue(15), getQualifiedClassName(v.findIndexByValue(15)));
			
			v.length = 2;
			trace(v);
			
			for (var i:int = 0; i < v.length; i++) {
				trace("v for :", i, v[i], v.getNameAt(i), v.getIndexByName(v.getNameAt(i)));
			}

			trace(v.getXMLAttributes(<item />).toXMLString());
			
			var x : XML = <testNode />;
			x.setChildren(v.getXMLChildren());
			trace(x.toXMLString());
			
		}
	}
}
