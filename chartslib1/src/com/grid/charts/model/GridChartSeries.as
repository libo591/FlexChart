package com.grid.charts.model
{
	/**
	 * 图表系列对象
	 */
	public class GridChartSeries
	{
		/**
		 * 内置配色方案，线颜色
		 */
		public static var LINE_COLORS:Array=[0x30CCED,0xC5F13F,0xEA7FEC,
											0x79EFEF,0xEBC13E,0xFA5A9B,0x7E8592,0x9A7BEC,0x59C6CF,0xFB8B65,0xA8FBFC,0xE1FB49];
		/**
		 * 内置配色方案，点颜色
		 */
		public static var POINT_COLORS:Array=[0x26A7E6,0x7E9B25,0xB963BD,
											0x62C0C0,0xB1943B,0xEA4983,0x666C74,0x7C65BA,0x4E99A1,0xEE7258,0x7FCDE8,0xA5D145];
		/**　分类轴的数据key值　*/
		private var _xField:String;
		/**　数据轴的数据key值　*/
		private var _yField:String;
		/**　气泡图的半径值key值　*/
		private var _radiusField:String;
		/**　系列类型　*/
		private var _type:String;
		/**　是否为曲线图　*/
		private var _smooth:Boolean;
		/**　是否为拐点图　*/
		private var _step:Boolean;
		/**　系列名称　*/
		private var _name:String;
		
		public function GridChartSeries()
		{
		}

		public function get xField():String
		{
			return _xField;
		}

		public function set xField(value:String):void
		{
			_xField = value;
		}

		public function get yField():String
		{
			return _yField;
		}

		public function set yField(value:String):void
		{
			_yField = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get smooth():Boolean
		{
			return _smooth;
		}

		public function set smooth(value:Boolean):void
		{
			_smooth = value;
		}

		public function get step():Boolean
		{
			return _step;
		}

		public function set step(value:Boolean):void
		{
			_step = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get radiusField():String
		{
			return _radiusField;
		}

		public function set radiusField(value:String):void
		{
			_radiusField = value;
		}

	}
}