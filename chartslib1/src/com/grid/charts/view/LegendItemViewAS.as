package com.grid.charts.view
{
	import com.grid.charts.ChartEvent;
	
	import flash.events.MouseEvent;
	
	import morn.core.components.CheckBox;
	
	/**
	 * 图表的图例中的元素的展现组件
	 */
	public class LegendItemViewAS extends CheckBox
	{
		public function LegendItemViewAS(label:String="")
		{
			super("png.comp.checkbox",label);
			this.selected = true;
			this.addEventListener(MouseEvent.CLICK,seriesClick);
		}
		private function seriesClick(event:MouseEvent):void
		{
			var chartEvent:ChartEvent =null;
			if(this.selected){
				chartEvent = new ChartEvent(ChartEvent.CHARTEVENT_SERIESSHOW);
			}else{
				chartEvent = new ChartEvent(ChartEvent.CHARTEVENT_SERIESHIDE);
			}
			chartEvent.str1 = this.label;
			chartEvent.dispatch();
		}
	}
}