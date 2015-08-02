package com.grid.charts.series
{
	import com.grid.charts.model.GridChart;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	
	public class StackSeriesDrawer extends NoneDrawer
	{
		public function StackSeriesDrawer()
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
			
			var sp:Sprite = new Sprite();
			sp.x = 0;
			sp.y = 0;
			content.addChild(sp);
			sp.graphics.lineStyle(0,0x000000,0);
			sp.graphics.drawRect(0,0,content.width,content.height);
			var graphG:Graphics = sp.graphics;
			
			var pointsCount:int = this.points.length;
			var zeroy:Number = this.seriesXorY(content.height,this.seriesHeightOrWidth(0,scale));
			graphG.lineStyle(1,this.pointColor,1);
			for(var i:int=0;i<pointsCount;i++){
				var p:Point = this.points[i] as Point;
				var value:Number = this.seriesValue(seriesIndex,i);
				var sumh:Number = 0;
				if(seriesIndex>0){
					var temp:int = seriesIndex;
					while(temp>0){
						var prevalue:Number = this.seriesValue(temp-1,i);
						var h:Number = this.value2ZeroDist(prevalue,scale);
						if((prevalue<=0&&value<=0)
							||(prevalue>=0&&value>=0)){
							sumh+=h;
						}
						temp--;
					}
				}
				var startX:Number = p.x-this.colWidth/2+padding;
				var currh:Number = this.value2ZeroDist(value,scale);
				graphG.beginFill(this.lineColor,this.currAlpha);
				graphG.drawRect(startX,p.y-sumh,
					this.colWidth-padding*2,currh);
				graphG.endFill();
			}
			
			DrawerUtil.resizeAnimation(sp,content.height,"top");
		}
	}
}