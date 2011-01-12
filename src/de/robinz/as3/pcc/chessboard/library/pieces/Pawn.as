package de.robinz.as3.pcc.chessboard.library.pieces
{
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;

	/**
	 * Pawn
	 *
	 * @author robin heinel
	 */
	public class Pawn extends Piece implements IPiece
	{
		public static var NAME : String = "pawn";

		public function Pawn() {
		}

		public override function getName() : String {
			return NAME;
		}

		public override function getSortIndex() : int {
			return 16;
		}
		public override function get notationChar() : String {
			return "B";
		}

		public override function isMoveValide( m : ChessboardMove ) : Boolean {
			if( super.isMoveValide( m ) ) {
				var maxDiffRow : int = 1;
				var maxDiffCol : int = 0;
				var diffRow : int;
				var diffCol : int;

				if( this.isWhite && m.fromPosition.row == 2 || (!this.isWhite && m.fromPosition.row == 7 ) ) {
					maxDiffRow = 2;
				}

				if( this.isWhite ) {
					diffRow = m.toPosition.row - m.fromPosition.row;
				} else {
					diffRow = m.fromPosition.row - m.toPosition.row;
				}

				if( diffRow < 0 ) {
					return false;
				}

				diffCol = Math.abs( Notation.indexes.getItemIndex( m.fromPosition.column ) - Notation.indexes.getItemIndex( m.toPosition.column ) );
				if( ( maxDiffRow >= diffRow ) && ( maxDiffCol >= diffCol ) && ( m.beatenPiece == null ) ) {
					return true;
				}

				if( m.beatenPiece && diffRow == 1 && diffCol == 1 ) {
					return true;
				}

			}

			return false;
		}
	}
}