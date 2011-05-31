/**
 * Author: Vitali Monastyrjow
 * Date: 5/30/11
 * Time: 9:26 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {

import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class KnightRange implements IMoveRange {
	public function KnightRange() {
	}

	public function getRangeToField( field:FieldNotation ):FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		if( getKnightMoveFromField(field, MoveRange.LEFT * 2, MoveRange.TOP*1) ) {
			res.add(getKnightMoveFromField(field, MoveRange.LEFT * 2, MoveRange.TOP*1));
		}

		if( getKnightMoveFromField(field, MoveRange.LEFT * 1, MoveRange.TOP*2) ) {
			res.add(getKnightMoveFromField(field, MoveRange.LEFT * 1, MoveRange.TOP*2));
		}

		if( getKnightMoveFromField(field, MoveRange.RIGHT * 2, MoveRange.TOP*1) ) {
			res.add(getKnightMoveFromField(field, MoveRange.RIGHT * 2, MoveRange.TOP*1));
		}

		if( getKnightMoveFromField(field, MoveRange.RIGHT * 1, MoveRange.TOP*2) ) {
			res.add(getKnightMoveFromField(field, MoveRange.RIGHT * 1, MoveRange.TOP*2));
		}

		if( getKnightMoveFromField(field, MoveRange.LEFT * 2, MoveRange.BOTTOM*1) ) {
			res.add(getKnightMoveFromField(field, MoveRange.LEFT * 2, MoveRange.BOTTOM*1));
		}

		if( getKnightMoveFromField(field, MoveRange.LEFT * 1, MoveRange.BOTTOM*2) ) {
			res.add(getKnightMoveFromField(field, MoveRange.LEFT * 1, MoveRange.BOTTOM*2));
		}

		if( getKnightMoveFromField(field, MoveRange.RIGHT * 2, MoveRange.BOTTOM*1) ) {
			res.add(getKnightMoveFromField(field, MoveRange.RIGHT * 2, MoveRange.BOTTOM*1));
		}

		if( getKnightMoveFromField(field, MoveRange.RIGHT * 1, MoveRange.BOTTOM*2) ) {
			res.add(getKnightMoveFromField( field, MoveRange.RIGHT * 1, MoveRange.BOTTOM*2 ) );
		}

		return res;
	}

	private function getKnightMoveFromField( field:FieldNotation, column:int, row:int ):FieldNotation {

		var res:FieldNotationCollection = new FieldNotationCollection();

		var f2add:FieldNotation;

		if ( !FieldNotation.checkSetRow( field.row, row ) ||
			!FieldNotation.checkSetColumn( field.column, column )
		) {
			return null;
		}

		return FieldNotation.createNotationByString(
				FieldNotation.indexes[ field.columnIndex + column ] +
				(field.row + row)
		);
	}

}
}
