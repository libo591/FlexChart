package com.grid.charts.parser
{
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;

	public class RadarXMLParser extends XMLParser
	{
		public function RadarXMLParser()
		{
			super();
		}
		
		override public function parse(obj:Object):GridChart
		{
			var config:XML = XML(obj);
			var chart:GridChart = new GridChart();
			chart.title = config.@title;
			chart.subTitle = config.@subTitle;
			chart.xSuffix = config.@xSuffix;
			chart.ySuffix = config.@ySuffix;
			chart.type = config.@type;
			if(!isNull(config.@numDiv)){
				chart.numDiv = config.@numDiv;
			}
			chart.max = config.@max;
			chart.min = config.@min;
			
			chart.series = [];
			var series:XML = (config.series as XMLList)[0] as XML;
			var seriesChildren:XMLList = series.children();
			for(var seriesIndex:int=0;seriesIndex<seriesChildren.length();seriesIndex++){
				var cs:XML = seriesChildren[seriesIndex] as XML;
				var series1:GridChartSeries = new GridChartSeries();
				series1.name = isNull(cs.@name)?("系列"+(seriesIndex+1)):cs.@name;
				series1.xField = cs.@xField;
				series1.yField = cs.@yField;
				series1.type = cs.name();
				if(isNull(cs.@color)){
					chart.seriesColor.push(GridChartSeries.LINE_COLORS[seriesIndex]);
				}else{
					chart.seriesColor.push(cs.@color);
				}
				if(isNull(cs.@alpha)){
					chart.seriesAlpha.push(1-seriesIndex*(1/seriesChildren.length()));
				}else{
					chart.seriesAlpha.push(cs.@alpha);
				}
				chart.series.push(series1);
			}
			
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
				dataarr.push(obj);
			}
			chart.chartData = dataarr;
			return chart;
		}
	}
}