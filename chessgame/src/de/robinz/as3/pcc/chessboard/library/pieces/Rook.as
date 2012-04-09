package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.RookRange;

/**
 * Rook
 *
 * @author robin heinel
 */
public class Rook extends Piece implements IPiece
{
	public static var NAME : String = "rook";

	public function Rook() {
		this._range = new RookRange();
	}

	public override function getName() : String {
		return NAME;
	}

	public override function getSortIndex() : int {
		return 2;
	}
	public override function get notationChar() : String {
		return "T";
	}

	public override function isMoveValid( m : ChessboardMove ) : Boolean {
		if( super.isMoveValid( m ) ) {
			var maxDiffRow : int = 8;
			var maxDiffCol : int = 8;
			var diffRow : int;
			var diffCol : int;

			diffRow = Math.abs( m.toField.row - m.fromField.row );
			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromField.column ) - FieldNotation.indexes.getItemIndex( m.toField.column ) );

			if( ( maxDiffRow >= diffRow ) && diffCol == 0 ) {
				return true;
			}

			if( diffRow == 0 && ( maxDiffCol >= diffCol )  ) {
				return true;
			}

		}

		return false;
	}

}
}