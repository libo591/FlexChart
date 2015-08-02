package com.boboeye.basic
{
	public class LicInfo
	{
		private var _hosts:Array;
		private var _registTime:Number;
		private var _version:String;
		private var _func:Array;
		
		public function LicInfo()
		{
		}

		public function get hosts():Array
		{
			return _hosts;
		}

		public function set hosts(value:Array):void
		{
			_hosts = value;
		}

		public function get registTime():Number
		{
			return _registTime;
		}

		public function set registTime(value:Number):void
		{
			_registTime = value;
		}

		public function get version():String
		{
			return _version;
		}

		public function set version(value:String):void
		{
			_version = value;
		}

		public function get func():Array
		{
			return _func;
		}

		public function set func(value:Array):void
		{
			_func = value;
		}


	}
}