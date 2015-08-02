package com.grid.charts.series
{
	import com.grid.charts.interfaces.ISeriesDrawer;

	public class SeriesFactory
	{
		public function SeriesFactory()
		{
		}
		
		public static function getSeriesDrawer(type:String):ISeriesDrawer{
			if(type=="line"){
				return new LineSeriesDrawer();
			}else if(type=="area"){
				return new AreaSeriesDrawer();
			}else if(type=="column"){
				return new ColumnSeriesDrawer();
			}else if(type=="bar"){
				return new BarSeriesDrawer();
			}else if(type=="stack"){
				return new StackSeriesDrawer();
			}else if(type=="marker"){
				return new MarkerSeriesDrawer();
			}else if(type=="bubble"){
				return new BubbleSeriesDrawer();
			}else if(type=="fullstack"){
				return new FullStackSeriesDrawer();
			}else if(type=="stackbar"){
				return new StackBarSeriesDrawer();
			}else if(type=="fullstackbar"){
				return new FullStackBarSeriesDrawer();
			}else if(type=="pie"){
				return new PieDrawer();
			}else if(type=="gauges"){
				return new GaugesDrawer();
			}else if(type=="lineargauges"){
				return new LinearGaugesDrawer();
			}else if(type=="Cylindergauges"){
				return new CylinderGaugesDrawer();
			}else if(type=="radar"){
				return new RadarDrawer();
			}
			/*else if(type=="column3D"){
				return new Column3DSeriesDrawer();
			}*/
			return new NoneDrawer();
		}
	}
}