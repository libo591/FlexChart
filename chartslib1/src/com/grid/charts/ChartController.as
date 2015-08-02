package com.grid.charts
{
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.ChartLegend;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.view.chartviews.ChartView;
	
	/**
	 * 控制器，model变化后，用事件通知view去改变外观，保存了当前展现的view和model
	 */
	public class ChartController
	{
		private static var _inst:ChartController=new ChartController();
		/** 图表对象实体 */
		private var _chart:GridChart;
		/** 图表展现组件 */
		private var _chartView:ChartView;
		
		public function ChartController()
		{
			ChartEventDispatcher.getInstance().addEventListener(ChartEvent.CHARTEVENT_SHOWCHART,showChart);
			ChartEventDispatcher.getInstance().addEventListener(ChartEvent.CHARTEVENT_SERIESSHOW,showSeries);
			ChartEventDispatcher.getInstance().addEventListener(ChartEvent.CHARTEVENT_SERIESHIDE,hideSeries);
		}
		
		private function hideSeries(e:ChartEvent):void
		{
			this.setSeriesShow(e.str1,false);
		}
		
		private function showSeries(e:ChartEvent):void
		{
			this.setSeriesShow(e.str1,true);
		}
		private function setSeriesShow(seriesName:String,show:Boolean):void{
			chartView.showSeries(seriesName,show);
		}
		
		private function showChart(e:ChartEvent):void
		{
			this._chartView.reshow();
		}
		
		public static function getInst():ChartController{
			return _inst;
		} 

		public function get chart():GridChart
		{
			return _chart;
		}

		public function set chart(value:GridChart):void
		{
			_chart = value;
		}

		public function get chartView():ChartView
		{
			return _chartView;
		}

		public function set chartView(value:ChartView):void
		{
			_chartView = value;
		}
		
	}
}