package com.basic.loading
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Loading 
	{
		private var _r2:int;//圆圈半径
		private var _r3:Number;//起始球的半径
		private var _r4:Number;//当前球的半径
		private var _sprite:Sprite;
		private var _timer:Timer;
		private var _index:int;
		private var _count:int;
		public function Loading()
		{
			init();
		}
		
		private function init():void
		{
			_r2 = 25;
			_r3 = 2.5;
			_r4  = 5;
			_index = 0;
			_count = 360/30;
		}
		
		public function loading(stage:Stage):void{
			_sprite = new Sprite();
			stage.addChild(_sprite);
			_timer = new Timer(50,0);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			_timer.start();
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			drawCircle();
			_index++;
			if(_index>=_count){_index=0;}
		}
		
		private function drawCircle():void{
			var g:Graphics = _sprite.graphics;
			g.clear();
			var sw:Number = _sprite.stage.stageWidth;
			var sh:Number = _sprite.stage.stageHeight;
			var cx:Number = sw/2;
			var cy:Number = sh/2;
			var _nowr:Number = _r2;
			var color:uint = 0x000000;
			var alpha:Number = 0.5;
			g.lineStyle(1,color,alpha);
			
			for(var i:int=0;i<_count;i++){
				var angle:int = -90+30*i;
				var ra:Number = Math.PI/180*angle;
				g.beginFill(color,alpha);
				if(i==_index){
					g.drawCircle(cx+Math.cos(ra)*_nowr,cy+Math.sin(ra)*_nowr,_r4);
				}else{
					g.drawCircle(cx+Math.cos(ra)*_nowr,cy+Math.sin(ra)*_nowr,_r3);
				}
				g.endFill();
			}
		}
		
		public function end():void{
			_timer.stop();
			_timer = null;
			_sprite.stage.removeChild(_sprite);
			_sprite = null;
		}
		
	}
}