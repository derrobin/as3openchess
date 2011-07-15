/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:58 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class BishopRange extends MoveRange {

	public function BishopRange( depth : int = 8 ) {
		super( depth );
	}

	override public function getRange( field:FieldNotation, position:ChessPosition ):FieldNotationCollection {
		var res : FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( getLineFromField( field, LEFT, BOTTOM, position ) );
		res.addCollection( getLineFromField( field, LEFT, TOP, position ) );
		res.addCollection( getLineFromField( field, RIGHT, TOP, position ) );
		res.addCollection( getLineFromField( field, RIGHT, BOTTOM, position ) );

		return res;
	}

}
}
