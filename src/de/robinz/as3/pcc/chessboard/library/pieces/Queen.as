package de.robinz.as3.pcc.chessboard.library.pieces
{
	import de.robinz.as3.pcc.chessboard.library.IPiece;
	import de.robinz.as3.pcc.chessboard.library.Piece;

	public class Queen extends Piece implements IPiece
	{
		public static var NAME : String = "queen";

		public function Queen() {
		}

		public override function getName() : String {
			return NAME;
		}

	}
}