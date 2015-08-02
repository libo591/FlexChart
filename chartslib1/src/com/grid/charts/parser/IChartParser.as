package com.grid.charts.parser
{
	import com.grid.charts.model.ChartStyle;
	import com.grid.charts.model.GridChart;

	public interface IChartParser
	{
		function parse(obj:Object):GridChart;
		function parseStyle(obj:Object):ChartStyle;
	}
}