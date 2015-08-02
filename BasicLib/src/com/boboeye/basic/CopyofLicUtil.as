package com.boboeye.basic
{
	public class CopyofLicUtil
	{
		private static var bigSeq:String = "^_^";
		private static var smallSeq:String = "<_>";
		private static var _licInfo:LicInfo;
		private static var _hasLic:Boolean=false;
		public function CopyofLicUtil()
		{
			
		}
		
		private static function decode(str:String):String{
			var result:String = "";
			var len:int = str.length;
			for(var i:int=0;i<len;i+=8){
				var strItem:String = str.substr(i,8);
				var num:Number = Number(strItem);
				num = num/2;
				num = num>>2;
				result +=String.fromCharCode(num);
			}
			return result;
		}
		
		private static function encode(str:String):String{
			var len:int = str.length;
			var result:String = "";
			for(var i:int=0;i<len;i++){
				var num:Number = str.charCodeAt(i);
				var num2:Number = num<<2;
				num2 = num2*2;
				var num2Str:String = num2.toString(); 
				var numLen2:int = num2Str.length;
				if(numLen2<8){
					var cha:int = 8-numLen2;
					for(var j:int=0;j<cha;j++){
						num2Str = "0"+num2Str;
					}
				}
				result +=num2Str;
			}
			return result;
		}
		
		public static function createLicString(host:String,version:String,funcs:Array):String{
			var result:String = null;
			result = host+smallSeq+"localhost"+bigSeq;
			result+= new Date().getTime()+bigSeq;
			result+= version+bigSeq;
			for(var i:int=0;i<funcs.length;i++){
				result+=funcs[i];
				result+=smallSeq;
			}
			result = encode(result);
			return result; 
		}
		
		public static function parserLicString(str:String):LicInfo{
			str = decode(str);
			var arr1:Array = str.split(bigSeq);
			var hostsInfo:String = arr1[0];
			var registTime:Number = Number(arr1[1]);
			var version:String = arr1[2];
			var funcInfo:String = arr1[3];
			var lic:LicInfo = new LicInfo();
			lic.hosts = hostsInfo.split(smallSeq);
			lic.registTime = registTime;
			lic.version = version;
			lic.func = funcInfo.split(smallSeq);
			return lic;
		}
		public static function checkHosts():Boolean{
			var hosts:Array = _licInfo.hosts;
			var currHost:String = WebUtils.Host;
			var result:Boolean = false;
			for(var i:int=0;i<hosts.length;i++){
				if(currHost.indexOf(hosts[i])!=-1){
					result = true;
					break;
				}
			}
			return result;
		}
		public static function checkTime():Boolean{
			var rgTime:Number = _licInfo.registTime;
			var nowtime:Number = new Date().getTime();
			var year:Number = 366*24*60*60*1000;
			var result:Boolean = true;
			if((nowtime-rgTime)>=year){
				result = false;
			}
			return result;
		}
		public static function checkFunc(funcNo:String):Boolean{
			var r1:Boolean = checkHosts();
			var r2:Boolean = checkTime();
			var r3:Boolean = false;
			if(r1&&r2){
				var version:String = _licInfo.version;
				if(version==BasicConst.VERSION_FREE){
					r3 = true;
				}else{
					var func:Array = _licInfo.func;
					for(var i:int=0;i<func.length;i++){
						var funcItem:String = func[i];
						if(funcItem==funcNo){
							r3 = true;
							break;
						}
					}
				}
			}
			return r3;
		}

		public static function set licStr(value:String):void
		{
			hasLic = true;
			_licInfo = parserLicString(value);
		}

		public static function get hasLic():Boolean
		{
			return _hasLic;
		}

		public static function set hasLic(value:Boolean):void
		{
			_hasLic = value;
		}

		public static function get licInfo():LicInfo
		{
			return _licInfo;
		}

		public static function set licInfo(value:LicInfo):void
		{
			_licInfo = value;
		}

		
	}
}