package caozc.framework.view
{
	import flash.geom.Point;

	public interface IBasePanel
	{
		function initDataReq():void;
		function initUI():void;
		function get position():Point;
		function get skinName():String;
	}
}