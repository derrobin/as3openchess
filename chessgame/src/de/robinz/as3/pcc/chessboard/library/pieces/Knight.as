package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.KnightRange;

/**
 * Knight
 *
 * @author robin heinel
 */
public class Knight extends Piece implements IPiece
{
	public static var NAME : String = "knight";

	public function Knight() {
		this._range = new KnightRange();
	}

	public override function getName() : String {
		return NAME;
	}

	public override function getSortIndex() : int {
		return 4;
	}
	public override function get notationChar() : String {
		return "S";
	}

	public override function isMoveValid( m : ChessboardMove ) : Boolean {
		if( super.isMoveValid( m ) ) {
			var diffRow : int;
			var diffCol : int;

			diffRow = Math.abs( m.toField.row - m.fromField.row );
			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromField.column ) - FieldNotation.indexes.getItemIndex( m.toField.column ) );

			if( diffCol == 2 && diffRow == 1 ) {
				return true;
			}

			if( diffCol == 1 && diffRow == 2 ) {
				return true;
			}

		}

		return false;
	}

}
}