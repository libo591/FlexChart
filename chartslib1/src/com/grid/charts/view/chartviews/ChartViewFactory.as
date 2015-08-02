package com.grid.charts.view.chartviews
{
	import com.boboeye.basic.LicUtil;

	public class ChartViewFactory
	{
		private static var _inst:ChartViewFactory = new ChartViewFactory();
		public function ChartViewFactory()
		{
		}
		public static function getInst():ChartViewFactory{
			return _inst;
		}
		
		public function createChartView(type):ChartView{
			/*if(!LicUtil.hasLic){
				LicUtil.licStr = String(App.asset.getAsset("lic.boboeye"));
			}*/
			if(type=="pie"){
				return new PieChartView();
			}else if(type!=null&&type.indexOf("gauges")!=-1){
				return new GaugesChartView();
			}else if(type=="radar"){
				return new RadarChartView();
			}else{
				return new ChartView();
			}
		}
	}
}