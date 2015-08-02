package com.grid.charts.series
{
	import com.adobe.serialization.json.JSON;
	import com.grid.charts.model.ChartSeriesStyle;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.thirdpart.CubicBezier;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import morn.core.components.Box;
	
	public class LineSeriesDrawer extends NoneDrawer
	{
		public function LineSeriesDrawer()
		{
		}
		
		override public function draw(chart:GridChart,
							 content:Box,
							 seriesIndex:int,scale:Number):void
		{
			super.draw(chart,content,seriesIndex,scale);
			
			var series:GridChartSeries = chart.series[seriesIndex] as GridChartSeries;
			
			var sp:Sprite = new Sprite();
			sp.x = 0;
			sp.y = 0;
			content.addChild(sp);
			sp.graphics.lineStyle(0,0x000000,0);
			sp.graphics.drawRect(0,0,content.width,content.height);
			var graphG:Graphics = sp.graphics;
			
			var arr:Array = this.points;
			var seriesStyle:ChartSeriesStyle = chart.chartStyle.seriesStyle;
			graphG.lineStyle(seriesStyle.weight,this.lineColor,this.currAlpha);
			if(series.smooth){
				CubicBezier.curveThroughPoints(graphG,arr);
			}else if(series.step){
				var command:Vector.<int> = new Vector.<int>();
				var pdata:Vector.<Number> = new Vector.<Number>();
				for(var i:int=0;i<arr.length;i++){
					var p:Point = arr[i] as Point;
					if(i==0){
						command.push(GraphicsPathCommand.MOVE_TO);
						pdata.push(p.x,p.y);
					}else{
						command.push(GraphicsPathCommand.LINE_TO);
						command.push(GraphicsPathCommand.LINE_TO);
						pdata.push(p.x,arr[i-1].y);
						pdata.push(p.x,p.y);
					}
				}
				graphG.drawPath(command,pdata,GraphicsPathWinding.EVEN_ODD);
			}else{
				var command:Vector.<int> = new Vector.<int>();
				var pdata:Vector.<Number> = new Vector.<Number>();
				for(var i:int=0;i<arr.length;i++){
					if(i==0){
						command.push(GraphicsPathCommand.MOVE_TO);
					}else{
						command.push(GraphicsPathCommand.LINE_TO);
					}
					var p:Point = arr[i] as Point;
					pdata.push(p.x,p.y);
				}
				graphG.drawPath(command,pdata,GraphicsPathWinding.EVEN_ODD);
			}
			for(var j:int=0;j<arr.length;j++){
				var xoff:Number = arr[j].x;
				var yoff:Number = arr[j].y;
				graphG.beginFill(this.pointColor,this.currAlpha);
				DrawerUtil.drawPoint(graphG,xoff,yoff,3,seriesStyle.pointType);
				graphG.endFill();
			}
			
			DrawerUtil.resizeAnimation(sp,content.width,"right");
		}
		
		override protected function drawTip(sp:Sprite,pindex:int):void
		{
			super.drawTip(sp,pindex);
			var pitem:Point = this.points[pindex] as Point;
			var nowg:Graphics = sp.graphics;
			nowg.beginFill(this.pointColor,this.currAlpha);
			DrawerUtil.drawPoint(nowg,pitem.x,pitem.y,9,this.chart.chartStyle.seriesStyle.pointType);
			nowg.endFill();
		}
	}
}