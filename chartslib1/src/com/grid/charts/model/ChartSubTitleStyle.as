package com.grid.charts.model
{
	/**
	 * 副标题样式
	 */
	public class ChartSubTitleStyle
	{
		/**　字体　*/
		private var _family:String;
		/**　字号　*/
		private var _size:int=14;
		/**　字色　*/
		private var _color:uint=0x000000;
		/**　加粗　*/
		private var _bold:Boolean=false;
		/**　斜体　*/
		private var _italic:Boolean=false;
		/**　水平对齐　*/
		private var _align:String="center";
		/**　边框类型　*/
		private var _borderStyle:String="none";
		/**　边框颜色　*/
		private var _borderColor:uint=0xffffff;
		/**　边框圆角　*/
		private var _borderRound:int=0;
		/**　背景色　*/
		private var _backgroundColor:uint=0xffffff;
		/**　背景色透明度　*/
		private var _backgroundAlpha:Number=1;
		public function ChartSubTitleStyle()
		{
		}
		public function get family():String
		{
			return _family;
		}
		
		public function set family(value:String):void
		{
			_family = value;
		}
		
		public function get size():int
		{
			return _size;
		}
		
		public function set size(value:int):void
		{
			_size = value;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
		
		public function get bold():Boolean
		{
			return _bold;
		}
		
		public function set bold(value:Boolean):void
		{
			_bold = value;
		}
		
		public function get italic():Boolean
		{
			return _italic;
		}
		
		public function set italic(value:Boolean):void
		{
			_italic = value;
		}
		
		public function get align():String
		{
			return _align;
		}
		
		public function set align(value:String):void
		{
			_align = value;
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
	}
}