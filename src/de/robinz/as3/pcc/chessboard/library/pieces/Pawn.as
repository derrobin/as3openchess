package de.robinz.as3.pcc.chessboard.library.pieces
{
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
	}
}