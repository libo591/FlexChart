package com.grid.charts.view
{
	import com.grid.charts.ChartController;
	import com.grid.charts.model.ChartTitleStyle;
	import com.grid.charts.model.GridChart;
	
	
	import morn.core.components.Label;
	
	/**
	 * 图表的标题的展现组件
	 */
	public class TitleLabel extends Label
	{
		public function TitleLabel(text:String="", skin:String=null)
		{
			super(text, skin);
		}
		
		public function drawStyle():void{
			var chart:GridChart = ChartController.getInst().chart;
			var style:ChartTitleStyle = chart.chartStyle.titleStyle;
			if(style.borderStyle!="none"){
				this.stroke = ""+style.borderColor;
			}
			this.background = true;
			this.backgroundColor = style.backgroundColor;
		}
	}
}