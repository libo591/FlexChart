package com.basic.loading
{
	public class LoadingManager
	{
		private static var _loading:Loading = new Loading();
		public function LoadingManager()
		{
			
		}
		
		public static function getLoading():Loading{
			return _loading;			
		}
	}
}