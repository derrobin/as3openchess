/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:33 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public interface IMoveRange {
	function getRange( field:FieldNotation, position:ChessPosition ) : FieldNotationCollection;
}
}
