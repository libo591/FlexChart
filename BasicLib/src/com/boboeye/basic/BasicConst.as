package com.boboeye.basic
{
	/**
	 * 授权中应该包括的内容
	 * 1.域名（指定域名+localhost+127.0.0.1）
	 * 2.过期时间
	 * 3.版本（免费版：A，个人版：B，企业版：C）
	 * 4.功能点（
	 * 		10000：图表全功能。10001：地图全功能。10002：工具全功能。10003：表格全功能。
	 * 		10004：图表基础版。10005：地图基础版。10006：工具基础版。10007：表格基础版。
	 * 		10008：全功能。
	 * ）
	 */
	public class BasicConst
	{
		//版本
		/** 免费版 */
		public static const VERSION_FREE:String 			= "A";
		/** 个人版 */
		public static const VERSION_PERSONAL:String 		= "B";
		/** 企业版 */
		public static const VERSION_ENTERPRISE:String 		= "C";
		//功能点
		/** 图表高级 */
		public static const FUNC_CHART_ALL:String 			= "10000";
		/** 图表普通 */
		public static const FUNC_CHART_NORMAL:String 		= "10004";
		/** 地图高级 */
		public static const FUNC_MAP_ALL:String 			= "10001";
		/** 地图普通 */
		public static const FUNC_MAP_NORMAL:String			= "10005";
		/** 工具高级 */
		public static const FUNC_TOOL_ALL:String 			= "10002";
		/** 工具普通 */
		public static const FUNC_TOLL_NORMAL:String			= "10006";
		/** 表格高级 */
		public static const FUNC_GRID_ALL:int 				= "10003";
		/** 表格普通 */
		public static const FUNC_GRID_NORMAL:int 			= "10007";
		
		public function BasicConst()
		{
		}
	}
}