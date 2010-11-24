package de.robinz.as3.pcc.chessboard.library.pieces
{
	public class Bishop extends Piece implements IPiece
	{
		public static var NAME : String = "bishop";

		public function Bishop() {
		}

		public override function getName() : String {
			return NAME;
		}

		public override function getSortIndex() : int {
			return 8;
		}

		public override function get notationChar() : String {
			return "L";
		}

	}
}