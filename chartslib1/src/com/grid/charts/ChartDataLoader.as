package com.grid.charts
{
	import com.boboeye.basic.LicUtil;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.parser.IChartParser;
	import com.grid.charts.parser.ParserFactory;
	import com.grid.charts.view.chartviews.ChartView;
	import com.grid.charts.view.chartviews.ChartViewFactory;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class ChartDataLoader
	{
		public function ChartDataLoader()
		{
		}
		public static function loadData(data:XML,parent:DisplayObjectContainer,w:Number,h:Number):void{
			var type:String = data.@type;
			if(type==null||type==""){type="other";}
			var chartView:ChartView = ChartViewFactory.getInst().createChartView(type);
			var parser:IChartParser = ParserFactory.getInst().createParser("xml",type);
			var chart:GridChart = parser.parse(data);
			chart.chartStyle = parser.parseStyle(data);
			ChartController.getInst().chart = chart;
			ChartController.getInst().chartView = chartView;
			chartView.x = 0;
			chartView.y = 0;
			chartView.width = w;
			chartView.height = h;
			parent.addChild(chartView);
			var show:ChartEvent = new ChartEvent(ChartEvent.CHARTEVENT_SHOWCHART);
			show.dispatch();
		}
	}
}