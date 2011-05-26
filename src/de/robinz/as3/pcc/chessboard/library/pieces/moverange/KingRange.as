/**
 * Author: Vitali Monastyrjow
 * Date: 5/26/11
 * Time: 9:40 PM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class KingRange extends MoveRange {

	public function KingRange() {
		super(1);
	}

	override public function getRangeToField( field : FieldNotation ) : FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( new RookRange(1).getRangeToField( field ) );
		res.addCollection( new BishopRange(1).getRangeToField( field ) );

		return res;
	}
}
}
