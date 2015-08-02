package com.grid.charts.parser
{
	public class ParserFactory
	{
		private static var _inst:ParserFactory=new ParserFactory();
		public function ParserFactory()
		{
		}
		public static function getInst():ParserFactory
		{
			return _inst;
		}
		
		public function createParser(format:String,type:String):IChartParser
		{
			if(format=="xml"){
				if(type=="pie"){
					return new PieXMLParser();
				}else if(type=="other"){
					return new XMLParser();
				}else if(type.indexOf("gauges")!=-1){
					return new GaugesXMLParser();
				}else if(type=="radar"){
					return new RadarXMLParser();
				}
				return new XMLParser();
			}else if(format=="json"){
				return new JSONParser();
			}
			return new XMLParser();	
		}
	}
}