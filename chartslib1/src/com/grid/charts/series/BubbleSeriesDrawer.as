package com.grid.charts.series
{
	import com.grid.charts.model.ChartSeriesStyle;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.thirdpart.CubicBezier;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	
	public class BubbleSeriesDrawer extends NoneDrawer
	{
		public function BubbleSeriesDrawer()
		{
		}
		
		override public function draw(chart:GridChart,
							 content:Box,
							 seriesIndex:int,scale:Number):void
		{
			super.draw(chart,content,seriesIndex,scale);
			var series:GridChartSeries = chart.series[seriesIndex] as GridChartSeries;
			var seriesStyle:ChartSeriesStyle = chart.chartStyle.seriesStyle;
			var sp:Sprite = new Sprite();
			sp.x = 0;
			sp.y = 0;
			content.addChild(sp);
			sp.graphics.lineStyle(0,0x000000,0);
			sp.graphics.drawRect(0,0,content.width,content.height);
			var graphG:Graphics = sp.graphics;
			var arr:Array = this.points;
			for(var j:int=0;j<arr.length;j++){
				var xoff:Number = arr[j].x;
				var yoff:Number = arr[j].y;
				graphG.beginFill(this.pointColor,this.currAlpha);
				graphG.drawCircle(xoff,yoff,this.chartData[j][series.radiusField]);
				graphG.endFill();
				graphG.beginFill(this.pointColor,1);
				DrawerUtil.drawPoint(graphG,xoff,yoff,3,seriesStyle.pointType);
				graphG.endFill();
			}
			DrawerUtil.alphaAnimation(sp);
		}
	}
}