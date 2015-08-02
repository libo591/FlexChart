package
{
	
	
	import com.grid.charts.ChartDataLoader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import morn.core.handlers.Handler;
	
	
	[SWF(backgroundColor="0xffffff")]
	public class bobochart extends Sprite
	{
		private var dataFile:String;
		private var format:String;
		public function bobochart()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,add2Stage);
		}
		
		protected function add2Stage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,add2Stage);
			ExternalInterface.addCallback("loadFile",loadFile);
			ExternalInterface.addCallback("loadXML",loadXML);
			dataFile = stage.loaderInfo.parameters.dataFile;
			format = stage.loaderInfo.parameters.format;
			//初始化组件
			App.init(this);
			//加载资源			
			App.loader.loadAssets(["assets/comp.swf","assets/lic.swf"],
				new Handler(loadComplete));
		}
		
		public function loadFile(df:String,f:String):void{
			dataFile = df;
			format = f;
			loadComplete();
		}
		
		public function loadXML(data:XML,w:Number,h:Number):void{
			try{this.removeChildAt(0);}catch(e:*){}
			ChartDataLoader.loadData(data,this,w,h);
		}
		
		private function loadComplete():void {
			if(dataFile!=null
				&&dataFile!=""
				&&dataFile!="undefined"){
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.addEventListener(Event.COMPLETE,dataLoadFinish);
				urlLoader.load(new URLRequest(dataFile));
				dataFile = null;
			}
		}
		
		protected function dataLoadFinish(event:Event):void
		{
			if(format=="xml"){
				var data:XML = XML(event.target.data);
				loadXML(data,this.stage.stageWidth,this.stage.stageHeight);
			}
		}
	}
}