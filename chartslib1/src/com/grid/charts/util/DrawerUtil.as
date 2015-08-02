package com.grid.charts.util
{
	import com.grid.charts.model.ChartSeriesStyle;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import caurina.transitions.Tweener;
	
	import morn.core.components.Label;
	/**
	 * 绘制工具类
	 */
	public class DrawerUtil
	{
		public function DrawerUtil()
		{
		}
		/**
		 * 根据参数创建text组件
		 * @param w 宽度
		 * @param h 高度
		 * @param x X坐标
		 * @param y Y坐标
		 * @param text 文本
		 */
		public static function createText(w:Number,h:Number,x:Number,y:Number,text:String):Label{
			var label:Label = new Label();
			label.width = w;
			label.height = h;
			label.x = x;
			label.y = y;
			label.text = text;
			return label;
		}
		/**
		 * 根据参数绘制圆的曲线
		 * @param g 画笔
		 * @param startR 起始弧度
		 * @param endR 结束弧度
		 * @param startP 圆心坐标
		 * @param radius 半径
		 */
		public static function drawCurve(g:Graphics,startR:Number,endR:Number,startP:Point,radius:Number):void{
			trace(startR*180/Math.PI+"=aa="+endR*180/Math.PI);
			var x2:Number = startP.x+radius*Math.cos(endR);
			var y2:Number = startP.y+radius*Math.sin(endR);
			var len:Number = endR-startR;
			trace(len*180/Math.PI+"=aa=");
			var mid:Number = len/2;
			var bx:Number = startP.x + radius / Math.cos(mid) * Math.cos(startR+mid);
			var by:Number = startP.y + radius / Math.cos(mid) * Math.sin(startR+mid);
			var rLittle:Number = Math.PI/180*45;
			if(len>rLittle){
				var currStart:Number = startR;
				while(Math.abs(endR-currStart)>rLittle){
					currStart = currStart+rLittle;
					DrawerUtil.drawCurve(g,currStart-rLittle,currStart,startP,radius);
				}
				trace(currStart*180/Math.PI+"=22=");
				if(endR-currStart!=0){
					DrawerUtil.drawCurve(g,currStart,endR,startP,radius);
				}
			}else{
				g.curveTo(bx,by,x2,y2);
			}
		}
		/**
		 * 根据参数绘点
		 * @param g 画笔
		 * @param xoff X坐标
		 * @param yoff Y坐标
		 * @param radius 半径
		 * @param type 点的类型
		 */
		public static function drawPoint(g:Graphics,xoff:Number,yoff:Number,radius:Number,type:String):void{
			if(type==ChartSeriesStyle.CIRCLE){
				DrawerUtil.drawCircle(g,xoff,yoff,radius);
			}else if(type==ChartSeriesStyle.RECT){
				DrawerUtil.drawRect(g,xoff,yoff,radius);
			}else if(type==ChartSeriesStyle.TRIANGLES){
				DrawerUtil.drawTriangles(g,xoff,yoff,radius);
			}else if(type==ChartSeriesStyle.RHOMBUS){
				DrawerUtil.drawRhombus(g,xoff,yoff,radius);
			}
		}
		/**
		 * 在指定位置，用指定的画笔和指定的大小，画菱形
		 */
		public static function drawRhombus(g:Graphics,xoff:Number,yoff:Number,radius:Number):void{
			g.moveTo(xoff,yoff-radius);
			g.lineTo(xoff+radius,yoff);
			g.lineTo(xoff,yoff+radius);
			g.lineTo(xoff-radius,yoff);
			g.lineTo(xoff,yoff-radius);
		}
		/**
		 * 在指定位置，用指定的画笔和指定的大小，画三角
		 */
		public static function drawTriangles(g:Graphics,xoff:Number,yoff:Number,radius:Number):void{
			var points:Vector.<Number> = new Vector.<Number>();
			points.push(xoff,yoff-radius);
			points.push(xoff+radius*Math.cos(Math.PI/6),yoff+radius*Math.sin(Math.PI/6));
			points.push(xoff-radius*Math.cos(Math.PI/6),yoff+radius*Math.sin(Math.PI/6));
			g.drawTriangles(points);
		}
		/**
		 * 在指定位置，用指定的画笔和指定的大小，画方块
		 */
		public static function drawRect(g:Graphics,xoff:Number,yoff:Number,radius:Number):void{
			g.drawRect(xoff-radius,yoff-radius,radius*2,radius*2);
		}
		/**
		 * 在指定位置，用指定的画笔和指定的大小，画圆形
		 */
		public static function drawCircle(g:Graphics,xoff:Number,yoff:Number,radius:Number):void{
			g.drawCircle(xoff,yoff,radius);
		}
		public static function alphaAnimation(sp:Sprite):void{
			sp.alpha = 0;
			Tweener.addTween(sp,{alpha:1,time:0.8});
		}
		/**
		 * size变化动画
		 * @param sp 要变化的组件
		 * @param len 结束值
		 * @param target 宽度或者高度变化的标志
		 */
		public static function resizeAnimation(sp:Sprite,len:Number,target:String):void{
			if(target=="right"){
				sp.width = 0;
				Tweener.addTween(sp,{width:len,time:0.8});
			}else{
				sp.height = 0;
				Tweener.addTween(sp,{height:len,time:0.8});
			}
		}
		/**
		 * 获取饼图引出线最后一个点的坐标
		 * @param pline 圆弧上的点的坐标
		 * @param xiangxian 当前点在第几象限（右上：1，左上：2，左下：3，右下4，X正半轴5，Y负半轴6，X负半轴7，Y正半轴8）
		 */
		public static function getPointOfPieLine(p:Point,xiangxian:int):Point{
			var presult:Point = p;
			if(xiangxian==1){
				presult = new Point(p.x+10,p.y);
			}else if(xiangxian==2){
				presult = new Point(p.x-10,p.y);
			}else if(xiangxian==3){
				presult = new Point(p.x-10,p.y);
			}else if(xiangxian==4){
				presult = new Point(p.x+10,p.y);
			}
			return presult;
		}
		/**
		 * 获取饼图引出线对应的text坐标
		 * @param pline 圆弧上的点的坐标
		 * @param w 文本宽度
		 * @param h 文本高度
		 * @param xiangxian 当前点在第几象限（右上：1，左上：2，左下：3，右下4，X正半轴5，Y负半轴6，X负半轴7，Y正半轴8）
		 */
		public static function getPointOfPieLabel(pline:Point,xiangxian:int,w:Number,h:Number):Point{
			var presult:Point = pline;
			if(xiangxian==1||xiangxian==5){
				presult = new Point(pline.x+10,pline.y-h/2);
			}else if(xiangxian==2||xiangxian==7){
				presult = new Point(pline.x-w-10,pline.y-h/2);
			}else if(xiangxian==3){
				presult = new Point(pline.x-w-10,pline.y-h/2);
			}else if(xiangxian==4){
				presult = new Point(pline.x+10,pline.y-h/2);
			}else if(xiangxian==6){
				presult = new Point(pline.x-w/2,pline.y+10);
			}else if(xiangxian==8){
				presult = new Point(pline.x-w/2,pline.y-h-10);
			}
			return presult;
		}
		/**
		 * 获取仪表盘图引出线对应的text坐标
		 * @param p 圆弧上的点的坐标
		 * @param w 文本宽度
		 * @param h 文本高度
		 * @param xiangxian 当前点在第几象限（右上：1，左上：2，左下：3，右下4，X正半轴5，Y负半轴6，X负半轴7，Y正半轴8）
		 */
		public static function getPointOfLabel(p:Point,w:Number,h:Number,xiangxian:int):Point{
			var presult:Point = null;
			var padding:int = 0;
			if(xiangxian==1){
				presult = new Point(p.x+padding,p.y-h/2);
			}else if(xiangxian==2){
				presult = new Point(p.x-w-padding,p.y-h/2);
			}else if(xiangxian==3){
				presult = new Point(p.x-w-padding,p.y-h/2);
			}else if(xiangxian==4){
				presult = new Point(p.x+padding,p.y-h/2);
			}else if(xiangxian==5){
				presult = new Point(p.x+padding,p.y-h/2);
			}else if(xiangxian==6){
				presult = new Point(p.x-w/2,p.y+padding);
			}else if(xiangxian==7){
				presult = new Point(p.x-w-padding,p.y-h/2);
			}else if(xiangxian==8){
				presult = new Point(p.x-w/2,p.y-h-padding);
			}
			return presult;
		}
		/**
		 * 获取当前角度在第几象限
		 * 右上：1，左上：2，左下：3，右下：4
		 * 0-5,90-6,180-7,270-8
		 */
		public static function getXiangxian(angle:int):int{
			angle = angle%360;
			if(angle<0){
				angle = 360+angle;
			}
			if(angle>0&&angle<90){
				return 4;
			}else if(angle>90&&angle<180){
				return 3;
			}else if(angle>180&&angle<270){
				return 2;
			}else if(angle>270&&angle<360){
				return 1;
			}else if(angle==0){
				return 5;
			}else if(angle==90){
				return 6;
			}else if(angle==180){
				return 7;
			}else if(angle==270){
				return 8;
			}
			return 5;
		}
		/**
		 * 绘制圆柱
		 * @param g 画笔
		 * @param blp 下表面原点坐标，
		 * @param lradis 宽度
		 * @param sradis 深度
		 * @param h 柱子高度
		 * @param lineColor 线颜色
		 * @param fillColor 填充颜色
		 */
		public static function drawYuanzhu(g:Graphics,blp:Point,
											lradis:Number,sradis:Number,h:Number,lineColor:uint,fillColor:uint):void{
			g.lineStyle(1,lineColor);
			
			g.beginFill(fillColor,1);
			g.drawEllipse(blp.x,blp.y-sradis,lradis*2,sradis*2);
			g.endFill();
			
			g.beginFill(fillColor,1);
			g.moveTo(blp.x,blp.y);
			g.lineTo(blp.x,blp.y-h);
			g.lineTo(blp.x+lradis*2,blp.y-h);
			g.lineTo(blp.x+lradis*2,blp.y);
			g.lineStyle(1,lineColor,0);
			g.lineTo(blp.x,blp.y);
			g.endFill();
			
			g.lineStyle(1,lineColor,1);
			g.beginFill(fillColor,1);
			g.drawEllipse(blp.x,blp.y-h-sradis,lradis*2,sradis*2);
			g.endFill();
		}
		/**
		 * 绘制3D柱
		 * @param g 画笔
		 * @param blp 下表面左下点坐标
		 * @param h 高度
		 * @param w 边长
		 * @param lineColor 线颜色
		 * @param fillColor 填充颜色
		 */
		public static function draw3DCol(g:Graphics,blp:Point,
										 h:Number,w:Number,lineColor:uint,fillColor:uint):void{
			w = w * 0.7;
			var ps:Array = [new Point(blp.x,blp.y),new Point(blp.x+w/2.0,blp.y-w/2),new Point(blp.x+w+w/2,blp.y-w/2),new Point(blp.x+w,blp.y),
				new Point(blp.x,blp.y-h),new Point(blp.x+w/2.0,blp.y-h-w/2),new Point(blp.x+w+w/2,blp.y-h-w/2),new Point(blp.x+w,blp.y-h)];
			
			g.lineStyle(1,lineColor);
			
			g.moveTo(ps[1].x,ps[1].y);
			g.lineTo(ps[0].x,ps[0].y);
			g.moveTo(ps[1].x,ps[1].y);
			g.lineTo(ps[5].x,ps[5].y);
			g.moveTo(ps[1].x,ps[1].y);
			g.lineTo(ps[2].x,ps[2].y);
			
			g.beginFill(fillColor,1);
			drawFill(g,[ps[0],ps[4],ps[7],ps[3]]);
			g.endFill();
			g.beginFill(fillColor,1);
			drawFill(g,[ps[4],ps[5],ps[6],ps[7]]);
			g.endFill();
			g.beginFill(fillColor,1);
			drawFill(g,[ps[7],ps[6],ps[2],ps[3]]);
			g.endFill();
		}
		private static function drawFill(g:Graphics,ps:Array):void{
			for(var i:int=0;i<ps.length;i++){
				var p:Point = ps[i];
				if(i==0){
					g.moveTo(p.x,p.y);
				}else{
					g.lineTo(p.x,p.y);
				}
			}
		}
	}
}