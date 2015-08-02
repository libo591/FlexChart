package com.grid.charts.model
{
	/**
	 * 分类轴对象
	 */
	public class TypeGridChartAxis extends GridChartAxis
	{
		/**
		 * 分类轴是否在X轴上
		 */
		private var _isOnX:Boolean=true;
		public function TypeGridChartAxis()
		{
			super();
		}

		public function get isOnX():Boolean
		{
			return _isOnX;
		}

		public function set isOnX(value:Boolean):void
		{
			_isOnX = value;
		}

	}
}