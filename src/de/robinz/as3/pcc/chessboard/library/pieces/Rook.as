package de.robinz.as3.pcc.chessboard.library.pieces
{
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


	}
}