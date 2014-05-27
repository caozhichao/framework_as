package caozc.framework.evnet
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 事件通信机制
	 * 通过注册回调函数的方式实现 
	 * @author caozc
	 * 
	 */	
	final public class EventManager
	{
		private static var _instance:EventManager = new EventManager();
		private var _dic:Dictionary;
		
		public function EventManager()
		{
			_dic = new Dictionary();
		}
		
		/**
		 * 派发事件 
		 * @param type   事件类型
		 * @param evt    事件对象类型
		 * @param data   数据
		 * 
		 */		
		public static function dispatchEvent(type:String,evt:Class,data:*=null):void
		{
			var evtType:String = _instance.getEventType(type,evt);
			var list:Array = _instance.getListeners(evtType);
			if(list.length > 0)
			{
				var len:int = list.length;
				var fun:Function;
				var args:int;
				for (var i:int = 0; i < len; i++) 
				{
					fun = list[i];
					args = fun.length;
					if(args == 1)
					{
						fun(data);
					}else if(args == 2)
					{
						fun(type,data);
					} else 
					{
						fun();
					}
				}
			}
		}
		
		/**
		 * 获取事件监听列表 
		 * @param type
		 * @return 
		 * 
		 */		
		private function getListeners(type:String):Array
		{
			var list:Array = _dic[type]; 
			if(list == null)
			{
				list = [];
				_dic[type] = list;
			}
			return list;
		}
		
		/**
		 * 添加监听函数 
		 * @param type     事件类型
		 * @param listener 处理函数
		 * @param evt      事件类型class  
		 * 
		 */		
		public static function addEventListener(type:String,listener:Function,evt:Class):void
		{
			var evtType:String = _instance.getEventType(type,evt);
			var index:int = -1;
			index = _instance.hasEventListener(evtType,listener);
			if(index == -1)
			{
				var list:Array = _instance.getListeners(evtType);
				list.push(listener);
			} else 
			{
				throw new Error("FrameworkEvent 注册了相同函数的事件-> type:" + evtType);
			}
		}
		
		/**
		 * 查找监听函数 
		 * @param type
		 * @param listenr
		 * @return 
		 * 
		 */		
		private function hasEventListener(type:String,listenr:Function):int
		{
			var list:Array = _instance.getListeners(type);
			var index:int = -1;
			if(list.length > 0)
			{
				index = list.indexOf(listenr);
			}
			return index;
		}
		
		private function getEventType(type:String,evt:*):String
		{
			return getQualifiedClassName(evt) + "_" + type;
		}
		
		/**
		 * 移除事件监听 
		 * @param type    事件类型
		 * @param listenr 处理函数
		 * @param evt     事件类型class 
		 * 
		 */		
		public static function removeEventListener(type:String,listener:Function,evt:Class):void
		{
			var evtType:String = _instance.getEventType(type,evt);
			var index:int = -1;
			index = _instance.hasEventListener(evtType,listener); 
			if(index != -1)
			{
				var list:Array = _instance.getListeners(evtType);
				list.splice(index,1);
			}
		}
	}
}