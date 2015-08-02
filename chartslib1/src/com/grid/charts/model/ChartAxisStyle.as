package com.grid.charts.model
{
	/**
	 * 坐标轴样式
	 */
	public class ChartAxisStyle
	{
		/** 坐标轴类型，是分类轴还是系列轴 */
		private var _type:String;
		/** 文本颜色 */
		private var _color:uint;
		/** 文本角度 */
		private var _angle:int;
		/** 预警值数组 */
		private var _alarmValues:Array;
		
		public function ChartAxisStyle()
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

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		public function get angle():int
		{
			return _angle;
		}

		public function set angle(value:int):void
		{
			_angle = value;
		}

		public function get alarmValues():Array
		{
			return _alarmValues;
		}

		public function set alarmValues(value:Array):void
		{
			_alarmValues = value;
		}


	}
}