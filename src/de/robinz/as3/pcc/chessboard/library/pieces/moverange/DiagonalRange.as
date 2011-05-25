/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:58 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class DiagonalRange implements IMoveRange {
	public function DiagonalRange() {
	}

	public function getRangeToField( field:FieldNotation ):FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( getDiagonal( field, 1, 1 ) );
		res.addCollection( getDiagonal( field, -1, 1 ) );
		res.addCollection( getDiagonal( field, 1, -1 ) );
		res.addCollection( getDiagonal( field, -1, -1 ) );

		return res;
	}

	private function getDiagonal( startField : FieldNotation, rowMulti : int, columnMulti : int ) : FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		var boardEnd : Boolean = false;
		var inc : int = 1;
		var f2add : FieldNotation;

		var newRow : int;
		var newColunIndex : int;


		while(!boardEnd) {

			if( !startField.checkRowSet( inc * rowMulti ) ||
				!startField.checkSetColumn( inc * columnMulti )
			) {
				return res;
			}

			f2add = FieldNotation.createNotationByString(
				FieldNotation.indexes[ startField.columnIndex + inc * columnMulti ] +
				(startField.row + inc * rowMulti)
			);

			if(!f2add.equals(startField)) {
				res.add( f2add );
			}
			inc += 1;
		}

		return null;
	}

}
}
