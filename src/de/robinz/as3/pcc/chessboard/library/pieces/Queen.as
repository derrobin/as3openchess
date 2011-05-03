package de.robinz.as3.pcc.chessboard.library.pieces
{
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

	/**
	 * Queen
	 *
	 * @author robin heinel
	 */
	public class Queen extends Piece implements IPiece
	{
		public static var NAME : String = "queen";

		public function Queen() {
		}

		public override function getName() : String {
			return NAME;
		}

		public override function getSortIndex() : int {
			return 1;
		}
		public override function get notationChar() : String {
			return "D";
		}

		public override function isMoveValide( m : ChessboardMove ) : Boolean {
			if( super.isMoveValide( m ) ) {
				var maxDiffRow : int = 8;
				var maxDiffCol : int = 8;
				var diffRow : int;
				var diffCol : int;

				diffRow = Math.abs( m.toPosition.row - m.fromPosition.row );
				diffCol = Math.abs( Notation.indexes.getItemIndex( m.fromPosition.column ) - Notation.indexes.getItemIndex( m.toPosition.column ) );

				if( diffCol == diffRow ) {
					return true;
				}

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