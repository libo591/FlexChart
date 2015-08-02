package com.grid.charts.series
{
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	
	public class RadarDrawer implements ISeriesDrawer
	{
		public function RadarDrawer()
		{
		}
		
		public function get points():Array
		{
			return null;
		}
		
		public function set points(value:Array):void
		{
		}

		public function draw(chart:GridChart, content:Box, seriesIndex:int, sum:Number):void
		{
			var padding1:Number = 100;
			var padding2:Number = 50;
			var g:Graphics = content.graphics;
			g.clear();
			
			var currseries:GridChartSeries = chart.series[seriesIndex] as GridChartSeries;
			
			var data:Array = chart.chartData as Array;
			var datacount:int = data.length;
			
			var w:Number = content.width - padding1*2;
			var h:Number = content.height - padding2*2;
			
			var leftx:Number = padding1;
			var lefty:Number = padding2;
			
			var centerx:Number = content.width/2;
			var centery:Number = content.height/2;
			var beginD:Number = -90;
			var stepD:Number = 360/datacount;
			var maxRadis:Number = h/2;
			for(var j:int=0;j<chart.numDiv;j++){
				var radis:Number = maxRadis-j*maxRadis/chart.numDiv;
				if(j==0){
					g.lineStyle(2,0xBEBEBE,1);
				}else{
					g.lineStyle(1,0xBEBEBE,1);
				}
				for(var i:int=0;i<datacount;i++){
					var currD:Number = beginD+i*stepD;
					var currR = Math.PI/180*currD;
					var nowx:Number = centerx+radis*Math.cos(currR);
					var nowy:Number = centery+radis*Math.sin(currR);
					if(i==0){
						g.moveTo(nowx,nowy);
					}else{
						g.lineTo(nowx,nowy);
					}
					
					if(i==datacount-1){
						var bd:Number = Math.PI/180*beginD;
						g.lineTo(centerx+radis*Math.cos(bd),
							centery+radis*Math.sin(bd));
					}
					
					if(j==0){
						g.moveTo(centerx,centery);
						g.lineTo(nowx,nowy);
						
						var label:Label = new Label();
						label.text = data[i][currseries.xField];
						label.width = 50;
						label.height = 20;
						var labelPoint:Point = 
							DrawerUtil.getPointOfLabel(new Point(nowx,nowy),label.width,label.height,DrawerUtil.getXiangxian(currD))
						label.x = labelPoint.x;
						label.y = labelPoint.y;
						label.align = "center";
						content.addChild(label);
					}
				}
				
				var label:Label = new Label();
				label.text = (chart.max-j*(chart.max-chart.min)/chart.numDiv)+"";
				label.width = 30;
				label.height = 20;
				label.x = centerx-label.width;
				label.y = centery-radis;
				label.align = "center";
				content.addChild(label);
				
				if(j==chart.numDiv-1){
					var label:Label = new Label();
					label.text = chart.min+"";
					label.width = 30;
					label.height = 20;
					label.x = centerx-label.width;
					label.y = centery;
					label.align = "center";
					content.addChild(label);
				}
			}
			var fillColor:uint = chart.seriesColor[seriesIndex];
			var fillAlpha:Number = chart.seriesAlpha[seriesIndex];
			g.beginFill(fillColor,fillAlpha);
			var firstPoint:Point = null;
			for(var i:int=0;i<datacount;i++){
				var currdata:Number = parseFloat(data[i][currseries.yField]);
				var currD:Number = beginD+i*stepD;
				currD = Math.PI/180*currD;
				var currRadis:Number = (currdata-chart.min)*maxRadis/(chart.max-chart.min);
				var nowx:Number = centerx+currRadis*Math.cos(currD);
				var nowy:Number = centery+currRadis*Math.sin(currD);
				if(i==0){
					firstPoint = new Point(nowx,nowy);
					g.moveTo(nowx,nowy);
				}else{
					g.lineTo(nowx,nowy);
				}
				
				if(i==datacount-1){
					g.lineTo(firstPoint.x,firstPoint.y);
				}
			}
			g.endFill();
		}
		
	}
}