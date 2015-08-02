package com.grid.charts.series
{
	import com.grid.charts.interfaces.ISeriesDrawer;
	import com.grid.charts.model.GridChart;
	import com.grid.charts.model.GridChartSeries;
	import com.grid.charts.model.SeriesGridChartAxis;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	import morn.core.events.UIEvent;
	
	public class NoneDrawer implements ISeriesDrawer
	{
		private var _points:Array;//当前系列值构成的点集合
		private var _colWidth:Number;//分类轴每个元素的宽度|高度
		private var _pointColor:uint;//当前系列使用的颜色值1
		private var _lineColor:uint;//当前系列使用的颜色值2
		private var _chartData:Array;//图形数据
		private var _chartSeries:GridChartSeries;//当前系列对象
		private var _chartDataAxis:SeriesGridChartAxis;//数据轴对象
		private var _chart:GridChart;
		private var _seriesIndex:int;
		private var _content:Box;
		private var _zeroPos:Number;
		private var _typeOnX:Boolean;
		private var _currAlpha:Number;
		
		public function NoneDrawer()
		{
		}
		
		public function get points():Array
		{
			return _points;
		}
		
		public function set points(value:Array):void
		{
			_points = value;
		}
		
		public function draw(chart:GridChart, content:Box, seriesIndex:int, scale:Number):void
		{
			content.graphics.clear();
			this._chart = chart;
			this._chartSeries = chart.series[seriesIndex] as GridChartSeries;
			this._chartData = chart.chartData as Array;
			this._seriesIndex = seriesIndex;
			this._content = content;
			this._currAlpha = chart.seriesAlpha[seriesIndex];
			var colcount:int = this._chartData.length;
			if(chart.typeaxis.isOnX){
				this._colWidth = content.width/colcount;
			}else{
				this._colWidth = content.height/colcount;
			}
			this._chartDataAxis = (chart.seriesaxis[seriesIndex] as SeriesGridChartAxis);
			
			this._typeOnX = chart.typeaxis.isOnX;
			if(chart.typeaxis.isOnX){
				var begin:Number = (chart.seriesaxis[seriesIndex] as SeriesGridChartAxis).serieValueBegin;
				this.zeroPos = content.height-(0-begin)*scale;
				trace(this._chartDataAxis.needZeroLine+"==");
				if(this._chartDataAxis.needZeroLine){
					content.graphics.lineStyle(2,0x000000,1);
					content.graphics.moveTo(0,this.zeroPos);
					content.graphics.lineTo(content.width,this.zeroPos);
				}
			}else{
				var begin:Number = (chart.seriesaxis[seriesIndex] as SeriesGridChartAxis).serieValueBegin;
				this.zeroPos = (0-begin)*scale;
				if(this._chartDataAxis.needZeroLine){
					content.graphics.lineStyle(2,0x000000,1);
					content.graphics.moveTo(this.zeroPos,0);
					content.graphics.lineTo(this.zeroPos,content.height);
				}
			}
			var arr:Array = [];
			for(var j:int=0;j<this._chartData.length;j++){
				var data:Object = this._chartData[j];
				var value:Number = this.seriesValue(seriesIndex,j);
				if(chart.typeaxis.isOnX){
					var xoff:Number = Math.round(this._colWidth/2+(j*this._colWidth));
					var yoff:Number = Math.round(this.seriesXorY(content.height,this.seriesHeightOrWidth(value,scale)));
					arr.push(new Point(xoff,yoff));
				}else{
					var xoff:Number = Math.round(this.seriesXorY(content.height,this.seriesHeightOrWidth(value,scale)));
					var yoff:Number = Math.round(this._colWidth/2+(j*this._colWidth));
					arr.push(new Point(xoff,yoff));
				}
			}
			this._points = arr;
			this._pointColor = chart.seriesColor[seriesIndex];
			this._lineColor = chart.seriesColor[seriesIndex];
			
			content.filters = [new GlowFilter(this.lineColor,1,10,10,1,BitmapFilterQuality.HIGH,false,false)];
			
			var spTip:Sprite = new Sprite();
			spTip.x = 0;
			spTip.y = 0;
			spTip.name = "spTip";
			content.addChild(spTip);
			content.addEventListener(MouseEvent.MOUSE_MOVE,rollOver);
			content.addEventListener(MouseEvent.ROLL_OVER,rollOver);
			content.addEventListener(MouseEvent.ROLL_OUT,rollOut);
			
		}
		protected function rollOut(event:MouseEvent):void
		{
			var t:Object = event.target;
			if(t is Box){
				var sp:Sprite = Box(t).getChildByName("spTip") as Sprite;
				sp.graphics.clear();
				App.tip.closeAll();
			}
			
		}
		
		protected function rollOver(event:MouseEvent):void
		{
			var p:Point = new Point(event.stageX,event.stageY);
			var t:Object = event.target;
			if((t is Box)||(t is Sprite)){
				var nowp:Point = Sprite(t).globalToLocal(p);
				var sp:Sprite = null;
				if(t is Box){
					sp = Box(t).getChildByName("spTip") as Sprite;
				}else{
					sp = Box(Sprite(t).parent).getChildByName("spTip") as Sprite;
				}
				sp.parent.setChildIndex(sp,sp.parent.numChildren-1);
				var len:int = this.points.length;
				for(var i:int=0;i<len;i++){
					var cmparePos:Number = this.typeOnX?nowp.x:nowp.y;
					var start:Number = this.colWidth*i;
					var end:Number = this.colWidth*(i+1);
					if(cmparePos>start&&cmparePos<end){
						var nowg:Graphics = sp.graphics;
						nowg.clear();
						App.tip.closeAll();
						//tip begin
						drawTip(sp,i);
						break;
					}
				}
			}
		}
		
		protected function drawTip(sp:Sprite,pindex:int):void
		{
			var tipWidth:Number = 100;
			var tipHeight:Number = 60;
			var pitem:Point = this.points[pindex] as Point;
			
			var tipPoint:Point = null;
			if(typeOnX){
				if(pitem.y<this.zeroPos){
					tipPoint = new Point(pitem.x+10,pitem.y+10);
				}else{
					tipPoint = new Point(pitem.x+10,pitem.y-10);
				}
			}else{
				if(pitem.x<this.zeroPos){
					tipPoint = new Point(pitem.x-tipWidth-10,pitem.y-10);
				}else{
					tipPoint = new Point(pitem.x+10,pitem.y-10);
				}
			}
			if(tipPoint.x<0){
				tipPoint.x = 0;
			}
			if(tipPoint.y<0){
				tipPoint.y = 0;
			}
			if(tipPoint.x+tipWidth>this.content.width){
				tipPoint.x = this.content.width-tipWidth;
			}
			if(tipPoint.y+tipHeight>this.content.height){
				tipPoint.y = this.content.height-tipHeight;
			}
			var typeField:String = typeOnX?this.chartSeries.xField:this.chartSeries.yField;
			var dataField:String = typeOnX?this.chartSeries.yField:this.chartSeries.xField;
			
			var typestr:String = this.chartData[pindex][typeField];
			var datastr:String = Number(this.chartData[pindex][dataField]).toFixed(2);
			if(this.chartSeries.type=="fullstack"||this.chartSeries.type=="fullstackbar"){
				datastr+="%";
			}
			var tipText:String = this.chartSeries.name+","
						+typestr+","
						+datastr;
			var pglobal:Point = this.content.localToGlobal(tipPoint);
			sp.stage.dispatchEvent(new UIEvent(UIEvent.SHOW_TIP,tipText));
		}

		public function get colWidth():Number
		{
			return _colWidth;
		}

		public function set colWidth(value:Number):void
		{
			_colWidth = value;
		}

		public function get pointColor():uint
		{
			return _pointColor;
		}

		public function set pointColor(value:uint):void
		{
			_pointColor = value;
		}

		public function get lineColor():uint
		{
			return _lineColor;
		}

		public function set lineColor(value:uint):void
		{
			_lineColor = value;
		}

		public function get chartData():Array
		{
			return _chartData;
		}

		public function set chartData(value:Array):void
		{
			_chartData = value;
		}

		public function get chartSeries():GridChartSeries
		{
			return _chartSeries;
		}

		public function set chartSeries(value:GridChartSeries):void
		{
			_chartSeries = value;
		}
		/**
		 * 当前的系列值
		 */
		public function seriesValue(seriesIndex:int,rowindex:int):Number{
			var value:Number = 0;
			if(this.chart.typeaxis.isOnX){
				value = Number(this._chartData[rowindex][this._chart.series[seriesIndex].yField]); 
			}else{
				value = Number(this._chartData[rowindex][this._chart.series[seriesIndex].xField]);
			}
			return value;
		}
		/**
		 * 系列值对应的柱子的高度或者宽度
		 */
		public function seriesHeightOrWidth(value:Number,scale:Number):Number{
			return (value-this._chartDataAxis.serieValueBegin)*scale;
		}
		/**
		 * 系列值到0轴的距离
		 */
		public function value2ZeroDist(value:Number,scale:Number):Number{
			return seriesHeightOrWidth(value,scale)-seriesHeightOrWidth(0,scale);
		}
		/**
		 * 系列值对应的Y坐标或者X坐标
		 */
		public function seriesXorY(sumheight:Number,heightOrWidth:Number):Number{
			var result:Number = 0;
			if(this.chart.typeaxis.isOnX){
				result = sumheight-heightOrWidth; 
			}else{
				result = heightOrWidth;
			}
			return result;
		}

		public function get chart():GridChart
		{
			return _chart;
		}

		public function set chart(value:GridChart):void
		{
			_chart = value;
		}

		public function get chartDataAxis():SeriesGridChartAxis
		{
			return _chartDataAxis;
		}

		public function set chartDataAxis(value:SeriesGridChartAxis):void
		{
			_chartDataAxis = value;
		}

		public function get seriesIndex():int
		{
			return _seriesIndex;
		}

		public function set seriesIndex(value:int):void
		{
			_seriesIndex = value;
		}

		public function get content():Box
		{
			return _content;
		}

		public function set content(value:Box):void
		{
			_content = value;
		}

		public function get zeroPos():Number
		{
			return _zeroPos;
		}

		public function set zeroPos(value:Number):void
		{
			_zeroPos = value;
		}

		public function get typeOnX():Boolean
		{
			return _typeOnX;
		}

		public function set typeOnX(value:Boolean):void
		{
			_typeOnX = value;
		}

		public function get currAlpha():Number
		{
			return _currAlpha;
		}

		public function set currAlpha(value:Number):void
		{
			_currAlpha = value;
		}

		
	}
}