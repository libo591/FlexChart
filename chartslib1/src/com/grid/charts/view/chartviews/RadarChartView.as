package com.grid.charts.view.chartviews
{
	import com.grid.charts.ChartController;
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.series.SeriesFactory;
	import com.grid.charts.view.GraphContentAS;
	
	import morn.core.components.Box;

	public class RadarChartView extends ChartView
	{
		public function RadarChartView()
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
			this.main.addChild(gc);
			
			var sumHeight:Number = main.height;
			var sumWidth:Number = main.width-50;
			gc.width = sumWidth;
			gc.height = sumHeight;
			
			var seriesArr:Array = chart.series;
			for(var i:int=0;i<seriesArr.length;i++){
				var drawContent:Box = new Box();
				drawContent.width = gc.width;
				drawContent.height = gc.height;
				gc.addChild(drawContent);
				var drawer:ISeriesDrawer = SeriesFactory.getSeriesDrawer(chart.type);
				drawer.draw(chart,drawContent,i,-1);
			}
		}
	}
}