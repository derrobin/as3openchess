/**
 * Author: Vitali Monastyrjow
 * Date: 5/30/11
 * Time: 9:17 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class PawnRange extends MoveRange {
	public function PawnRange() {
		super(1);
	}

	override public function getRange( field:FieldNotation, position:ChessPosition ) : FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		if( position.getPieceAt( field.getNotation() ).isWhite ) {
			res.addCollection( getLineFromField( field, SAME, TOP, position ) );
			res.addCollection( getLineFromField( field, LEFT, TOP, position ) );
			res.addCollection( getLineFromField( field, RIGHT, TOP, position ) );
			return res;
		}

		res.addCollection( getLineFromField( field, SAME, BOTTOM, position ) );
		res.addCollection( getLineFromField( field, LEFT, BOTTOM, position ) );
		res.addCollection( getLineFromField( field, RIGHT, BOTTOM, position ) );

		return res;
	}
}
}
