package de.robinz.as3.pcc.chessboard.library.pieces
{
	public class King extends Piece implements IPiece
	{
		public static var NAME : String = "king";

		public function King() {
		}

		public override function getName() : String {
			return NAME;
		}
		public override function get notationChar() : String {
			return "K";
		}
	}
}