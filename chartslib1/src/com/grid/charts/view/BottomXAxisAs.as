package com.grid.charts.view
{
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	/**
	 * X轴位于图表下侧时的展现组件
	 */
	public class BottomXAxisAs extends XAxisAs
	{
		public function BottomXAxisAs()
		{
		}
		
		override protected function createChildren():void{
			this.xAxis = new Box();
			this.xAxis.width = this.width;
			this.xAxis.height = 40;
			this.xAxis.y = 0;
			this.xAxis.x = 0;
			addChild(this.xAxis);
			
			this.xTitle = new Label();
			this.xTitle.width = this.width;
			this.xTitle.height = 20;
			this.xTitle.y = 40;
			this.xTitle.x = 0;
			addChild(this.xTitle);
		}
	}
}