package com.grid.charts.model
{
	/**
	 * 统计图整体外观相关样式
	 */
	public class ChartStyle
	{
		/** 边框样式 solid dash none */
		private var _borderStyle:String="solid";
		/** 边框颜色 0x000000 */
		private var _borderColor:uint=0x000000;
		/** 边框圆角 */
		private var _borderRound:int=20;
		/** 背景颜色 0xffffff */
		private var _backgroundColor:uint=0xffffff;
		/** 背景透明度 1 */
		private var _backgroundAlpha:Number = 1;
		/** 标题样式 */
		private var _titleStyle:ChartTitleStyle;
		/** 副标题样式 */
		private var _subTitleStyle:ChartSubTitleStyle;
		/** 图例样式 */
		private var _legendStyle:ChartLegendStyle;
		/** 序列样式 */
		private var _seriesStyle:ChartSeriesStyle;
		/** 坐标轴样式 */
		private var _axisStyle:ChartAxisStyle;
		/** 画图区域样式 */
		private var _graphStyle:ChartGraphStyle;
		public function ChartStyle()
		{
		}

		public function get borderStyle():String
		{
			return _borderStyle;
		}

		public function set borderStyle(value:String):void
		{
			_borderStyle = value;
		}

		public function get borderColor():uint
		{
			return _borderColor;
		}

		public function set borderColor(value:uint):void
		{
			_borderColor = value;
		}

		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
		}

		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}

		public function set backgroundAlpha(value:Number):void
		{
			_backgroundAlpha = value;
		}

		public function get titleStyle():ChartTitleStyle
		{
			if(_titleStyle==null){
				_titleStyle = new ChartTitleStyle();
			}
			return _titleStyle;
		}

		public function set titleStyle(value:ChartTitleStyle):void
		{
			_titleStyle = value;
		}

		public function get subTitleStyle():ChartSubTitleStyle
		{
			if(_subTitleStyle==null){
				_subTitleStyle = new ChartSubTitleStyle();
			}
			return _subTitleStyle;
		}

		public function set subTitleStyle(value:ChartSubTitleStyle):void
		{
			_subTitleStyle = value;
		}

		public function get legendStyle():ChartLegendStyle
		{
			if(_legendStyle==null){
				_legendStyle = new ChartLegendStyle();
			}
			return _legendStyle;
		}

		public function set legendStyle(value:ChartLegendStyle):void
		{
			_legendStyle = value;
		}

		public function get seriesStyle():ChartSeriesStyle
		{
			if(_seriesStyle==null){
				_seriesStyle = new ChartSeriesStyle();
			}
			return _seriesStyle;
		}

		public function set seriesStyle(value:ChartSeriesStyle):void
		{
			_seriesStyle = value;
		}

		public function get axisStyle():ChartAxisStyle
		{
			if(_axisStyle==null){
				_axisStyle = new ChartAxisStyle();
			}
			return _axisStyle;
		}

		public function set axisStyle(value:ChartAxisStyle):void
		{
			_axisStyle = value;
		}

		public function get graphStyle():ChartGraphStyle
		{
			if(_graphStyle==null){
				_graphStyle = new ChartGraphStyle();
			}
			return _graphStyle;
		}

		public function set graphStyle(value:ChartGraphStyle):void
		{
			_graphStyle = value;
		}

		/** 边框圆角 */
		public function get borderRound():int
		{
			return _borderRound;
		}

		/**
		 * @private
		 */
		public function set borderRound(value:int):void
		{
			_borderRound = value;
		}


	}
}