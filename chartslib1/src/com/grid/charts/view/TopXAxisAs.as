package com.grid.charts.view
{
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	/**
	 * X轴位于图表上方时的展现组件
	 */
	public class TopXAxisAs extends XAxisAs
	{
		public function TopXAxisAs()
		{
		}
		
		override protected function createChildren():void{
			this.xTitle = new Label();
			this.xTitle.width = this.width;
			this.xTitle.height = 20;
			this.xTitle.x = 0;
			this.xTitle.y = 0;
			addChild(this.xTitle);
			
			this.xAxis = new Box();
			this.xAxis.width = this.width;
			this.xAxis.height = 40;
			this.xAxis.x = 0;
			this.xAxis.y = this.xTitle.height;
			addChild(this.xAxis);
		}
	}
}