/**
 * Author: Vitali Monastyrjow
 * Date: 5/23/11
 * Time: 10:39 AM
 */
package de.robinz.as3.pcc.chessboard.library.pieces.moverange {
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.FieldNotationCollection;

public class RookRange extends MoveRange {

	public function RookRange( depth : int = 8 ) {
		super( depth );
	}

	override public function getRange( field:FieldNotation, position:ChessPosition ):FieldNotationCollection {
		var res:FieldNotationCollection = new FieldNotationCollection();

		res.addCollection( getLineFromField( field, SAME, TOP, position ) );
		res.addCollection( getLineFromField( field, SAME, BOTTOM, position ) );
		res.addCollection( getLineFromField( field, LEFT, SAME, position ) );
		res.addCollection( getLineFromField( field, RIGHT, SAME, position ) );

		return res;
	}

}
}
