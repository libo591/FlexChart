package com.grid.charts.model
{
	/**
	 * 数据轴对象
	 */
	public class SeriesGridChartAxis extends GridChartAxis
	{
		/** 数据轴结束值 */
		private var _serieValueEnd:Number;
		/** 数据轴起始值 */
		private var _serieValueBegin:Number;
		/** 是否绘制零值线 */
		private var _needZeroLine:Boolean=false;
		/** 数据轴值的增量 */
		private var _inc:Number=5;
		
		public function SeriesGridChartAxis()
		{
			super();
		}
		
		
		public function get serieValueEnd():Number
		{
			return _serieValueEnd;
		}
		
		public function set serieValueEnd(value:Number):void
		{
			_serieValueEnd = value;
		}

		public function get serieValueBegin():Number
		{
			return _serieValueBegin;
		}

		public function set serieValueBegin(value:Number):void
		{
			_serieValueBegin = value;
		}

		public function get needZeroLine():Boolean
		{
			return _needZeroLine;
		}

		public function set needZeroLine(value:Boolean):void
		{
			_needZeroLine = value;
		}

		public function get inc():Number
		{
			return _inc;
		}

		public function set inc(value:Number):void
		{
			_inc = value;
		}


	}
}