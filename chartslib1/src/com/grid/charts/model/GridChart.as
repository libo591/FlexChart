package com.grid.charts.model
{

	public class GridChart
	{
		/** X轴文本后缀 */
		private var _xSuffix:String;
		/** Y轴文本后缀 */
		private var _ySuffix:String;
		/** 标题 */
		private var _title:String;
		/** 副标题 */
		private var _subTitle:String;
		/** 分类轴对象 */
		private var _typeaxis:TypeGridChartAxis;
		/** 系列轴对象数组 */
		private var _seriesaxis:Array;
		/** 系列对象数组 */
		private var _series:Array;
		/** 图表数据 */
		private var _chartData:Object;
		/** 饼图值后缀 */
		private var _valueSuffiex:String;
		/** 百分比精度 */
		private var _precision:int;
		/** 图表类型，在系列类型之上的大分类 */
		private var _type:String;
		/** 饼图用，作用未知 */
		private var _model:String;
		/** 雷达图最大值 */
		private var _max:Number;//radar
		/** 雷达图最小值 */
		private var _min:Number;//radar
		/** 雷达图网线间隔数 */
		private var _numDiv:int;
		/** 是否显示多系列轴数值 */
		private var _multiSeriesAxis:Boolean=false;
		
		/** 图表样式 */
		private var _chartStyle:ChartStyle;
		/** 系列颜色数组 */
		private var _seriesColor:Array=[];
		/** 系列颜色透明度数组 */
		private var _seriesAlpha:Array=[];
		
		public function GridChart()
		{
		}

		public function get xSuffix():String
		{
			return _xSuffix;
		}

		public function set xSuffix(value:String):void
		{
			_xSuffix = value;
		}

		public function get typeaxis():TypeGridChartAxis
		{
			return _typeaxis;
		}

		public function set typeaxis(value:TypeGridChartAxis):void
		{
			_typeaxis = value;
		}
		public function get seriesaxis():Array
		{
			return _seriesaxis;
		}
		
		public function set seriesaxis(value:Array):void
		{
			_seriesaxis = value;
		}

		public function get ySuffix():String
		{
			return _ySuffix;
		}

		public function set ySuffix(value:String):void
		{
			_ySuffix = value;
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		public function get subTitle():String
		{
			return _subTitle;
		}

		public function set subTitle(value:String):void
		{
			_subTitle = value;
		}

		public function get series():Array
		{
			return _series;
		}

		public function set series(value:Array):void
		{
			_series = value;
		}

		public function get chartData():Object
		{
			return _chartData;
		}

		public function set chartData(value:Object):void
		{
			_chartData = value;
		}

		public function get valueSuffiex():String
		{
			return _valueSuffiex;
		}

		public function set valueSuffiex(value:String):void
		{
			_valueSuffiex = value;
		}

		public function get precision():int
		{
			return _precision;
		}

		public function set precision(value:int):void
		{
			_precision = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get model():String
		{
			return _model;
		}

		public function set model(value:String):void
		{
			_model = value;
		}

		public function get max():Number
		{
			return _max;
		}

		public function set max(value:Number):void
		{
			_max = value;
		}

		public function get min():Number
		{
			return _min;
		}

		public function set min(value:Number):void
		{
			_min = value;
		}

		public function get chartStyle():ChartStyle
		{
			if(_chartStyle==null){
				_chartStyle = new ChartStyle();
			}
			return _chartStyle;
		}

		public function set chartStyle(value:ChartStyle):void
		{
			_chartStyle = value;
		}

		public function get numDiv():int
		{
			return _numDiv;
		}

		public function set numDiv(value:int):void
		{
			_numDiv = value;
		}

		public function get multiSeriesAxis():Boolean
		{
			return _multiSeriesAxis;
		}

		public function set multiSeriesAxis(value:Boolean):void
		{
			_multiSeriesAxis = value;
		}

		public function get seriesColor():Array
		{
			return _seriesColor;
		}

		public function set seriesColor(value:Array):void
		{
			_seriesColor = value;
		}

		public function get seriesAlpha():Array
		{
			return _seriesAlpha;
		}

		public function set seriesAlpha(value:Array):void
		{
			_seriesAlpha = value;
		}


	}
}