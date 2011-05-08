package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.FieldNotation;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

/**
 * Rook
 *
 * @author robin heinel
 */
public class Rook extends Piece implements IPiece
{
	public static var NAME : String = "rook";

	public function Rook() {
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

	public override function isMoveValide( m : ChessboardMove ) : Boolean {
		if( super.isMoveValide( m ) ) {
			var maxDiffRow : int = 8;
			var maxDiffCol : int = 8;
			var diffRow : int;
			var diffCol : int;

			diffRow = Math.abs( m.toPosition.row - m.fromPosition.row );
			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromPosition.column ) - FieldNotation.indexes.getItemIndex( m.toPosition.column ) );

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