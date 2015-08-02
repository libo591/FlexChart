package com.grid.charts.series
{
	import com.grid.charts.model.GridChart;
	
	import morn.core.components.Box;
	
	public class FullStackBarSeriesDrawer extends StackBarSeriesDrawer
	{
		public function FullStackBarSeriesDrawer()
		{
			super();
		}
		override public function draw(chart:GridChart,
									  content:Box,
									  seriesIndex:int,scale:Number):void
		{
			super.draw(chart,content,seriesIndex,scale);
		}
	}
}