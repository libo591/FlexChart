package com.grid.charts.series
{
	import com.grid.charts.ChartController;
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.util.DrawerUtil;
	import com.grid.charts.util.SortUtil;
	import com.grid.charts.view.GraphContentMXML;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import morn.core.components.Box;
	
	
	public class PieDrawer implements ISeriesDrawer
	{
		private var _dataarr:Array;
		private var _sumValue:Number;
		private var _content:Box;
		
		public function PieDrawer()
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
			this._sumValue = sum;
			this._content = content;
			this._dataarr = chart.chartData as Array;
			var count:int = this._dataarr.length;
			this._dataarr = SortUtil.sortPieData(this._dataarr);
			var paddinglr:Number = 100;
			var paddingtb:Number = 50;
			var w:Number = content.width - paddinglr*2;
			var h:Number = content.height -paddingtb*2;
			var radius:Number = Math.min(h,w)/2;
			
			var cp:Point = new Point();
			cp.x = (content.width)/2;
			cp.y = (content.height)/2;
			
			var g:Graphics = content.graphics;
			
			g.lineStyle(1,0x000000,1);
			g.drawCircle(cp.x,cp.y,radius);
			var beginAngle:int = -90;
			for(var i:int=0;i<count;i++){
				var currColor:uint = chart.seriesColor[i];
				var currAlpha:Number = chart.seriesAlpha[i];
				var dataobj:Object = this._dataarr[i];
				var label:String = dataobj["label"];
				var value:Number = Number(dataobj["value"]);
				var beforevalue:Number = 0;
				for(var j:int=0;j<i;j++){
					beforevalue+= Number(this._dataarr[j]["value"]);
				}
				var jiaodu:Number = value/sum*360;//角度
				var beforeJiaodu:Number = beforevalue/sum*360+beginAngle;//角度
				jiaodu = Math.PI/180*jiaodu;//弧度
				beforeJiaodu = Math.PI/180*beforeJiaodu;//弧度
				
				g.lineStyle(1,currColor,1);
				g.beginFill(currColor,currAlpha);
				var x0:Number = cp.x+radius*Math.cos(beforeJiaodu);
				var y0:Number = cp.y+radius*Math.sin(beforeJiaodu);
				
				g.moveTo(cp.x,cp.y);
				g.lineTo(x0,y0);
				DrawerUtil.drawCurve(g,beforeJiaodu,beforeJiaodu+jiaodu,cp,radius);
				g.lineTo(cp.x,cp.y);
				g.endFill();
				
				//画引出线，画label
				var xmid:Number = cp.x+radius*Math.cos(beforeJiaodu+jiaodu/2);
				var ymid:Number = cp.y+radius*Math.sin(beforeJiaodu+jiaodu/2);
				var xmid1:Number = cp.x+(radius+10)*Math.cos(beforeJiaodu+jiaodu/2);
				var ymid1:Number = cp.y+(radius+10)*Math.sin(beforeJiaodu+jiaodu/2);
				var pmidxiangxian:int = DrawerUtil.getXiangxian((beforeJiaodu+jiaodu/2)*180/Math.PI);
				var pmid:Point = DrawerUtil.getPointOfPieLine(new Point(xmid1,ymid1),pmidxiangxian);
				g.lineStyle(1,0x000000,1);
				g.moveTo(xmid,ymid);
				g.lineTo(xmid1,ymid1);
				g.lineTo(pmid.x,pmid.y);
				
				var tfw:Number = 100;
				var tfh:Number = 30;
				var tfpoint:Point = DrawerUtil.getPointOfPieLabel(pmid,pmidxiangxian,tfw,tfh);
				var tf:TextField = new TextField();
				tf.x = tfpoint.x;
				tf.y = tfpoint.y;
				tf.width = tfw;
				tf.height = tfh;
				var tformat:TextFormat = new TextFormat();
				tformat.align = TextFormatAlign.CENTER;
				tf.text = label+","+(value/sum*100).toFixed(2)+"%";
				tf.defaultTextFormat = tformat;
				tf.setTextFormat(tformat);
				content.addChild(tf);
			}
			DrawerUtil.alphaAnimation(content);
		}
	}
}