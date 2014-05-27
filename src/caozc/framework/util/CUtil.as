package game.view.base.util
{
	import com.adobe.serialization.json.JSON;
	
	import flash.utils.Dictionary;

	/**
	 * @author caozc
	 * @version 1.0.0
	 * 创建时间：2014-5-7 上午11:44:21
	 * 
	 */
	public class CUtil
	{
		public function CUtil()
		{
			Dictionary
		}
		
		/**
		 * 对象字典转换成数组 
		 * @param objs
		 * @return 
		 * 
		 */		
		public static function objDictionaryToArray(objs:Object):Array
		{
			var obj:Object;
			var list:Array = [];
			for each (obj in objs) 
			{
				list.push(obj);
			}
			return list;
		} 
		
		/**
		 * json string format Array 
		 * @param jsonStr
		 * @return 
		 * 
		 */		
		public static function jsonToArray(jsonStr:String):Array
		{
			var jsonObj:Object; 
			if(jsonStr != "")
			{
				jsonObj = com.adobe.serialization.json.JSON.decode(jsonStr);
			} else 
			{
				return [];
			}
			return objDictionaryToArray(jsonObj);
		}
		
	}
}