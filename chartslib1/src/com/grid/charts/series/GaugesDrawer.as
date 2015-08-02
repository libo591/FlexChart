package com.grid.charts.series
{
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	
	public class GaugesDrawer implements ISeriesDrawer
	{
		public function GaugesDrawer()
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
			content.graphics.clear();
			var data:Object = chart.chartData;
			
			var radius:Number = Math.min(content.height,content.width)/2;
			
			var cp:Point = new Point();
			cp.x = (content.width)/2;
			cp.y = (content.height)/2;
			
			var g:Graphics = content.graphics;
			g.lineStyle(1,0x000000,1);
			g.drawCircle(cp.x,cp.y,radius);
			g.beginFill(0x000000,1);
			g.drawCircle(cp.x,cp.y,10);
			g.endFill();
			
			var beginAngle:int = parseInt(data["beginAngle"]);
			var endAngle:int = parseInt(data["endAngle"]);
			if(endAngle<beginAngle){
				endAngle = 360+endAngle;
			}
			var min:Number = parseFloat(data["min"]);
			var max:Number = parseFloat(data["max"]);
			var step:int = parseInt(data["step"]);
			var stepInStep:int = parseInt(data["stepInStep"]);
			
			var suffix:String = data["suffix"];
			var numOfStep:int = (endAngle-beginAngle)/step;
			var valueOfStep:Number = (max-min)/step;
			g.lineStyle(2,0x000000);
			for(var i:int=0;i<=step;i++){
				var currAngle:int = beginAngle+i*numOfStep;
				var currValue:Number = min+i*valueOfStep;
				var r:Number = Math.PI/180*currAngle;
				var x:Number = cp.x+radius * Math.cos(r);
				var y:Number = cp.y+radius * Math.sin(r);
				
				var x1:Number = cp.x+(radius-10) * Math.cos(r);
				var y1:Number = cp.y+(radius-10) * Math.sin(r);
				
				g.moveTo(x,y);
				g.lineTo(x1,y1);
				
				var label:Label = new Label();
				label.text = currValue+suffix;
				label.width = 40;
				label.height = 20;
				var labelPoint:Point = DrawerUtil.getPointOfLabel(new Point(x1,y1),40,20,DrawerUtil.getXiangxian(currAngle));
				label.x = labelPoint.x;
				label.y = labelPoint.y;
				content.addChild(label);
				
				if(i<step){
					for(var j:int=0;j<=stepInStep;j++){
						var nums:Number = numOfStep/stepInStep; 
						var ba:Number = currAngle+j*nums;
						var br:Number = Math.PI/180*ba;
						
						var xInstep:Number = cp.x+radius * Math.cos(br);
						var yInstep:Number = cp.y+radius * Math.sin(br);
						
						var xInstep1:Number = cp.x+(radius-3) * Math.cos(br);
						var yInstep1:Number = cp.y+(radius-3) * Math.sin(br);
						
						g.moveTo(xInstep,yInstep);
						g.lineTo(xInstep1,yInstep1);
					}
				}
			}
			
			var value:Number = data["value"];
			var valueAngle:Number = (endAngle-beginAngle)/(max-min)*(value-min)+beginAngle;
			var valuer:Number = Math.PI/180*valueAngle;
			var valuex:Number = cp.x+(radius-5) * Math.cos(valuer);
			var valuey:Number = cp.y+(radius-5) * Math.sin(valuer);
			
			g.lineStyle(2,0x000000);
			g.moveTo(cp.x,cp.y);
			g.lineTo(valuex,valuey);
			
		}
	}
}