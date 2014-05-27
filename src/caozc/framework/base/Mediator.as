package caozc.framework.base
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	
	
	/**
	 *  基础中介器
	 * @author caozc
	 * 
	 */	
	public class Mediator extends FrameworkEventDispatcher implements IMediator
	{
		/**
		 *中介器绑定的显示对象 
		 */		
		protected var _viewComponent:DisplayObject;
		
		public function Mediator(view:DisplayObject)
		{
			_viewComponent = view;
			init();
		}
		
		protected function init():void
		{
			_viewComponent.addEventListener(Event.ADDED_TO_STAGE,onStage,false,int.MAX_VALUE,true);
			_viewComponent.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved,false,0,true);
		}
		private function onRemoved(evt:Event):void
		{
			onRemove();
		}
		
		private function onStage(event:Event):void
		{
			onRegister();
		}
		
		public function onRemove():void
		{
			dispose();
			//处理框架资源释放(框架事件会自动释放)
		}
		
		public function onRegister():void
		{
			//注册框架侦听函数
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}