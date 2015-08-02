package com.grid.charts.util
{
	/**
	 * 排序工具类
	 */
	public class SortUtil
	{
		public function SortUtil()
		{
		}
		
		/**
		 * 排序饼图的数据
		 */
		public static function sortPieData(dataarr:Array):Array{
			var count:int = dataarr.length;
			//从大到小排序
			for(var j:int=0;j<count;j++){
				var maxValueIndex:int = j ; 
				var maxValue:Number = Number(dataarr[j]["value"]);
				for(var i:int=j+1;i<count;i++){
					var dataobj:Object = dataarr[i];
					var value:Number = Number(dataobj["value"]);
					if(value>maxValue){
						maxValue = value;
						maxValueIndex = i;
					}
				}
				
				if(maxValueIndex!=j){
					var temp:Object = dataarr[j];
					dataarr[j] = dataarr[maxValueIndex];
					dataarr[maxValueIndex] = temp;
				}
			}
			return dataarr;
		}
	}
}