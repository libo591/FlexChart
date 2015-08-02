package com.grid.charts.model
{
	/**
	 * 序列样式
	 */
	public class ChartSeriesStyle
	{
		public static const CIRCLE:String = "实心圆";
		public static const RECT:String = "方块";
		public static const TRIANGLES:String = "三角形";
		public static const RHOMBUS:String = "菱形";
		
		/**　是否显示数据label　*/
		private var _labelVisiable:Boolean=false;
		/**　字体　*/
		private var _family:String;
		/**　字号　*/
		private var _size:int=12;
		/**　字色　*/
		private var _color:uint=0x000000;
		/**　加粗　*/
		private var _bold:Boolean=false;
		/**　斜体　*/
		private var _italic:Boolean=false;
		/**　线的宽度　*/
		private var _weight:int=3;
		/**　节点类型　*/
		private var _pointType:String=CIRCLE;
		/**　雷达图是否填充　*/
		private var _isFill:Boolean=false;
		/**　线型　*/
		private var _lineType:String="solid";
		/**　线色　*/
		private var _lineColor:uint=0x000000;
		public function ChartSeriesStyle()
		{
		}

		public function get labelVisiable():Boolean
		{
			return _labelVisiable;
		}

		public function set labelVisiable(value:Boolean):void
		{
			_labelVisiable = value;
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

		public function get weight():int
		{
			return _weight;
		}

		public function set weight(value:int):void
		{
			_weight = value;
		}

		public function get pointType():String
		{
			return _pointType;
		}

		public function set pointType(value:String):void
		{
			_pointType = value;
		}

		public function get isFill():Boolean
		{
			return _isFill;
		}

		public function set isFill(value:Boolean):void
		{
			_isFill = value;
		}

		public function get lineType():String
		{
			return _lineType;
		}

		public function set lineType(value:String):void
		{
			_lineType = value;
		}

		public function get lineColor():uint
		{
			return _lineColor;
		}

		public function set lineColor(value:uint):void
		{
			_lineColor = value;
		}


	}
}