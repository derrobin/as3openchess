package de.robinz.as3.pcc.chessboard.library.pieces
{
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.FieldNotation;

/**
 * King
 *
 * @author robin heinel
 */
public class King extends Piece implements IPiece
{
	public static var NAME : String = "king";

	public function King() {
	}

	public override function getName() : String {
		return NAME;
	}
	public override function get notationChar() : String {
		return "K";
	}

	public override function isMoveValide( m : ChessboardMove ) : Boolean {
		if( super.isMoveValide( m ) ) {
			var maxDiffRow : int = 1;
			var maxDiffCol : int = 1;
			var diffRow : int;
			var diffCol : int;

			diffRow = Math.abs( m.toPosition.row - m.fromPosition.row );
			diffCol = Math.abs( FieldNotation.indexes.getItemIndex( m.fromPosition.column ) - FieldNotation.indexes.getItemIndex( m.toPosition.column ) );
			if( ( maxDiffRow >= diffRow ) && ( maxDiffCol >= diffCol )  ) {
				return true;
			}

		}

		return false;
	}

}
}