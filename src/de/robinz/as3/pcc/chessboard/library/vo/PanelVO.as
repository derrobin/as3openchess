package de.robinz.as3.pcc.chessboard.library.vo
{
	import mx.containers.Panel;

	public class PanelVO
	{
		public var panel : Panel;
		public var minHeight : int;
		public var maxHeight : int;
		public var visible : Boolean = false;

		public function PanelVO()
		{
		}

		public static function createByParams( panel : Panel, minHeight : int, maxHeight : int ) : PanelVO {
			var o : PanelVO = new PanelVO();

			o.panel = panel;
			o.maxHeight = maxHeight;
			o.minHeight = minHeight;

			return o;
		}

	}
}