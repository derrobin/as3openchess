/**
 * Author: Vitali Monastyrjow
 * Date: 5/26/11
 * Time: 9:40 PM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class QueenRange extends MoveRange {

	override public function getRangeToField( field : FieldNotation ) : FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( new RookRange().getRangeToField(field) );
		res.addCollection( new BishopRange().getRangeToField(field) );

		return res;
	}
}
}
