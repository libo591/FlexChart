package com.grid.charts.series
{
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	public class LinearGaugesDrawer implements ISeriesDrawer
	{
		public function LinearGaugesDrawer()
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
			
			var data:Object = chart.chartData;
			
			var w:Number = content.width - padding1*2;
			var h:Number = content.height - padding2*2;
			
			var x:Number = padding1;
			var y:Number = padding2;
			
			var bcolor1:uint = 0x38A8D0;
			var bcolor2:uint = 0x09DBFE;
			
			
			var sp:Sprite = new Sprite();
			sp.x = x;
			sp.y = y;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w,h*2/3,90,0,0);
			
			var spg:Graphics = sp.graphics;
			spg.lineStyle(1,0x004D69);
			spg.beginGradientFill(GradientType.LINEAR,[bcolor1,bcolor2],[1,1],[0,255],matrix);
			spg.drawRoundRect(0,0,w,h*2/3,20,20);
			spg.endFill();
			content.addChild(sp);
			
			var min:Number = parseFloat(data["min"]);
			var max:Number = parseFloat(data["max"]);
			var nowvalue:Number = parseFloat(data["value"]);
			var step:int = parseInt(data["step"]);
			var stepInStep:int = parseInt(data["stepInStep"]);
			var suffix:String = data["suffix"];
			var lrpadding:Number = 20;
			var chiziW:Number = w-lrpadding*2;
			var stepNum:Number = chiziW/step;
			var stepValue:Number = (max-min)/step;
			for(var i:int=0;i<=step;i++){
				spg.lineStyle(2,0x000000,1);
				var sx:Number = lrpadding+i*stepNum;
				spg.moveTo(sx,0);
				spg.lineTo(sx,10);
				
				var currValue:Number = min+i*stepValue;
				var stepLabel:Label = new Label();
				stepLabel.x = sp.x+sx-5;
				stepLabel.y = sp.y+15;
				stepLabel.text = currValue+"";
				content.addChild(stepLabel);
				
				if(i<step){
					spg.lineStyle(1,0x000000,1);
					var stepInStepNum:Number = stepNum/stepInStep;
					for(var j:int=0;j<=stepInStep;j++){
						var sx2:Number = sx+j*stepInStepNum;
						spg.moveTo(sx2,0);
						spg.lineTo(sx2,5);
					}
				}
			}
			
			var valueWidth:Number = chiziW*(nowvalue-min)/(max-min);
			var vec:Vector.<Number> = new Vector.<Number>();
			vec.push(sp.x+lrpadding+valueWidth-5,sp.y-10);
			vec.push(sp.x+lrpadding+valueWidth+5,sp.y-10);
			vec.push(sp.x+lrpadding+valueWidth,sp.y);
			g.lineStyle(1,0x000000);
			g.beginFill(0xFF0000,1);
			g.drawTriangles(vec);
			g.endFill();
			
			var valueLabel:Label = new Label();
			valueLabel.text = nowvalue+"";
			valueLabel.width = 50;
			valueLabel.height = 20;
			valueLabel.x = sp.x+lrpadding+valueWidth-valueLabel.width/2;
			valueLabel.y = sp.y-10-20;
			valueLabel.align = "center";
			content.addChild(valueLabel);
			
			/*var bitmapdata:BitmapData = new BitmapData(w,h*2/3);
			bitmapdata.draw(sp);
			
			var m2:Matrix = new Matrix();
			//m2.rotate(Math.PI/4);
			m2.translate(x,0);
			//m2.scale(1,2/3);
			g.lineStyle(0,0,0);
			g.beginBitmapFill(bitmapdata,m2,false,false);
			g.drawRoundRect(x,y+h*2/3,w,h/3,20,20);
			g.endFill();*/
		}
		
	}
}