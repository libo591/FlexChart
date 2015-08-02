package com.grid.charts.view.chartviews
{
	import com.boboeye.basic.BasicConst;
	import com.boboeye.basic.LicUtil;
	import com.grid.charts.ChartController;
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.ChartGraphStyle;
	import com.grid.charts.model.ChartLegendStyle;
	import com.grid.charts.model.ChartStyle;
	import com.grid.charts.model.ChartSubTitleStyle;
	import com.grid.charts.model.ChartTitleStyle;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.model.SeriesGridChartAxis;
	import com.grid.charts.model.TypeGridChartAxis;
	import com.grid.charts.series.SeriesFactory;
	import com.grid.charts.view.BottomXAxisAs;
	import com.grid.charts.view.GraphContentAS;
	import com.grid.charts.view.LeftYAxisAs;
	import com.grid.charts.view.LegendItemViewAS;
	import com.grid.charts.view.LegendViewAS;
	import com.grid.charts.view.RightYAxisAs;
	import com.grid.charts.view.TitleLabel;
	import com.grid.charts.view.TopXAxisAs;
	import com.grid.charts.view.XAxisAs;
	import com.grid.charts.view.YAxisAs;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import morn.core.components.Box;
	import morn.core.components.Label;
	
	/**
	 * 图表的展现组件
	 */
	public class ChartView extends Box
	{
		/** 主标题 */
		private var _titleLabel:TitleLabel;
		/** 副标题 */
		private var _subTitleLabel:Label;
		/** 图例 */
		private var _legend:LegendViewAS;
		/** 主绘图区 */
		private var _main:Box;
		public function ChartView()
		{
			super();
		}
		/**
		 * 重绘内容
		 */
		public function reshow():void{
			clear();
			showOuter();
			showTitle();
			showSubTitle();
			showLegend();
			showMain();
			//title,subtitle,legend,graph,x-axis-data,y-axis-data
			//drawShuiyin();
		}
		
		private function drawShuiyin():void
		{
			/*var checkFunc:Boolean = LicUtil.checkFunc(BasicConst.FUNC_CHART_NORMAL);
			var checkVersion:String = LicUtil.licInfo.version;
			var hasSHUIYIN:Boolean = checkVersion==BasicConst.VERSION_FREE
										||!checkFunc;
			var hasUrlTimer:Boolean = !checkFunc;
			if(hasSHUIYIN){
				var bitdata:BitmapData = App.asset.getBitmapData("jpg.SHUIYIN");
				var bitmap:Bitmap = new Bitmap(bitdata);
				bitmap.x = this.x;
				bitmap.y = this.y;
				bitmap.width = this.width;
				bitmap.height = this.height;
				bitmap.alpha = 0.1;
				addChild(bitmap);
				
			}
			
			if(hasUrlTimer){
				App.timer.doLoop(1000*60*3,urlTimer);
			}*/
		}
		/*private function urlTimer():void{
			navigateToURL(new URLRequest("http://boboeye.jd-app.com/"),"_blank");
		}*/
		protected function showLegend():void{
			//添加图例
			var chart:GridChart = ChartController.getInst().chart;
			var seriesArr:Array = chart.series;
			var dataJson:Array = chart.chartData as Array;
			var count:int = 0;
			if(chart.type=="pie"){
				count = dataJson.length; 
			}else{
				count = seriesArr.length;
			}
			if(count<=1){
				legendWidth = 0;
				legendHeight = 0;
				return;
			}else{
				if(chart.type=="pie"){
					legendWidth = 120;
				}else{
					legendWidth = 80;
				}
				legendHeight = 30;
			}
			var lgStyle:ChartLegendStyle = chart.chartStyle.legendStyle;
			if(_legend==null){
				_legend = new LegendViewAS();
				this.addChild(_legend);
			}
			if(lgStyle.position=="top"||lgStyle.position=="bottom"){
				_legend.width = count*legendWidth;
				_legend.height = legendHeight-innerPadding*2;
				_legend.x = (this.width-legend.width)/2;
				if(lgStyle.position=="top"){
					_legend.y = innerPadding;
					if(this.titleLabel){_legend.y+=this.titleLabel.y+this.titleLabel.height;}
					if(this.subTitleLabel){_legend.y+=this.subTitleLabel.y+this.subTitleLabel.height;}
				}else{
					_legend.y = this.height-legendHeight+innerPadding;
				}
			}else{
				_legend.width = legendWidth-innerPadding*2;
				_legend.height = count*legendHeight;
				_legend.y = 0;
				if(this.titleLabel){_legend.y+=this.titleLabel.y+this.titleLabel.height;}
				if(this.subTitleLabel){_legend.y+=this.subTitleLabel.y+this.subTitleLabel.height;}
				if(lgStyle.position=="left"){
					_legend.x = outerPadding;
				}else{
					_legend.x = this.width-legendWidth;
				}
			}
			for(var i:int=0;i<count;i++){
				var lg:LegendItemViewAS = null;
				if(chart.type=="pie"){
					lg = new LegendItemViewAS(dataJson[i]["label"]+","+dataJson[i]["value"]);
				}else{
					lg = new LegendItemViewAS(seriesArr[i]["name"]);
				}
				lg.width = legendWidth;
				lg.height = legendHeight;
				var c:uint = chart.seriesColor[i];
				lg.labelColors = [c,c,c,c].join(",");
				if(lgStyle.position=="top"||lgStyle.position=="bottom"){
					lg.x = i*lg.width;
					lg.y = 0;
				}else{
					lg.x = 0;
					lg.y = i*lg.height;
				}
				_legend.addChild(lg);
			}
			_legend.drawStyle();
		}
		protected function positionMain():void{
			var chart:GridChart = ChartController.getInst().chart;
			var lgStyle:ChartLegendStyle = chart.chartStyle.legendStyle;
			if(_main==null){
				_main = new Box();
				this.addChild(_main);
			}
			if(lgStyle.position=="top"||lgStyle.position=="bottom"){
				_main.x = outerPadding;
				_main.width = this.width-outerPadding*2;
				_main.height = this.height-legendHeight;
				if(lgStyle.position=="top"){
					_main.y = legendHeight;
				}else{
					_main.y = 0;
				}
			}else{
				_main.y = 0;
				_main.width = this.width-outerPadding*2-legendWidth;
				_main.height = this.height-outerPadding*2;
				if(lgStyle.position=="left"){
					_main.x = outerPadding+legendWidth;
				}else{
					_main.x = outerPadding;
				}
			}
			if(_titleLabel){
				_main.y = _titleLabel.y+_titleLabel.height;
				_main.height -=_titleLabel.height;
			}
			if(_subTitleLabel){
				_main.y = _subTitleLabel.y+_subTitleLabel.height;
				_main.height -=_subTitleLabel.height;
			}
		}
		protected function showMain():void
		{
			positionMain();
			_main.y +=vsize;
			drawChart();
		}
		
		protected function showSubTitle():void
		{
			var chart:GridChart = ChartController.getInst().chart;
			var style:ChartSubTitleStyle = chart.chartStyle.subTitleStyle;
			if(chart.subTitle!=null&&chart.subTitle!=""){
				if(_subTitleLabel==null){
					_subTitleLabel = new Label();
					_subTitleLabel.x = outerPadding;
					_subTitleLabel.y = _titleLabel.y+_titleLabel.height;
				}
				_subTitleLabel.width = this.width-outerPadding*2;
				_subTitleLabel.height = 30;
				_subTitleLabel.text = chart.subTitle;
				_subTitleLabel.font = style.family;
				_subTitleLabel.size = style.size;
				_subTitleLabel.color = style.color;
				_subTitleLabel.bold = style.bold;
				_subTitleLabel.align = style.align;
				this.addChild(_subTitleLabel);
				if(style.borderStyle!="none"){
					_subTitleLabel.stroke = ""+style.borderColor;
				}
				_subTitleLabel.background = true;
				_subTitleLabel.backgroundColor = style.backgroundColor;
			}
		}
		
		protected function showTitle():void
		{
			var chart:GridChart = ChartController.getInst().chart;
			var style:ChartTitleStyle = chart.chartStyle.titleStyle;
			if(chart.title!=null&&chart.title!=""){
				if(_titleLabel==null){
					_titleLabel = new TitleLabel();
					_titleLabel.x = outerPadding;
					_titleLabel.y = outerPadding;
					_titleLabel.height = 40;
				}
				_titleLabel.width = this.width-outerPadding*2;
				_titleLabel.text = chart.title;
				_titleLabel.font = style.family;
				_titleLabel.size = style.size;
				_titleLabel.color = style.color;
				_titleLabel.bold = style.bold;
				_titleLabel.align = style.align;
				this.addChild(_titleLabel);
				_titleLabel.drawStyle();
			}
		}
		
		/**
		 * 清除绘制内容，清除子组件
		 */
		public function clear():void{
			this.removeAllChild();
			var g:Graphics = this.graphics;
			g.clear();
			this.titleLabel = null;
			this.subTitleLabel = null;
			this.legend = null;
			this.main = null;
			//App.timer.clearTimer(urlTimer);
		}
		
		protected function showOuter():void{
			var g:Graphics = this.graphics;
			var chartStyle:ChartStyle = ChartController.getInst().chart.chartStyle;
			if(chartStyle.borderStyle!="none"){
				g.lineStyle(1,chartStyle.borderColor);
			}
			g.beginFill(chartStyle.backgroundColor,chartStyle.backgroundAlpha);
			g.drawRoundRect(0,0,this.width,this.height,chartStyle.borderRound,chartStyle.borderRound);
			g.endFill();
		}
		
		private function labelDraw(color:uint,w:Number,h:Number,showText:String):Label{
			var ylabel:Label = new Label();
			ylabel.color = color;
			ylabel.width = w;
			ylabel.height = h;
			ylabel.text = showText;
			ylabel.toolTip = showText;
			return ylabel;
		}
		
		private var yAxisItemWidth:Number = 70;
		private var xAxisItemHeight:Number = 60;
		private var legendHeight:Number = 0;
		private var legendWidth:Number = 0;
		private var outerPadding:Number = 30;
		private var innerPadding:Number = 5;
		private var hsize:int = 14;
		private var vsize:int = 12;
		private function drawBack(gc:GraphContentAS):void{
			var chart:GridChart = ChartController.getInst().chart;
			var typeaxisarr:TypeGridChartAxis = chart.typeaxis;
			var graphStyle:ChartGraphStyle = chart.chartStyle.graphStyle;
			var dataJson:Array = chart.chartData as Array;
			var colcount:int = dataJson.length;
			var count:int = chart.numDiv;
			
			var back:Box = new Box();
			back.width = gc.width;
			back.height = gc.height;
			gc.addChild(back);
			var graphStyle:ChartGraphStyle = chart.chartStyle.graphStyle;
			var graphG:Graphics = back.graphics;
			graphG.clear();
			if(graphStyle.borderStyle!="none"){
				graphG.lineStyle(1,graphStyle.borderColor);
			}
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(gc.width,gc.height,0,0,0);
			graphG.beginGradientFill(GradientType.LINEAR,graphStyle.backgroundColor,graphStyle.backgroundAlpha,
				[0,255],matrix);
			graphG.drawRoundRect(0,0,gc.width,gc.height,graphStyle.borderRound,graphStyle.borderRound);
			graphG.endFill();
			//系列值格线
			for(var i:int=0;i<count-1;i++){
				if(typeaxisarr.isOnX){
					if(graphStyle.hlines){
						graphG.lineStyle(1,graphStyle.hlinesColor);
						var rh:Number = back.height/count;
						graphG.moveTo(0,(i+1)*rh);
						graphG.lineTo(back.width,(i+1)*rh);
					}
				}else{
					if(graphStyle.vlines){
						graphG.lineStyle(1,graphStyle.vlinesColor);
						var cw:Number = back.width/count;
						graphG.moveTo((i+1)*cw,0);
						graphG.lineTo((i+1)*cw,back.height);
					}
				}
			}
			//分类值格线
			for(var i:int=0;i<colcount-1;i++){
				if(typeaxisarr.isOnX){
					if(graphStyle.vlines){
						graphG.lineStyle(1,graphStyle.vlinesColor);
						var cw:Number = back.width/colcount;
						graphG.moveTo((i+1)*cw,0);
						graphG.lineTo((i+1)*cw,back.height);
					}
				}else{
					if(graphStyle.hlines){
						graphG.lineStyle(1,graphStyle.hlinesColor);
						var rh:Number = back.height/colcount;
						graphG.moveTo(0,(i+1)*rh);
						graphG.lineTo(back.width,(i+1)*rh);
					}
				}
			}
		}
		
		private function drawAxis(gc:GraphContentAS):void{
			var chart:GridChart = ChartController.getInst().chart;
			var dataaxisarr:Array = chart.seriesaxis;
			var typeaxisarr:TypeGridChartAxis = chart.typeaxis;
			var axisLayout:Array = calcDataAxisLayout();
			var	dataaxisCount1:int = axisLayout[0];
			var	dataaxisCount2:int = axisLayout[1];
			
			var dataJson:Array = chart.chartData as Array;
			var colcount:int = dataJson.length;
			var count:int = chart.numDiv;
			//添加系列轴
			var seriesArr:Array = chart.series;
			for(var i:int=0;i<dataaxisarr.length;i++){
				if(!chart.multiSeriesAxis){
					if(i>0){
						break;
					}
				}
				var yga:SeriesGridChartAxis = dataaxisarr[i] as SeriesGridChartAxis;
				var end:Number = yga.serieValueEnd;
				var begin:Number = yga.serieValueBegin;
				if(typeaxisarr.isOnX){
					var yaxixShow:YAxisAs = null;
					if(i<dataaxisCount1){
						yaxixShow = new LeftYAxisAs();
					}else{
						yaxixShow = new RightYAxisAs();
					}
					yaxixShow.height = _main.height;
					yaxixShow.yTitle.text = text2Vertical(yga.title);
					yaxixShow.yTitle.y = yaxixShow.height/2-(yaxixShow.yTitle.text.length*vsize)/2;
					yaxixShow.yTitle.height = (yaxixShow.yTitle.text.length*vsize);
					yaxixShow.yTitle.color = chart.seriesColor[i];
					if(i<dataaxisCount1){
						yaxixShow.x = i*yAxisItemWidth;
					}else{
						yaxixShow.x = (i-dataaxisCount1)*yAxisItemWidth+gc.x+gc.width;
					}
					yaxixShow.y = -vsize;
					
					var serieslabel:Label = labelDraw(chart.seriesColor[i],
						yAxisItemWidth-20,gc.height/count,end+chart.ySuffix);
					serieslabel.x = 0;
					serieslabel.y = 0;
					serieslabel.align="right";
					yaxixShow.yAxis.addChild(serieslabel);
					
					for(var j:int=0;j<count;j++){
						var value:Number = end-(j+1)*(end-begin)/count;
						var serieslabel:Label = labelDraw(chart.seriesColor[i],
							yAxisItemWidth-20,gc.height/count-1,value.toFixed(0)+chart.ySuffix);
						serieslabel.x = 0;
						serieslabel.y = (j+1)*gc.height/count;
						serieslabel.align="right";
						yaxixShow.yAxis.addChild(serieslabel);
					}
					_main.addChild(yaxixShow);
				}else{
					var xaxixShow:XAxisAs = null;
					if(i<dataaxisCount1){
						xaxixShow = new BottomXAxisAs();
					}else{
						xaxixShow = new TopXAxisAs();
					}
					xaxixShow.xAxis.height = 20;
					xaxixShow.width = gc.width;
					xaxixShow.xTitle.text = yga.title;
					xaxixShow.xTitle.color = chart.seriesColor[i];
					xaxixShow.xTitle.x = xaxixShow.width/2-(xaxixShow.xTitle.text.length*hsize)/2;
					xaxixShow.xTitle.width = (xaxixShow.xTitle.text.length*hsize);
					if(i<dataaxisCount1){
						if(dataaxisCount1==1){
							xaxixShow.y = gc.y+gc.height;
						}else{
							xaxixShow.y = (dataaxisarr.length-1-i-dataaxisCount2)*xAxisItemHeight+gc.y+gc.height;
						}
					}else{
						xaxixShow.y = (dataaxisarr.length-1-i)*xAxisItemHeight;
					}
					xaxixShow.x = gc.x-(gc.width/count)*0.5;
					
					var itemValue:Number = (end-begin)/count;
					for(var j:int=0;j<count;j++){
						var value:Number = begin+j*itemValue;
						var serieslabel:Label = labelDraw(chart.seriesColor[i],
							gc.width/count,20,value.toFixed(0)+chart.xSuffix);
						serieslabel.x = j*gc.width/count;
						serieslabel.y = 0;
						serieslabel.align = "center";
						xaxixShow.xAxis.addChild(serieslabel);
					}
					var serieslabel:Label = labelDraw(chart.seriesColor[i],
						gc.width/count,20,end+chart.xSuffix);
					serieslabel.x = gc.width;
					serieslabel.y = 0;
					serieslabel.align = "center";
					xaxixShow.xAxis.addChild(serieslabel);
					_main.addChild(xaxixShow);
				}
			}
			//添加分类轴
			if(typeaxisarr.isOnX){
				var xaxisshow:BottomXAxisAs = new BottomXAxisAs();
				xaxisshow.xTitle.text = typeaxisarr.title;
				var xaxiscw:Number = gc.width/colcount;
				for(var i:int=0;i<colcount;i++){
					var xlabel:Label = new Label();
					xlabel.width = xaxiscw;
					xlabel.height = 40;
					xlabel.text = dataJson[i][(seriesArr[0] as GridChartSeries).xField]+chart.xSuffix;
					xlabel.toolTip = xlabel.text;
					xlabel.align = "center";
					xlabel.x = i*xlabel.width;
					xlabel.y = 0;
					xaxisshow.xAxis.addChild(xlabel);
				}
				xaxisshow.x = gc.x;
				xaxisshow.y = gc.y+gc.height;
				xaxisshow.width = gc.width;
				xaxisshow.height = 60;
				xaxisshow.xTitle.x = xaxisshow.width/2-(xaxisshow.xTitle.text.length*hsize)/2;
				xaxisshow.xTitle.width = (xaxisshow.xTitle.text.length*hsize);
				_main.addChild(xaxisshow);
			}else{
				var typeshow:LeftYAxisAs = new LeftYAxisAs();
				typeshow.yTitle.text = text2Vertical(typeaxisarr.title);
				var yaxisrh:Number = gc.height/colcount;
				for(var i:int=0;i<colcount;i++){
					var xlabel:Label = new Label();
					xlabel.width = yAxisItemWidth;
					xlabel.height = yaxisrh;
					xlabel.text = dataJson[i][(seriesArr[0] as GridChartSeries).yField]+chart.ySuffix;
					xlabel.toolTip = xlabel.text;
					xlabel.y = i*xlabel.height;
					xlabel.x = 0;
					typeshow.yAxis.addChild(xlabel);
				}
				typeshow.x = 0;
				typeshow.y = gc.y;
				typeshow.height = gc.height;
				typeshow.width = 60;
				typeshow.yTitle.y = typeshow.height/2-(typeshow.yTitle.text.length*vsize)/2;
				typeshow.yTitle.width = (typeshow.yTitle.text.length*vsize);
				_main.addChild(typeshow);
			}
		}
		private function drawSeries(gc:GraphContentAS):void{
			var chart:GridChart = ChartController.getInst().chart;
			var typeaxisarr:TypeGridChartAxis = chart.typeaxis;
			//绘制系列值
			var seriesArr:Array = chart.series;
			for(var i:int=0;i<seriesArr.length;i++){
				var series:GridChartSeries = seriesArr[i] as GridChartSeries;
				//draw
				var seriesContent:Box = new Box();
				seriesContent.name = seriesArr[i].name;
				seriesContent.width = gc.width;
				seriesContent.height = gc.height;
				gc.addChild(seriesContent);
				var drawer:ISeriesDrawer = SeriesFactory.getSeriesDrawer(series.type);
				
				var nowend:Number = (chart.seriesaxis[i] as SeriesGridChartAxis).serieValueEnd;
				var nowbegin:Number = (chart.seriesaxis[i] as SeriesGridChartAxis).serieValueBegin;
				if(typeaxisarr.isOnX){
					drawer.draw(chart,seriesContent,i,gc.height/(nowend-nowbegin));
				}else{
					drawer.draw(chart,seriesContent,i,gc.width/(nowend-nowbegin));
				}
			}
		}
		private function calcDataAxisLayout():Array{
			var chart:GridChart = ChartController.getInst().chart;
			var dataaxisarr:Array = chart.seriesaxis;
			var typeaxisarr:TypeGridChartAxis = chart.typeaxis;
			var dataaxisCount1:int = dataaxisarr.length%2>0?(dataaxisarr.length/2+1):(dataaxisarr.length/2);
			var dataaxisCount2:int = dataaxisarr.length-dataaxisCount1;
			if(!chart.multiSeriesAxis){
				dataaxisCount1 = 1;
				dataaxisCount2 = 0;
			}
			return [dataaxisCount1,dataaxisCount2];
		}
		private function createGraphContent():GraphContentAS{
			var chart:GridChart = ChartController.getInst().chart;
			var typeaxisarr:TypeGridChartAxis = chart.typeaxis;
			var axisLayout:Array = calcDataAxisLayout();
			var	dataaxisCount1:int = axisLayout[0];
			var	dataaxisCount2:int = axisLayout[1];
			var gc:GraphContentAS = new GraphContentAS();
			_main.addChild(gc);
			if(typeaxisarr.isOnX){
				var dyw1:Number = dataaxisCount1* yAxisItemWidth;
				var dyw2:Number = dataaxisCount2* yAxisItemWidth;
				gc.x = dyw1;
				gc.y = 0;
				gc.width = _main.width-dyw1-dyw2;
				gc.height = _main.height-xAxisItemHeight;
			}else{
				var dxh1:Number = dataaxisCount1* xAxisItemHeight;
				var dxh2:Number = dataaxisCount2* xAxisItemHeight;
				gc.y = dxh2;
				gc.x = yAxisItemWidth;
				gc.width = _main.width-yAxisItemWidth;
				gc.height = _main.height-dxh1-dxh2;
			}
			return gc;
		}
		private function drawChart():void
		{
			var gc:GraphContentAS = createGraphContent();
			//绘制背景和系列值和分类值的格线
			drawBack(gc)
			drawAxis(gc)
			drawSeries(gc);
		}
		private function text2Vertical(str:String):String{
			var ttLen:int = str.length;
			var ttstr:String = "";
			for(var ttindex:int=0;ttindex<ttLen;ttindex++){
				ttstr +=str.charAt(ttindex);
				ttstr +="\n";
			}
			return ttstr;
		}
		
		/**
		 * 展现或隐藏某个系列所绘制的内容
		 * @param seriesName 绘图组件名称
		 * @param show 是否展现
		 */
		public function showSeries(seriesName:String,show:Boolean):void{
			var count:int = _main.numChildren;
			for(var j:int=0;j<count;j++){
				var nowele:DisplayObject = main.getChildAt(j);
				if(nowele is GraphContentAS){
					var gcm:GraphContentAS = GraphContentAS(nowele);
					gcm.getChildByName(seriesName).visible = show;
					break;
				}
			}
		}

		public function get titleLabel():TitleLabel
		{
			return _titleLabel;
		}

		public function set titleLabel(value:TitleLabel):void
		{
			_titleLabel = value;
		}

		public function get subTitleLabel():Label
		{
			return _subTitleLabel;
		}

		public function set subTitleLabel(value:Label):void
		{
			_subTitleLabel = value;
		}

		public function get main():Box
		{
			return _main;
		}

		public function set main(value:Box):void
		{
			_main = value;
		}

		public function get legend():LegendViewAS
		{
			return _legend;
		}

		public function set legend(value:LegendViewAS):void
		{
			_legend = value;
		}


	}
}