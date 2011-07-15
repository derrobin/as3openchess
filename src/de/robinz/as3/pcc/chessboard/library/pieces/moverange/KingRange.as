/**
 * Author: Vitali Monastyrjow
 * Date: 5/26/11
 * Time: 9:40 PM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class KingRange extends MoveRange {

	public function KingRange() {
		super(1);
	}

	override public function getRange( field:FieldNotation, position:ChessPosition ) : FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( new RookRange(1).getRange( field, position ) );
		res.addCollection( new BishopRange(1).getRange( field, position ) );

		return res;
	}
}
}
