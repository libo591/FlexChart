package com.basic.cursor
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class CursorManager
	{
		private static var currBit:Bitmap;
		private static var offx:Number;
		private static var offy:Number;
		public function CursorManager()
		{
		}
		
		public static function setCursor(cursor:Class,xoffset:Number=0,yoffset:Number=0):void{
			Mouse.hide();			
			if(currBit){App.stage.removeChild(currBit);currBit = null;}
			currBit = new cursor();
			currBit.visible = false;
			offx = xoffset;
			offy = yoffset;
			App.stage.addChild(currBit);
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			onMove(null);
		}
		
		protected static function onMove(event:MouseEvent):void
		{
			if(!currBit.visible){currBit.visible = true;}
			currBit.x = App.stage.mouseX+offx;
			currBit.y = App.stage.mouseY+offy;
		}
		
		public static function removeAllCursors():void{
			Mouse.show();
			if(currBit){App.stage.removeChild(currBit);currBit = null;}
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			
		}
	}
}