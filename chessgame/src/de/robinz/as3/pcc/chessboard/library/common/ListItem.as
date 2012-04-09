package de.robinz.as3.pcc.chessboard.library.common {

/**
 * de.robinz.as3.pcc.chessboard.library.common
 *
 * @author robin heinel
 */
public class ListItem {
	public var label : String;
	public var data : Object;

	public function ListItem( label : String, data : Object = null ) {
		this.label = label;
		this.data = data;
	}
}
}