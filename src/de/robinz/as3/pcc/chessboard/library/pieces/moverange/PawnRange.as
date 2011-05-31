/**
 * Author: Vitali Monastyrjow
 * Date: 5/30/11
 * Time: 9:17 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {

import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class PawnRange extends MoveRange {
	public function PawnRange() {
		super(1);
	}

	override public function getRangeToField( field : FieldNotation ) : FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( getLineFromField( field, SAME, TOP ) );

		return res;
	}
}
}
