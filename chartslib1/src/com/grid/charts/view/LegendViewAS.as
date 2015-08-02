package com.grid.charts.view
{
	import com.grid.charts.ChartController;
	import com.grid.charts.model.ChartLegendStyle;
	import com.grid.charts.model.ChartStyle;
	import com.grid.charts.model.GridChart;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import morn.core.components.Box;
	
	/**
	 * 图表的图例的展现组件
	 */
	public class LegendViewAS extends Box
	{
		public function LegendViewAS()
		{
			super();
		}
		
		public function drawStyle():void{
			var chart:GridChart = ChartController.getInst().chart;
			var style:ChartStyle = chart.chartStyle;
			var legendStyle:ChartLegendStyle = style.legendStyle;
			var shape:Shape = new Shape();
			this.addChildAt(shape,0);
			var g:Graphics = shape.graphics;
			if(legendStyle.borderStyle!="none"){
				g.lineStyle(1,legendStyle.borderColor);
			}
			g.beginFill(legendStyle.backgroundColor,legendStyle.backgroundAlpha);
			g.drawRoundRect(0,0,this.width,this.height,legendStyle.borderRound,legendStyle.borderRound);
			g.endFill();
			var count:int = this.numChildren;
			for(var i:int=0;i<count;i++){
				var item:LegendItemViewAS = this.getChildAt(i) as LegendItemViewAS;
				if(item){
					item.labelFont = legendStyle.family;
					item.labelSize = legendStyle.size;
					item.labelBold = legendStyle.bold;
				}
			}
		}
	}
}