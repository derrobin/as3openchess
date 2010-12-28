package de.robinz.as3.pcc.chessboard.library.pieces
{
	/**
	 * Knight
	 *
	 * @author robin heinel
	 */
	public class Knight extends Piece implements IPiece
	{
		public static var NAME : String = "knight";

		public function Knight() {
		}

		public override function getName() : String {
			return NAME;
		}

		public override function getSortIndex() : int {
			return 4;
		}
		public override function get notationChar() : String {
			return "S";
		}
	}
}