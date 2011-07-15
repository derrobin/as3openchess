/**
 * Author: Vitali Monastyrjow
 * Date: 5/26/11
 * Time: 9:40 PM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class QueenRange extends MoveRange {

	override public function getRange( field:FieldNotation, position:ChessPosition ) : FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( new RookRange().getRange( field, position ) );
		res.addCollection( new BishopRange().getRange( field, position ) );

		return res;
	}
}
}
