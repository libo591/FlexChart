package com.grid.charts.series
{
	import com.grid.charts.model.ChartSeriesStyle;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.thirdpart.CubicBezier;
	import com.grid.charts.util.CloneUtil;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	

	public class AreaSeriesDrawer extends NoneDrawer
	{
		public function AreaSeriesDrawer()
		{
			super();
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
			
			var arr:Array = CloneUtil.cloneArray(this.points);
			var len:int = arr.length;
			var seriesStyle:ChartSeriesStyle = chart.chartStyle.seriesStyle;
			graphG.lineStyle(seriesStyle.weight,this.lineColor,this.currAlpha);
			graphG.beginFill(this.lineColor,this.currAlpha);
			arr.unshift(new Point(arr[0].x,this.zeroPos));
			arr.push(new Point(arr[len].x,this.zeroPos));
			arr.push(new Point(arr[0].x,this.zeroPos));
			len = arr.length;
			var command:Vector.<int> = new Vector.<int>();
			var pdata:Vector.<Number> = new Vector.<Number>();
			for(var i:int=0;i<len;i++){
				if(i==0){
					command.push(GraphicsPathCommand.MOVE_TO);
				}else{
					command.push(GraphicsPathCommand.LINE_TO);
				}
				var p:Point = arr[i] as Point;
				pdata.push(p.x,p.y);
			}
			graphG.drawPath(command,pdata,GraphicsPathWinding.EVEN_ODD);
			graphG.endFill();
			
			for(var j:int=1;j<len-2;j++){
				var xoff:Number = arr[j].x;
				var yoff:Number = arr[j].y;
				graphG.beginFill(this.pointColor,this.currAlpha);
				DrawerUtil.drawPoint(graphG,xoff,yoff,3,seriesStyle.pointType);
				graphG.endFill();
			}
			
			DrawerUtil.resizeAnimation(sp,content.height,"top");
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