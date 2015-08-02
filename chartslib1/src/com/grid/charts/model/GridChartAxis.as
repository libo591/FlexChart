package com.grid.charts.model
{
	/**　图表轴对象　*/
	public class GridChartAxis
	{
		/**　图表轴类型 field 分类轴 linear 系列轴　*/
		private var _type:String;
		/**　图表轴标题　*/
		private var _title:String;
		public function GridChartAxis()
		{
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}


	}
}