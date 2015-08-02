package com.grid.charts.view
{
	import morn.core.components.Box;
	import morn.core.components.Label;

	/**
	 * X轴组件
	 */
	public class XAxisAs extends Box
	{
		private var _xTitle:Label;
		private var _xAxis:Box;
		public function XAxisAs()
		{
			super();
		}

		public function get xTitle():Label
		{
			return _xTitle;
		}

		public function set xTitle(value:Label):void
		{
			_xTitle = value;
		}

		public function get xAxis():Box
		{
			return _xAxis;
		}

		public function set xAxis(value:Box):void
		{
			_xAxis = value;
		}
		override public function set width(value:Number):void{
			super.width = value;
			this.xTitle.width = value;
			this.xAxis.width = value;
		}

	}
}