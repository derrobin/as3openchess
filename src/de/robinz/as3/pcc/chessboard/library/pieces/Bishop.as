package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.pieces.moverange.BishopRange;

/**
 * Bishop
 *
 * @author robin heinel
 */
public class Bishop extends Piece implements IPiece
{
	public static var NAME : String = "bishop";

	public function Bishop() {
		this._range = new BishopRange();
	}

	public override function getName() : String {
		return NAME;
	}

	public override function getSortIndex() : int {
		return 8;
	}

	public override function get notationChar() : String {
		return "L";
	}

	public override function isMoveValid( m : ChessboardMove ) : Boolean {
		if( super.isMoveValid( m ) ) {
			var diffRow : int;
			var diffCol : int;

			diffRow = Math.abs( m.toPosition.row - m.fromPosition.row );
			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromPosition.column ) - FieldNotation.indexes.getItemIndex( m.toPosition.column ) );

			if( diffCol == diffRow ) {
				return true;
			}

		}

		return false;
	}

}
}