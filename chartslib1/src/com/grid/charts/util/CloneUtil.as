package com.grid.charts.util
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	

	/**
	 * 克隆工具类
	 */
	public class CloneUtil
	{
		
		public function CloneUtil()
		{
		}
		
		/** 克隆Array*/
		public static function cloneArray(src:Array):Array{
			var rlt:Array = new Array();
			for(var i:int=0;i<src.length;i++){
				var obj:Object = src[i];
				rlt[rlt.length] = cloneObject(obj);
			}
			return rlt;
		}
		
		/** 克隆ArrayCollection*/
		public static function cloneArrayCollection(src:ArrayCollection):ArrayCollection{
			var rlt:ArrayCollection = new ArrayCollection();
			if(src!=null){
				for(var i:int=0;i<src.length;i++){
					var obj:Object = src.getItemAt(i);
					rlt.addItem(cloneObject(obj));
				}
			}
			return rlt;
		}
		/** 克隆对象*/
		public static function cloneObject(object:Object,newObject:*=null):Object{
			var qClassName:String = getQualifiedClassName(object);
			var objectType = getDefinitionByName(qClassName) as Class;
			var tempObject =  new objectType;
			var objInfo:Object = ObjectUtil.getClassInfo(object); 
			var fieldName:Array = objInfo["properties"] as Array; 
			for each(var pn:String in fieldName){
				try{
					tempObject[pn] = object[pn];
				}catch(e:Error){}
			}
			return tempObject;
		}
	}
}