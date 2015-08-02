package com.grid.charts.parser
{
	import com.grid.charts.model.ChartAxisStyle;
	import com.grid.charts.model.ChartGraphStyle;
	import com.grid.charts.model.ChartLegendStyle;
	import com.grid.charts.model.ChartSeriesStyle;
	import com.grid.charts.model.ChartStyle;
	import com.grid.charts.model.ChartSubTitleStyle;
	import com.grid.charts.model.ChartTitleStyle;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.model.SeriesGridChartAxis;
	import com.grid.charts.model.TypeGridChartAxis;
	
	import mx.controls.Alert;
	
	

	/**
	 * 图表的XML数据解析器
	 */
	public class XMLParser implements IChartParser
	{
		public function XMLParser()
		{
		}
		protected function isNull(obj:Object):Boolean{
			if(obj==undefined||obj==null||obj==""||obj=="null"){
				return true;
			}
			return false;
		}
		/**
		 * 解析图表标签属性
		 */
		private function parseChartProp(chart:GridChart,config:XML):void{
			chart.title = config.@title;
			chart.subTitle = config.@subTitle;
			chart.xSuffix = config.@xSuffix;
			chart.ySuffix = config.@ySuffix;
			if(!isNull(config.@multiSeriesAxis))chart.multiSeriesAxis = config.@multiSeriesAxis=="true"?true:false;
		}
		private function parseAxisByXML(axislist:XMLList,chart:GridChart,isX:Boolean):void{
			for(var i:int=0;i<axislist.length();i++){
				var axisxml:XML = axislist[i] as XML;
				if(axisxml.@type=="field"){
					var xaxis:TypeGridChartAxis = new TypeGridChartAxis();
					xaxis.title = axisxml.@title;
					xaxis.isOnX = isX;
					chart.typeaxis = xaxis;
				}else if(axisxml.@type=="linear"){
					var yaxis:SeriesGridChartAxis = new SeriesGridChartAxis();
					yaxis.title = axisxml.@title;
					if(chart.multiSeriesAxis||i==0){
						if(!isNull(axisxml.@inc))yaxis.inc = Number(axisxml.@inc);
						if(!isNull(axisxml.@needZeroLine))yaxis.needZeroLine = axisxml.@needZeroLine=="true"?true:false;
						yaxis.serieValueBegin = isNull(axisxml.@beginValue)?0:axisxml.@beginValue;
						yaxis.serieValueEnd = isNull(axisxml.@endValue)?0:axisxml.@endValue;
					}else{
						var ya:SeriesGridChartAxis = chart.seriesaxis[0];
						yaxis.inc = ya.inc;
						yaxis.needZeroLine = ya.needZeroLine;
						yaxis.serieValueBegin = ya.serieValueBegin;
						yaxis.serieValueEnd = ya.serieValueEnd;
					}
					chart.seriesaxis.push(yaxis);
				}
			}
		}
		/**
		 * 解析图表轴属性
		 */
		private function parseAxisProp(chart:GridChart,config:XML):void{
			chart.seriesaxis = [];
			var axis:XML = (config.axis as XMLList)[0] as XML;
			var xaxislist:XMLList = axis.x as XMLList;
			parseAxisByXML(xaxislist,chart,true);
			
			var yaxislist:XMLList = axis.y as XMLList;
			parseAxisByXML(yaxislist,chart,false);
			//check div
			var dc:int = chart.seriesaxis.length;
			var numDiv:int = 0;
			for(var i:int=0;i<dc;i++){
				var yaxis:SeriesGridChartAxis = chart.seriesaxis[i] as SeriesGridChartAxis;
				if(i==0){
					numDiv = Math.round((yaxis.serieValueEnd-yaxis.serieValueBegin)/yaxis.inc);
				}else{
					var tmp:int = Math.round((yaxis.serieValueEnd-yaxis.serieValueBegin)/yaxis.inc);
					if(tmp!=numDiv){
						throw new Error("计算后各序列的间隔值不等，需重新设置beginValue， endValue，inc");
					}
				}
			}
			chart.numDiv = numDiv;
		}
		
		/**
		 * 解析图表系列属性
		 */
		private function parseSeriesProp(chart:GridChart,config:XML):void{
			var series:XML = (config.series as XMLList)[0] as XML;
			var seriesChildren:XMLList = series.children();
			chart.series = [];
			for(var seriesIndex:int=0;seriesIndex<seriesChildren.length();seriesIndex++){
				var cs:XML = seriesChildren[seriesIndex] as XML;
				var series1:GridChartSeries = new GridChartSeries();
				series1.name = isNull(cs.@name)?("系列"+(seriesIndex+1)):cs.@name;
				series1.xField = cs.@xField;
				series1.yField = cs.@yField;
				series1.radiusField = cs.@radiusField;
				var field:String = chart.typeaxis.isOnX?series1.yField:series1.xField;
				series1.smooth = isNull(cs.@smooth)?false:cs.@smooth;
				series1.step = isNull(cs.@step)?false:cs.@step;
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
		}
		/**
		 * 解析图表数据属性
		 */
		private function parseDataProp(chart:GridChart,config:XML):void{
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
			//计算每个序列的最大值
			var yaxcount:int = chart.seriesaxis.length;
			if((chart.series[0] as GridChartSeries).type=="stack"
				||(chart.series[0] as GridChartSeries).type=="stackbar"){
				for(var yi:int=0;yi<yaxcount;yi++){
					var y:SeriesGridChartAxis = chart.seriesaxis[yi] as SeriesGridChartAxis;
					var sum1:Number = 0;
					var sum2:Number = 0;
					if(yi==0){
						for(var yi1:int=0;yi1<yaxcount;yi1++){
							var y1:SeriesGridChartAxis = chart.seriesaxis[yi1] as SeriesGridChartAxis;
							sum1+= y1.serieValueEnd;
							sum2+= y1.serieValueBegin;
						}
					}else{
						sum1 = (chart.seriesaxis[yi-1] as SeriesGridChartAxis).serieValueEnd;
						sum2 = (chart.seriesaxis[yi-1] as SeriesGridChartAxis).serieValueBegin;
					}
					y.serieValueEnd = sum1;
					y.serieValueBegin = sum2;
				}
			}
			if((chart.series[0] as GridChartSeries).type=="fullstack"
				||(chart.series[0] as GridChartSeries).type=="fullstackbar"){
				for(var yi:int=0;yi<yaxcount;yi++){
					var y:SeriesGridChartAxis = chart.seriesaxis[yi] as SeriesGridChartAxis;
					y.serieValueBegin = 0;
					y.serieValueEnd = 100;
				}
				if(chart.typeaxis.isOnX){
					chart.ySuffix = "%";
				}else{
					chart.xSuffix = "%";
				}
				
				var sa:Array = chart.series;
				for(var di:int=0;di<dataarr.length;di++){
					var currdata:Object = dataarr[di];
					var sumValueCurrRow:Number = 0;
					for(var si:int=0;si<sa.length;si++){
						var se:GridChartSeries = sa[si] as GridChartSeries;
						var field:String = chart.typeaxis.isOnX?se.yField:se.xField;
						sumValueCurrRow+=Number(currdata[field]);
					}
					
					for(var si:int=0;si<sa.length;si++){
						var se:GridChartSeries = sa[si] as GridChartSeries;
						var field:String = chart.typeaxis.isOnX?se.yField:se.xField;
						currdata[field] = Number(currdata[field])*100/sumValueCurrRow;
					}
				}
				chart.chartData = dataarr;
			}
		}
		/**
		 * 解析方法
		 */
		public function parse(obj:Object):GridChart{
			var config:XML = XML(obj);
			//config
			var chart:GridChart = new GridChart();
			parseChartProp(chart,config);
			parseAxisProp(chart,config);
			parseSeriesProp(chart,config);
			parseDataProp(chart,config);
			return chart;
		}
		public function parseStyle(obj:Object):ChartStyle{
			var config:XML = XML(obj);
			var chartStyle:ChartStyle = new ChartStyle();
			if(config.style==null||config.style.length()<=0){
				return chartStyle; 
			}
			var style:XML = config.style[0];
			if(!isNull(style.@backgroundColor))chartStyle.backgroundColor = style.@backgroundColor;
			if(!isNull(style.@backgroundAlpha))chartStyle.backgroundAlpha = Number(style.@backgroundAlpha);
			if(!isNull(style.@borderStyle))chartStyle.borderStyle = style.@borderStyle;
			if(!isNull(style.@borderColor))chartStyle.borderColor = uint(style.@borderColor);
			chartStyle.titleStyle = parseTitleStyle(style);
			chartStyle.subTitleStyle = parseSubTitleStyle(style);
			chartStyle.legendStyle = parseLegendStyle(style);
			chartStyle.seriesStyle = parseSeriesStyle(style);
			chartStyle.axisStyle = parseAxisStyle(style);
			chartStyle.graphStyle = parseGraphStyle(style);
			
			return chartStyle;
		}
		
		private function parseGraphStyle(style:XML):ChartGraphStyle
		{
			var graphStyle:ChartGraphStyle = new ChartGraphStyle();
			var graph:XML = style.graph[0];
			if(!isNull(graph.@hlines))graphStyle.hlines = graph.@hlines=="true"?true:false;
			if(!isNull(graph.@vlines))graphStyle.vlines = graph.@vlines=="true"?true:false;
			if(!isNull(graph.@hlinesColor))graphStyle.hlinesColor = uint(graph.@hlinesColor);
			if(!isNull(graph.@vlinesColor))graphStyle.vlinesColor = uint(graph.@vlinesColor);
			if(!isNull(graph.@borderStyle))graphStyle.borderStyle = graph.@borderStyle;
			if(!isNull(graph.@borderColor))graphStyle.borderColor = uint(graph.@borderColor);
			if(!isNull(graph.@borderRound))graphStyle.borderRound = int(graph.@borderRound);
			if(!isNull(graph.@backgroundColor))graphStyle.backgroundColor = String(graph.@backgroundColor).split(",");
			if(!isNull(graph.@backgroundAlpha))graphStyle.backgroundAlpha = String(graph.@backgroundAlpha).split(",");
			if(!isNull(graph.@interlacingColor))graphStyle.interlacingColor = String(graph.@interlacingColor).split(",");
			if(!isNull(graph.@interlacingAlpha))graphStyle.interlacingAlpha = String(graph.@interlacingAlpha).split(",");
			
			return graphStyle;
		}
		
		private function parseAxisStyle(style:XML):ChartAxisStyle
		{
			var axisStyle:ChartAxisStyle = new ChartAxisStyle();
			var axis:XML = style.axis[0];
			if(!isNull(axis.@type))axisStyle.type = axis.@type;
			if(!isNull(axis.@color))axisStyle.color = uint(axis.@color);
			if(!isNull(axis.@angle))axisStyle.angle = int(axis.@angle);
			if(!isNull(axis.@alarmValues))axisStyle.alarmValues = String(axis.@alarmValues).split(",");
			return axisStyle;
		}
		
		private function parseSeriesStyle(style:XML):ChartSeriesStyle
		{
			var seriesStyle:ChartSeriesStyle = new ChartSeriesStyle();
			var series:XML = style.series[0];
			if(!isNull(series.@labelVisiable))seriesStyle.labelVisiable = series.@labelVisiable=="true"?true:false;
			if(!isNull(series.@family))seriesStyle.family = series.@family;
			if(!isNull(series.@size))seriesStyle.size = int(series.@size);
			if(!isNull(series.@color))seriesStyle.color = uint(series.@color);
			if(!isNull(series.@bold))seriesStyle.bold = series.@bold=="true"?true:false;
			if(!isNull(series.@italic))seriesStyle.italic = series.@italic=="true"?true:false;
			if(!isNull(series.@weight))seriesStyle.weight = int(series.@weight);
			if(!isNull(series.@pointType))seriesStyle.pointType = series.@pointType;
			if(!isNull(series.@isFill))seriesStyle.isFill = series.@isFill=="true"?true:false;
			if(!isNull(series.@lineType))seriesStyle.lineType = series.@lineType;
			if(!isNull(series.@lineColor))seriesStyle.lineColor = uint(series.@lineColor);
			return seriesStyle;
		}
		
		private function parseLegendStyle(style:XML):ChartLegendStyle
		{
			var legendStyle:ChartLegendStyle = new ChartLegendStyle();
			var legend:XML = style.legend[0];
			if(!isNull(legend.@family))legendStyle.family = legend.@family;
			if(!isNull(legend.@size))legendStyle.size = int(legend.@size);
			if(!isNull(legend.@color))legendStyle.color = uint(legend.@color);
			if(!isNull(legend.@bold))legendStyle.bold = legend.@bold=="true"?true:false;
			if(!isNull(legend.@italic))legendStyle.italic = legend.@italic=="true"?true:false;
			if(!isNull(legend.@align))legendStyle.position = legend.@position;
			if(!isNull(legend.@borderStyle))legendStyle.borderStyle = legend.@borderStyle;
			if(!isNull(legend.@borderColor))legendStyle.borderColor = uint(legend.@borderColor);
			if(!isNull(legend.@borderRound))legendStyle.borderRound = int(legend.@borderRound);
			if(!isNull(legend.@backgroundColor))legendStyle.backgroundColor = uint(legend.@backgroundColor);
			if(!isNull(legend.@backgroundAlpha))legendStyle.backgroundAlpha = Number(legend.@backgroundAlpha);
			return legendStyle;
		}
		
		private function parseSubTitleStyle(style:XML):ChartSubTitleStyle
		{
			var titleStyle:ChartSubTitleStyle = new ChartSubTitleStyle();
			var subTitle:XML = style.subTitle[0];
			if(!isNull(subTitle.@family))titleStyle.family = subTitle.@family;
			if(!isNull(subTitle.@size))titleStyle.size = int(subTitle.@size);
			if(!isNull(subTitle.@color))titleStyle.color = uint(subTitle.@color);
			if(!isNull(subTitle.@bold))titleStyle.bold = subTitle.@bold=="true"?true:false;
			if(!isNull(subTitle.@italic))titleStyle.italic = subTitle.@italic=="true"?true:false;
			if(!isNull(subTitle.@align))titleStyle.align = subTitle.@align;
			if(!isNull(subTitle.@borderStyle))titleStyle.borderStyle = subTitle.@borderStyle;
			if(!isNull(subTitle.@borderColor))titleStyle.borderColor = uint(subTitle.@borderColor);
			if(!isNull(subTitle.@borderRound))titleStyle.borderRound = int(subTitle.@borderRound);
			if(!isNull(subTitle.@backgroundColor))titleStyle.backgroundColor = uint(subTitle.@backgroundColor);
			if(!isNull(subTitle.@backgroundAlpha))titleStyle.backgroundAlpha = Number(subTitle.@backgroundAlpha);
			return titleStyle;
		}
		
		private function parseTitleStyle(style:XML):ChartTitleStyle
		{
			var titleStyle:ChartTitleStyle = new ChartTitleStyle();
			var title:XML = style.title[0];
			if(!isNull(title.@family))titleStyle.family = title.@family;
			if(!isNull(title.@size))titleStyle.size = int(title.@size);
			if(!isNull(title.@color))titleStyle.color = uint(title.@color);
			if(!isNull(title.@bold))titleStyle.bold = title.@bold=="true"?true:false;
			if(!isNull(title.@italic))titleStyle.italic = title.@italic=="true"?true:false;
			if(!isNull(title.@align))titleStyle.align = title.@align;
			if(!isNull(title.@borderStyle))titleStyle.borderStyle = title.@borderStyle;
			if(!isNull(title.@borderColor))titleStyle.borderColor = uint(title.@borderColor);
			if(!isNull(title.@borderRound))titleStyle.borderRound = int(title.@borderRound);
			if(!isNull(title.@backgroundColor))titleStyle.backgroundColor = uint(title.@backgroundColor);
			if(!isNull(title.@backgroundAlpha))titleStyle.backgroundAlpha = Number(title.@backgroundAlpha);
			return titleStyle;
		}
	}
}