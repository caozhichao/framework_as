package game.view.base.util
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import game.utils.DisplayUtil;
	import game.utils.RTools;
	
	import ui.button.RBmpButton;
	
	/**
	 *  
	 * @author caozc
	 * 
	 */	
	public class CBmpButton extends RBmpButton
	{
		private var btn_ani:MovieClip;
		public function CBmpButton(obj:DisplayObject, x:int=0, y:int=0, clickFun:Function=null,addBtnAni:Boolean=false)
		{
			var tx:int = obj.x;
			var ty:int = obj.y;
			obj.x = obj.y = 0;
			super(obj, tx, ty, clickFun);
			addAni(addBtnAni);
		}
		private function addAni(addBtnAni:Boolean):void
		{
			if(addBtnAni)
			{
				btn_ani = RTools.getMovieClip("UI_Icon_Could_Effect");
				btn_ani.x = -5;
				btn_ani.y = -5;
				btn_ani.width = this.width + 12;
				btn_ani.height = this.height + 10;
				addChild(btn_ani);
			}
		}
		
		override public function dispose():void
		{
			if(btn_ani)
			{
				if(btn_ani.parent)
				{
					btn_ani.parent.removeChild(btn_ani);
				}
				DisplayUtil.stopMCAll(btn_ani);
				btn_ani = null;
			}
			super.dispose();
		}
	}
}