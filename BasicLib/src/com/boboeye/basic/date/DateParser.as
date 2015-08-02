package com.boboeye.basic.date
{
	public class DateParser
	{
		public function DateParser()
		{
		}
		
		public static function parse2Date(str:String):Date{
			var date:Date = new Date();
			date.time = Date.parse(convertDateStr(str));
			return date;
		}
		
		public static function convertDateStr(dateStr:String):String{  
			var strArr:Array = dateStr.split(" ");  
			var fStr:String = "{0} {1} {2}";  
			return format(fStr, (strArr[0] as String).split("-").join("/"), strArr[1], "GMT");  
		}
		
		public static function format(str:String, ...args):String{  
			for(var i:int = 0; i<args.length; i++){  
				str = str.replace(new RegExp("\\{" + i + "\\}", "gm"), args[i]);  
			}  
			return str;  
		}
	}
}