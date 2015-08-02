package com.grid.charts
{
	
	import flash.events.Event;

	/**
	 * 图标事件类
	 */
	public class ChartEvent extends Event
	{
		
		/** 重绘图标 */
		public static var CHARTEVENT_SHOWCHART:String="0001";
		/** 展现某个系列 */
		public static var CHARTEVENT_SERIESSHOW:String="0002";
		/** 隐藏某个系列 */
		public static var CHARTEVENT_SERIESHIDE:String="0003";
		
		
		private var _str1:String;
		private var _str2:String;
		private var _cells1:Array;
		private var _int1:int;
		private var _int2:int;
		private var _num1:Number;
		private var _bool1:Boolean=true;
		
		/** ============================ */
		
		/** 构造函数 */
		public function ChartEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}

		public function get num1():Number
		{
			return _num1;
		}

		public function set num1(value:Number):void
		{
			_num1 = value;
		}

		public function get int2():int
		{
			return _int2;
		}

		public function set int2(value:int):void
		{
			_int2 = value;
		}

		public function get int1():int
		{
			return _int1;
		}

		public function set int1(value:int):void
		{
			_int1 = value;
		}

		/** 派发事件*/
		public function dispatch():Boolean{
			return ChartEventDispatcher.getInstance().dispatchEvent(this);
		}

		/** ============================ */
		public function get str1():String
		{
			return _str1;
		}

		/**
		 * @private
		 */
		public function set str1(value:String):void
		{
			_str1 = value;
		}

		public function get cells1():Array
		{
			return _cells1;
		}

		public function set cells1(value:Array):void
		{
			_cells1 = value;
		}

		public function get str2():String
		{
			return _str2;
		}

		public function set str2(value:String):void
		{
			_str2 = value;
		}

		public function get bool1():Boolean
		{
			return _bool1;
		}

		public function set bool1(value:Boolean):void
		{
			_bool1 = value;
		}


	}
}