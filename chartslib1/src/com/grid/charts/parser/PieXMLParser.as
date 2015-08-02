package com.grid.charts.parser
{
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;

	public class PieXMLParser extends XMLParser
	{
		public function PieXMLParser()
		{
			super();
		}
		override public function parse(obj:Object):GridChart{
			var config:XML = XML(obj);
			var chart:GridChart = new GridChart();
			chart.title = config.@title;
			chart.subTitle = config.@subTitle;
			chart.valueSuffiex = config.@valueSuffix;
			chart.precision = config.@precision;
			chart.type = config.@type;
			chart.model = config.@model;
			
			var lgXML:XML = (config.legend as XMLList)[0] as XML;
			
			var datas:XML = (config.data as XMLList)[0] as XML;
			var dataChildren:XMLList = datas.children();
			var dataarr:Array = [];
			var dc:int = dataChildren.length();
			for(var dindex:int=0;dindex<dc;dindex++){
				var attrs:XMLList = dataChildren[dindex].attributes();
				var obj:Object = {};
				for(var aindex:int=0;aindex<attrs.length();aindex++){
					var axml:XML = attrs[aindex] as XML;
					obj[""+axml.name()] = axml.toString();
				}
				if(isNull(obj["color"])){
					chart.seriesColor.push(GridChartSeries.LINE_COLORS[dindex]);
				}else{
					chart.seriesColor.push(obj["color"]);
				}
				if(isNull(obj["alpha"])){
					chart.seriesAlpha.push(1-dindex*(1/dc));
				}else{
					chart.seriesAlpha.push(obj["alpha"]);
				}
				dataarr.push(obj);
			}
			chart.chartData = dataarr;
			return chart;
		}
	}
}