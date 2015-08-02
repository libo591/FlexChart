package com.grid.charts.model
{
	/**
	 * 画图部分样式
	 */
	public class ChartGraphStyle
	{
		/**　是否有横向表格线　*/
		private var _hlines:Boolean=true;
		/**　是否有纵向表格线　*/
		private var _vlines:Boolean=true;
		/**　横向表格线的颜色　*/
		private var _hlinesColor:uint=0xBEBEBE;
		/**　纵向表格线的颜色　*/
		private var _vlinesColor:uint=0xBEBEBE;
		/**　边框样式　*/
		private var _borderStyle:String="solid";
		/**　边框颜色　*/
		private var _borderColor:uint=0x000000;
		/**　边框圆角　*/
		private var _borderRound:int=0;
		/**　背景色，两个值不同时，使用渐进色　*/
		private var _backgroundColor:Array=[0xffffff,0xffffff];
		/**　背景色透明度，两个值不同时，使用渐进色透明度　*/
		private var _backgroundAlpha:Array=[1,1];
		private var _interlacingColor:Array;
		private var _interlacingAlpha:Array;
		public function ChartGraphStyle()
		{
		}

		public function get hlines():Boolean
		{
			return _hlines;
		}

		public function set hlines(value:Boolean):void
		{
			_hlines = value;
		}

		public function get vlines():Boolean
		{
			return _vlines;
		}

		public function set vlines(value:Boolean):void
		{
			_vlines = value;
		}

		public function get hlinesColor():uint
		{
			return _hlinesColor;
		}

		public function set hlinesColor(value:uint):void
		{
			_hlinesColor = value;
		}

		public function get vlinesColor():uint
		{
			return _vlinesColor;
		}

		public function set vlinesColor(value:uint):void
		{
			_vlinesColor = value;
		}

		public function get backgroundColor():Array
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:Array):void
		{
			_backgroundColor = value;
		}

		public function get backgroundAlpha():Array
		{
			return _backgroundAlpha;
		}

		public function set backgroundAlpha(value:Array):void
		{
			_backgroundAlpha = value;
		}

		public function get interlacingColor():Array
		{
			return _interlacingColor;
		}

		public function set interlacingColor(value:Array):void
		{
			_interlacingColor = value;
		}

		public function get interlacingAlpha():Array
		{
			return _interlacingAlpha;
		}

		public function set interlacingAlpha(value:Array):void
		{
			_interlacingAlpha = value;
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

		public function get borderRound():int
		{
			return _borderRound;
		}

		public function set borderRound(value:int):void
		{
			_borderRound = value;
		}


	}
}