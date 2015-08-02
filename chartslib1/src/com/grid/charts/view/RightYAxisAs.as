package com.grid.charts.view
{
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	/**
	 * X轴位于图表右侧时的展现组件
	 */
	public class RightYAxisAs extends YAxisAs
	{
		public function RightYAxisAs()
		{
		}
		
		override protected function createChildren():void{
			this.yAxis = new Box();
			this.yAxis.height = this.height;
			this.yAxis.width = 50;
			this.yAxis.x = 0;
			this.yAxis.y = 0;
			addChild(this.yAxis);
			this.yTitle = new Label();
			this.yTitle.height = this.height;
			this.yTitle.width = 20;
			this.yTitle.x = this.yAxis.width;
			this.yTitle.y = 0;
			addChild(this.yTitle);
		}
	}
}