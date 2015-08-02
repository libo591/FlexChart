package com.grid.charts.view
{
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	/**
	 * Y轴组件
	 */
	public class YAxisAs extends Box
	{
		private var _yAxis:Box;
		private var _yTitle:Label;
		public function YAxisAs()
		{
			super();
		}

		public function get yAxis():Box
		{
			return _yAxis;
		}

		public function set yAxis(value:Box):void
		{
			_yAxis = value;
		}

		public function get yTitle():Label
		{
			return _yTitle;
		}

		public function set yTitle(value:Label):void
		{
			_yTitle = value;
		}

		override public function set height(value:Number):void{
			super.height = value;
			this.yTitle.height = value;
			this.yAxis.height = value;
		}
	}
}