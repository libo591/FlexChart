package com.grid.charts.interfaces
{
	import com.grid.charts.model.GridChart;
	
	import morn.core.components.Box;

	/**
	 * 绘制接口，各种类型的图表实现自己的draw方法，绘制图案
	 */
	public interface ISeriesDrawer
	{
		function get points():Array;
		function set points(value:Array):void;
		/**
		 * 绘制接口，各种类型的图表实现自己的draw方法，绘制图案
		 * @param chart 图表实体对象
		 * @param content 绘制的容器
		 * @param seriesIndex 当前系列的索引
		 * @param scale 系列的最大值-最小值与content宽度或高度的比例
		 */
		function draw(chart:GridChart,
					  content:Box,
					  seriesIndex:int,scale:Number):void;
	}
}