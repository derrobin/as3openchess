package de.robinz.as3.pcc.chessboard.library.pieces
{
	public class Pawn extends Piece implements IPiece
	{
		public static var NAME : String = "pawn";

		public function Pawn() {
		}

		public override function getName() : String {
			return NAME;
		}

	}
}