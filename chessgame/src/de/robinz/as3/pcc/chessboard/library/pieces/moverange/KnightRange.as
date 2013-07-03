/**
 * Author: Vitali Monastyrjow
 * Date: 5/30/11
 * Time: 9:26 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {

import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class KnightRange implements IMoveRange {
	public function KnightRange() {
	}

	public function getRange( field:FieldNotation, position:ChessPosition ):FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		if( getKnightMoveFromField( field, MoveRange.LEFT * 2, MoveRange.TOP * 1, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.LEFT * 2, MoveRange.TOP * 1, position ));
		}

		if( getKnightMoveFromField( field, MoveRange.LEFT * 1, MoveRange.TOP * 2, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.LEFT * 1, MoveRange.TOP * 2, position ));
		}

		if( getKnightMoveFromField( field, MoveRange.RIGHT * 2, MoveRange.TOP * 1, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.RIGHT * 2, MoveRange.TOP * 1, position ));
		}

		if( getKnightMoveFromField( field, MoveRange.RIGHT * 1, MoveRange.TOP * 2, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.RIGHT * 1, MoveRange.TOP * 2, position ));
		}

		if( getKnightMoveFromField( field, MoveRange.LEFT * 2, MoveRange.BOTTOM * 1, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.LEFT * 2, MoveRange.BOTTOM * 1, position ));
		}

		if( getKnightMoveFromField( field, MoveRange.LEFT * 1, MoveRange.BOTTOM * 2, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.LEFT * 1, MoveRange.BOTTOM * 2, position ));
		}

		if( getKnightMoveFromField( field, MoveRange.RIGHT * 2, MoveRange.BOTTOM * 1, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.RIGHT * 2, MoveRange.BOTTOM * 1, position ));
		}

		if( getKnightMoveFromField( field, MoveRange.RIGHT * 1, MoveRange.BOTTOM * 2, position ) ) {
			res.add(getKnightMoveFromField( field, MoveRange.RIGHT * 1, MoveRange.BOTTOM * 2, position ) );
		}

		return res;
	}

	private function getKnightMoveFromField( field:FieldNotation, column:int, row:int, position:ChessPosition ):FieldNotation {

		var res:FieldNotationCollection = new FieldNotationCollection();

		var f2add:FieldNotation;

		if ( !FieldNotation.checkSetRow( field.row, row ) ||
			!FieldNotation.checkSetColumn( field.column, column )
		) {
			return null;
		}

		f2add = FieldNotation.createNotationByString(
				FieldNotation.indexes[ field.columnIndex + column ] +
				(field.row + row) );

		if( position && position.getPieceAt( f2add.getNotation() ) ) {
            var n1:String = field.getNotation();
            var n2:String = f2add.getNotation();
            var a:Boolean = position.getPieceAt( n1 ).isWhite;
            var b:Boolean = position.getPieceAt( n2 ).isWhite;

			if( a != b ) {
				return f2add;
			}
            return null;
		}

		return f2add;
	}

}
}
