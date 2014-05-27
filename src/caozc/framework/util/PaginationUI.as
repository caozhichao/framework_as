package game.view.base.util
{
	/**
	 * 简单分页ui组件
	 * @author caozc
	 * @version 1.0.0
	 * 创建时间：2014-4-28 下午5:18:10
	 * 
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ui.pagePanel.RPageCtl;
	
	public class PaginationUI extends Sprite
	{
		private var _pageUI:RPageCtl;
		//数据分页对象
		private var _pagination:Pagination;
		//更新显示处理函数
		private var _callback:Function;
		
		public function PaginationUI(pageSize:int,callback:Function)
		{
			super();
			//363,511
			_pageUI = new RPageCtl();
			addChild(_pageUI);
			_pageUI.addEventListener(RPageCtl.CTL_LEFTBTN_CLICK_EVENT,onPre);
			_pageUI.addEventListener(RPageCtl.CTL_RIGHTBTN_CLICK_EVENT,onNext);
			_pageUI.addEventListener(RPageCtl.CTL_FIRST_CLICK_EVENT,onFirst);
			_pageUI.addEventListener(RPageCtl.CTL_LAST_CLICK_EVENT,onLast);
			_pagination = new Pagination(pageSize);
			_callback = callback;
		}
		
		public function setPageItems(items:Array):void
		{
			_pagination.items = items;
			//默认显示第一页
			onFirst(null);
		}
		
		private function update(list:Array):void
		{
			_callback(list);
			setPageUI();
			updateTF(_pagination.pageStr);
		}
		
		protected function onLast(event:Event):void
		{
			_pagination.toEndPage();
			update(_pagination.curPageItems);
		}
		
		protected function onFirst(event:Event):void
		{
			_pagination.toFirstPage();
			update(_pagination.curPageItems);
		}
		
		protected function onNext(event:Event):void
		{
			_pagination.toNextPage();
			update(_pagination.curPageItems);
		}
		
		protected function onPre(event:Event):void
		{
			_pagination.toPrePage();
			update(_pagination.curPageItems);
		}
		
		private function setPageUI():void
		{
			if(_pagination.isFirstPage && _pagination.isEndPage)
			{
				_pageUI.disableState(0);
				_pageUI.disableState(1);
			} else if(_pagination.isFirstPage)
			{
				_pageUI.disableState(0);
				_pageUI.disableState(3);
			} else if(_pagination.isEndPage)
			{
				_pageUI.disableState(2);
				_pageUI.disableState(1);
			} else 
			{
				_pageUI.disableState(2);
				_pageUI.disableState(3);
			}
		}
		
		public function updateTF(value:String):void
		{
			_pageUI.updateTF(_pagination.pageStr);
		}
		
		public function dispose():void
		{
			_pageUI.removeEventListener(RPageCtl.CTL_LEFTBTN_CLICK_EVENT,onPre);
			_pageUI.removeEventListener(RPageCtl.CTL_RIGHTBTN_CLICK_EVENT,onNext);
			_pageUI.removeEventListener(RPageCtl.CTL_FIRST_CLICK_EVENT,onFirst);
			_pageUI.removeEventListener(RPageCtl.CTL_LAST_CLICK_EVENT,onLast);
			this.removeChild(_pageUI);
			_pageUI = null;
			_callback = null;
		}
	}
}