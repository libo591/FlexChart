package com.grid.charts.series
{
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.model.SeriesGridChartAxis;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import morn.core.components.Box;

	public class ColumnSeriesDrawer extends NoneDrawer
	{
		public function ColumnSeriesDrawer()
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
			
			var sp:Sprite = new Sprite();
			sp.x = 0;
			sp.y = 0;
			content.addChild(sp);
			sp.graphics.lineStyle(0,0x000000,0);
			sp.graphics.drawRect(0,0,content.width,content.height);
			var graphG:Graphics = sp.graphics;
			
			var wc:int = 0;
			var wi:int = 0;
			for(var i:int=0;i<seriesCount;i++){
				var cs:GridChartSeries = chart.series[i] as GridChartSeries;
				if(cs.type=="column"){
					wc++;
					if(i<seriesIndex){
						wi++;
					}
				}
			}
			
			var begin:Number = (chart.seriesaxis[seriesIndex] as SeriesGridChartAxis).serieValueBegin;
			var zeroy:Number = content.height-(0-begin)*scale;
			var columnItemWidthWithPadding:Number = (this.colWidth-padding*2)/wc;
			graphG.lineStyle(1,this.pointColor,1);
			for(var i:int=0;i<pointsCount;i++){
				var p:Point = this.points[i] as Point;
				var startX:Number = p.x-this.colWidth/2+padding;
				graphG.beginFill(this.lineColor,this.currAlpha);
				graphG.drawRect(startX+wi*(columnItemWidthWithPadding),p.y,
					columnItemWidthWithPadding,zeroy-p.y);
				graphG.endFill();
			}
			
			DrawerUtil.resizeAnimation(sp,content.height,"top");
		}
	}
}