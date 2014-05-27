package caozc.framework.view
{
	/**
	 * @author caozc
	 * @version 1.0.0
	 * 创建时间：2014-4-24 下午3:31:29
	 * 
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import caozc.framework.base.Mediator;
	
	
	
	public class BasePanel extends Sprite implements IBasePanel
	{
		private static const POSITION:Point = new Point(0,0);
		protected var _skin:Sprite;
		private var _mediator:Mediator;
		protected var _isInit:Boolean = false;

		private var index:int;
		public function BasePanel(mediator:Class=null)
		{
			registerMediator(mediator);
			addEventListener(Event.ADDED_TO_STAGE,onStage,false,0,true);
		}
		
		/**
		 * 重写该方法，拉起数据后，super.show(); 
		 * 
		 */		
		public function initDataReq():void
		{
			//显示界面之前，拉起数据
			show();
		}
		
		/**
		 * 注册一个中介器 
		 * @param mediatorClass
		 * 
		 */		
		public function registerMediator(mediatorClass:Class):void
		{
			if(mediatorClass)
			{
				_mediator = new mediatorClass(this);
			}
		}
		
		/**
		 * 添加到舞台，初始化皮肤 
		 * @param event
		 * 
		 */		
		private function onStage(event:Event):void
		{
			if(!_isInit)
			{
				initUI();
				addChildAt(_skin,0);
				this.x = position.x;
				this.y = position.y;
				_isInit = true;
			}
			if(index != 0)
			{
				clearTimeout(index);
				index = 0;
			}
			index = setTimeout(initDataReq,100);
//			initDataReq();
			this.alpha = 0;
		}
		
		/**
		 * 界面坐标 
		 * @return 
		 * 
		 */		
		public function get position():Point
		{
			return POSITION;
		}
		/**
		 * 初始化皮肤 ，子类重写 
		 * 
		 * @param skinName
		 * 
		 */		
		public function initUI():void
		{
			/*
			var cla:Class = ResourceManager.getDisplayToClass(skinName);
			_skin = new cla();
			*/
			
			//由于加密混淆问题暂时不用
//			Reflection.reflection(this,_skin);
		}
		
		/**
		 * 实际显示添加到显示列表中 
		 * 
		 */		
		protected function show(isTween:Boolean=false):void
		{
			if(isTween)
			{
//				TweenLite.to(this,0.3,{alpha:1});
			} else 
			{
				this.alpha = 1;
			}
		}
		/**
		 * 皮肤名称，默认取类名称，可重写，指定名称 
		 * @return 
		 * 
		 */		
		public function get skinName():String
		{
			/*
			var str:String = getQualifiedClassName(this);
			var list:Array = str.split("::");
			return list[1];
			*/
			return null;
		}
		
		public function dispose():void
		{
			_isInit = false;
			removeEventListener(Event.ADDED_TO_STAGE,onStage);
			_skin = null;
			if(_mediator)
			{
				_mediator = null;
			}
		} 
		
	}
}