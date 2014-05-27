package caozc.framework.view
{
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	
	import game.ResourceManager;
	import game.view.ui.BasicUI;
	import game.view.base.ISingle;
	
	public class BaseView extends BasicUI implements ISingle
	{
		protected var _skin:Sprite;
		protected var _mediator:Mediator;
		
		public function BaseView(isDrag:Boolean=true, isShowHelp:Boolean=true, isShowBg:Boolean=true)
		{
			super(isDrag, isShowHelp, isShowBg);
		}
		
		public function registerMediator(mediatorClass:Class):void
		{
			_mediator = new mediatorClass(this);
		}
		
		public function setData(data:*):void
		{
			super.onStart();
		}
		
		override protected function initUI():void
		{
			super.initUI();
			var cla:Class = ResourceManager.getDisplayToClass(skinName);
			if(cla)
			{
				_skin = new cla();
				addChild(_skin);
			} else 
			{
				throw new Error("未找到皮肤资源:" + skinName);
			}
//			Reflection.reflection(this,_skin);
		}
		
		protected function get skinName():String
		{
			/*
			var str:String = getQualifiedClassName(this);
			var list:Array = str.split("::");
			return list[1];
			*/
			return null;
		}
	}
}