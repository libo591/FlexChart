package com.grid.charts.series
{
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.SeriesGridChartAxis;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.geom.Point;
	
	import morn.core.components.Box;
	
	public class Column3DSeriesDrawer extends NoneDrawer
	{
		public function Column3DSeriesDrawer()
		{
			super();
		}
		override public function draw(chart:GridChart,
									  content:Box,
									  seriesIndex:int,scale:Number):void
		{
			super.draw(chart,content,seriesIndex,scale);
			var seriesCount:int = chart.series.length;
			var padding:int = 5;
			var pointsCount:int = this.points.length;
			var begin:Number = (chart.seriesaxis[seriesIndex] as SeriesGridChartAxis).serieValueBegin;
			var zeroy:Number = content.height-(0-begin)*scale;
			var columnItemWidthWithPadding:Number = (this.colWidth-padding*2)/seriesCount;
			var columnItemWidthNoPadding:Number = columnItemWidthWithPadding-padding;
			content.graphics.lineStyle(1,this.pointColor,1);
			for(var i:int=0;i<pointsCount;i++){
				var p:Point = this.points[i] as Point;
				var startX:Number = p.x-this.colWidth/2+padding;
				DrawerUtil.draw3DCol(content.graphics,new Point(startX,zeroy),
					zeroy-p.y,columnItemWidthNoPadding,this.pointColor,this.lineColor);
			}
		}
	}
}