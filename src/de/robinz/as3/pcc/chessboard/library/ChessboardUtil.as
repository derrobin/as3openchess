package de.robinz.as3.pcc.chessboard.library {

/**
 * de.robinz.as3.pcc.chessboard.library
 *
 * @author robin heinel
 */
public class ChessboardUtil {

	public static function getNotationSequence() : Array {
		var sequence : Array = new Array();
		var rows : String = "abcdefgh";
		var notation : String;
		var i : int = 1;
		var j : int = 1;

		for( j = 8; j > 0; j-- ) {
			for( i; i <= rows.length; i++ ) {
				notation = rows.charAt( i - 1 ) + j.toString();
				sequence.push( notation );
			}
			i = 1;
		}

		return sequence;
	}

}
}