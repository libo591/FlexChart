package com.grid.charts.view.chartviews
{
	import com.grid.charts.ChartController;
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.series.SeriesFactory;
	import com.grid.charts.view.GraphContentAS;
	
	import morn.core.components.Box;

	public class PieChartView extends ChartView
	{
		public function PieChartView()
		{
			super();
		}
		
		override protected function showLegend():void{
		}
		override protected function showMain():void
		{
			positionMain();
			var chart:GridChart = ChartController.getInst().chart;
			var gc:GraphContentAS = new GraphContentAS();
			gc.width = main.width;
			gc.height = main.height;
			gc.x = 0;
			gc.y = 0;
			main.addChild(gc);
			
			var dataarr:Array = chart.chartData as Array;
			var count:int = dataarr.length;
			
			var drawContent:Box = new Box();
			drawContent.width = gc.width;
			drawContent.height = gc.height;
			gc.addChild(drawContent);
			
			var sumValue:Number = 0;
			for(var i:int=0;i<count;i++){
				var dataobj:Object = dataarr[i];
				sumValue += Number(dataobj["value"]);
			}
			
			var drawer:ISeriesDrawer = SeriesFactory.getSeriesDrawer(chart.type);
			drawer.draw(chart,drawContent,-1,sumValue);
		}
	}
}