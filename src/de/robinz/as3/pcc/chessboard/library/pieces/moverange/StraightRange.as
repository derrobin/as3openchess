/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:39 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class StraightRange implements IMoveRange {

	public function getRangeToField( field:FieldNotation ):FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();
		var f2add : FieldNotation;
		var i : int;

		for( i = 1; i < 9; i++) {
			f2add = FieldNotation.createNotationByString( field.column + ( i ) );
			if( !f2add.equals(field) ) {
				res.add( f2add );
			}
		}

		for( i = 0; i < 8; i++ ) {
			f2add = FieldNotation.createNotationByString( FieldNotation.indexes[ i ] + field.row );
			if( !f2add.equals(field) ) {
				res.add( f2add );
			}
		}

		return res;
	}
}
}
