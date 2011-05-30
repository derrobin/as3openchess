/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:39 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class RookRange extends MoveRange {

	public function RookRange( depth : int = 8 ) {
		super( depth );
	}

	override public function getRangeToField( field:FieldNotation ):FieldNotationCollection {
		var res:FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( getLineFromField( field, SAME, TOP ) );
		res.addCollection( getLineFromField( field, SAME, BOTTOM ) );
		res.addCollection( getLineFromField( field, LEFT, SAME ) );
		res.addCollection( getLineFromField( field, RIGHT, SAME ) );

		return res;
	}

}
}
