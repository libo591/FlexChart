package com.grid.charts.view
{
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	/**
	 * X轴位于图表左侧时的展现组件
	 */
	public class LeftYAxisAs extends YAxisAs
	{
		public function LeftYAxisAs()
		{
		}
		
		override protected function createChildren():void{
			this.yTitle = new Label();
			this.yTitle.width = 20;
			this.yTitle.x = 0;
			this.yTitle.y = 0;
			addChild(this.yTitle);
			this.yAxis = new Box();
			this.yAxis.width = 50;
			this.yAxis.x = 20;
			this.yAxis.y = 0;
			addChild(this.yAxis);
		}
		
	}
}