/**
 * Author: Vitali Monastyrjow
 * Date: 5/26/11
 * Time: 9:24 PM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class MoveRange implements IMoveRange {
	protected const TOP:int = 1;
	protected const BOTTOM:int = -1;
	protected const RIGHT:int = 1;
	protected const LEFT:int = -1;
	protected const SAME:int = 0;

	private var _depth:int = 8;
	public function MoveRange( depth : int = 8 ) {
		this._depth = depth;
	}


	public function getRangeToField( field:FieldNotation ):FieldNotationCollection {
		return null;
	}

	protected function getLineFromField( field:FieldNotation, columnDirection:int, rowDirection:int ):FieldNotationCollection {

		var res:FieldNotationCollection = new FieldNotationCollection();

		var inc:int = 1;
		var f2add:FieldNotation;

		var newColunIndex:int;

		while ( this._depth >= inc ) {

			if ( !FieldNotation.checkSetRow( field.row, inc * rowDirection ) ||
				!FieldNotation.checkSetColumn( field.column, inc * columnDirection )
			) {
				return res;
			}

			f2add = FieldNotation.createNotationByString(
					FieldNotation.indexes[ field.columnIndex + inc * columnDirection ] +
							(field.row + inc * rowDirection)
					);

			if ( !f2add.equals( field ) ) {
				res.add( f2add );
			}
			inc += 1;
		}

		return res;

	}
}
}
