package de.robinz.as3.pcc.chessboard.library.pieces
{
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

	/**
	 * Knight
	 *
	 * @author robin heinel
	 */
	public class Knight extends Piece implements IPiece
	{
		public static var NAME : String = "knight";

		public function Knight() {
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

		public override function isMoveValide( m : ChessboardMove ) : Boolean {
			if( super.isMoveValide( m ) ) {
				var diffRow : int;
				var diffCol : int;

				diffRow = Math.abs( m.toPosition.row - m.fromPosition.row );
				diffCol = Math.abs( Notation.indexes.getItemIndex( m.fromPosition.column ) - Notation.indexes.getItemIndex( m.toPosition.column ) );

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