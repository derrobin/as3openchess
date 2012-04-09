package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.KingRange;

/**
 * King
 *
 * @author robin heinel
 */
public class King extends Piece implements IPiece
{
	public static var NAME : String = "king";

	public function King() {
		this._range = new KingRange();
	}

	public override function getName() : String {
		return NAME;
	}
	public override function get notationChar() : String {
		return "K";
	}

	public override function isMoveValid( m : ChessboardMove ) : Boolean {
		if( super.isMoveValid( m ) ) {
			var maxDiffRow : int = 1;
			var maxDiffCol : int = 1;
			var diffRow : int;
			var diffCol : int;

			diffRow = Math.abs( m.toField.row - m.fromField.row );
			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromField.column ) - FieldNotation.indexes.getItemIndex( m.toField.column ) );
			if( ( maxDiffRow >= diffRow ) && ( maxDiffCol >= diffCol )  ) {
				return true;
			}

		}

		return false;
	}

}
}