package de.robinz.as3.pcc.chessboard.library.pieces
{
	import de.robinz.as3.pcc.chessboard.library.IPiece;
	import de.robinz.as3.pcc.chessboard.library.Piece;

	public class Bishop extends Piece implements IPiece
	{
		public static var NAME : String = "bishop";

		public function Bishop() {
		}

		public override function getName() : String {
			return NAME;
		}

	}
}