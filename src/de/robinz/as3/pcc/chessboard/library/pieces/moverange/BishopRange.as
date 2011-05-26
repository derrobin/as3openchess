/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:58 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class BishopRange extends MoveRange {

	public function BishopRange( depth : int = 9 ) {
		super( depth );
	}

	override public function getRangeToField( field:FieldNotation ):FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( getLineFromField( field, RIGHT, TOP ) );
		res.addCollection( getLineFromField( field, RIGHT, BOTTOM ) );
		res.addCollection( getLineFromField( field, LEFT, TOP ) );
		res.addCollection( getLineFromField( field, LEFT, BOTTOM ) );

		return res;
	}

}
}
