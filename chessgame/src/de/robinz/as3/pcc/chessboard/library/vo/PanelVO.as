package de.robinz.as3.pcc.chessboard.library.vo
{
import mx.containers.Panel;
import mx.core.Container;

public class PanelVO
{
	public var container : Container;
	public var visible : Boolean = false;

	public function PanelVO() {
	}

	public static function createByParams( c : Container ) : PanelVO {
		var o : PanelVO = new PanelVO();

		o.container = c;

		return o;
	}

}
}