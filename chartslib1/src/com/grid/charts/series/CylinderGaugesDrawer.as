package com.grid.charts.series
{
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.util.DrawerUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	public class CylinderGaugesDrawer implements ISeriesDrawer
	{
		public function CylinderGaugesDrawer()
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
			var padding1:Number = content.width/3;
			var padding2:Number = 50;
			var g:Graphics = content.graphics;
			g.clear();
			
			var data:Object = chart.chartData;
			
			var w:Number = content.width - padding1*2;
			var h:Number = content.height - padding2*2;
			
			var x:Number = padding1;
			var y:Number = padding2;
			
			g.lineStyle(1,0x000000,1);
			g.beginFill(0xF3F3F3,1);
			g.drawRect(x,y,w,h);
			g.endFill();
			
			var lrpadding:Number = 10;
			var rightAxisWidth:Number = (w-lrpadding*2)/3;
			var leftWidth:Number = rightAxisWidth*2;
			var lradis:Number = leftWidth/2;
			var sradis:Number = lradis/3;
			var tbpadding:Number = 10;
			var blp:Point = new Point(x+lrpadding,y+h-tbpadding-sradis);
			var rh:Number = h-tbpadding*2-sradis*2;
			DrawerUtil.drawYuanzhu(g,blp,
				lradis,sradis,rh,0x000000,0xE2E2E2);
			
			
			var min:Number = parseFloat(data["min"]);
			var max:Number = parseFloat(data["max"]);
			var nowvalue:Number = parseFloat(data["value"]);
			var step:int = parseInt(data["step"]);
			var stepInStep:int = parseInt(data["stepInStep"]);
			var suffix:String = data["suffix"];
			
			var valueH:Number = rh*(nowvalue-min)/(max-min);
			DrawerUtil.drawYuanzhu(g,blp,
				lradis,sradis,valueH,0x000000,0xBFBFBF);
			
			var sx:Number = blp.x+lradis*2+lrpadding;
			var stepNum:Number = rh/step;
			var stepValue:Number = (max-min)/step;
			for(var i:int=0;i<=step;i++){
				g.lineStyle(2,0x000000,1);
				var sy:Number = blp.y-i*stepNum;
				g.moveTo(sx,sy);
				g.lineTo(sx+10,sy);
				
				var currValue:Number = min+i*stepValue;
				var stepLabel:Label = new Label();
				stepLabel.x = sx+15;
				stepLabel.y = sy-5;
				stepLabel.text = currValue+suffix;
				content.addChild(stepLabel);
				
				if(i<step){
					g.lineStyle(1,0x000000,1);
					var stepInStepNum:Number = stepNum/stepInStep;
					for(var j:int=0;j<=stepInStep;j++){
						var sy2:Number = sy-j*stepInStepNum;
						g.moveTo(sx,sy2);
						g.lineTo(sx+5,sy2);
					}
				}
			}
			
		}
		
	}
}