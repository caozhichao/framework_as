package caozc.framework.base
{
	import caozc.framework.evnet.EventManager;
	
	import game.view.base.Inject;

	/**
	 * 框架基础事件 
	 * 实现框架事件自动释放
	 * @author caozc
	 * 
	 */	
	public class FrameworkEventDispatcher extends Inject implements IDispose
	{
		//缓存监听的事件，用于框架自销毁监听
		private var _evtList:Vector.<Object>;
		
		public function FrameworkEventDispatcher()
		{
			_evtList = new Vector.<Object>();
		}
		
		/**
		 * 派发事件 
		 * @param type
		 * @param evt
		 * @param data
		 * 
		 */		
		public function dispatchEvent(type:String,evt:Class,data:*=null):void
		{
			EventManager.dispatchEvent(type,evt,data);
		}
		
		/**
		 * 监听事件 
		 * @param type
		 * @param listener
		 * @param evt
		 * 
		 */		
		public function addEventListener(type:String,listener:Function,evt:Class):void
		{
			_evtList.push({type:type,listener:listener,evt:evt});
			EventManager.addEventListener(type,listener,evt);
		}
		
		/**
		 * 删除事件 
		 * @param type
		 * @param listenr
		 * @param evt
		 * 
		 */		
		public function removeEventListener(type:String,listener:Function,evt:Class):void
		{
			removeEventOnList(type,listener,evt);
			EventManager.removeEventListener(type,listener,evt);
		}
		
		/**
		 * 删除事件 
		 * @param type
		 * @param listenr
		 * @param evt
		 * 
		 */		
		private function removeEventOnList(type:String,listener:Function,evt:Class):void
		{
			var len:int = _evtList.length;
			var evtObj:Object;
			for (var i:int = 0; i < len; i++) 
			{
				evtObj = _evtList[i];
				if(evtObj.type == type && evtObj.listener == listener && evtObj.evt == evt)
				{
					_evtList.splice(i,1);
					break;
				}
			}
		}
		
		/**
		 * 释放框架注册的事件 
		 * 
		 */		
		public function dispose():void
		{
//			var t:Number = getTimer();
			var evt:Object;
			while(_evtList.length > 0)
			{
				evt = _evtList[0];
				removeEventListener(evt.type,evt.listener,evt.evt);
			}
//			trace("自动销毁事件监听耗时:" ,getTimer() - t);
		}
	}
}