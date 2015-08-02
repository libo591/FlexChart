package com.grid.charts
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class ChartEventDispatcher
	{
		private static var _inst:ChartEventDispatcher;
		private var eventDispatcher:IEventDispatcher;
		
		public function ChartEventDispatcher(target:IEventDispatcher = null){
			eventDispatcher = new EventDispatcher(target);
		}
		
		public static function getInstance():ChartEventDispatcher{
			if(!_inst){
				_inst = new ChartEventDispatcher();
			}
			return _inst;
		}
		
		public function addEventListener(type:String,listener:Function,useCapture:Boolean=false,pririty:int=0,useWeakReference:Boolean=true):void{
			eventDispatcher.addEventListener(type,listener,useCapture,pririty,useWeakReference);
		}
		
		public function removeEventListener(type:String,listener:Function,useCapture:Boolean=false,priority:int=0,useWeakReference:Boolean=true):void{
			eventDispatcher.removeEventListener(type,listener,useCapture);
		}
		
		public function dispatchEvent(event:ChartEvent):Boolean{
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean{
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean{
			return eventDispatcher.willTrigger(type);
		}
	}
}