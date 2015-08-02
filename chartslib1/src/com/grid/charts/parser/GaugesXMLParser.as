package com.grid.charts.parser
{
	import com.grid.charts.model.GridChart;

	public class GaugesXMLParser extends XMLParser
	{
		public function GaugesXMLParser()
		{
			super();
		}
		
		override public function parse(obj:Object):GridChart
		{
			var config:XML = XML(obj);
			var chart:GridChart = new GridChart();
			chart.type = config.@type;
			
			var data:XML = (config.data as XMLList)[0] as XML;
			var attrs:XMLList = data.attributes();
			var obj:Object = {};
			for(var dindex:int=0;dindex<attrs.length();dindex++){
				var axml:XML = attrs[dindex] as XML;
				obj[""+axml.name()] = axml.toString();
			}
			chart.chartData = obj;
			return chart;
		}
	}
}