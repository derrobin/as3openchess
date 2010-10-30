package de.robinz.as3.pcc.chessboard.library.pieces
{
	public class Knight extends Piece implements IPiece
	{
		public static var NAME : String = "knight";

		public function Knight() {
		}

		public override function getName() : String {
			return NAME;
		}

	}
}