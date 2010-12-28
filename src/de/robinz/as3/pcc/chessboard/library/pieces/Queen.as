package de.robinz.as3.pcc.chessboard.library.pieces
{
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

	}
}