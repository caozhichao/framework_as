package caozc.framework.view
{
	import flash.events.Event;
	
	public class BaseEvent extends Event
	{
		public var data:*;
		public function BaseEvent(type:String, data:*,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}