package de.robinz.as3.pcc.chessboard.library
{
	public class BoardPiece implements IBoardPiece
	{
		public static var PIECE_PAWN : String = "p";
		public static var PIECE_ROOK : String = "r";
		public static var PIECE_BISHOP : String = "b";
		public static var PIECE_KING : String = "k";
		public static var PIECE_QUEEN : String = "q";
		public static var PIECE_KNIGHT : String = "h";

		public var piece : String;
		public var white : Boolean = true;

		public static function createByParams( piece : String, white : Boolean = true ) : IBoardPiece {
			var p : BoardPiece = new BoardPiece();

			if ( ! white ) {

				p.white = false;

				switch( piece ) {
					case PIECE_PAWN: piece = "o"; break;
					case PIECE_ROOK: piece = "t"; break;
					case PIECE_BISHOP: piece = "n"; break;
					case PIECE_KING: piece = "l"; break;
					case PIECE_QUEEN: piece = "w"; break;
					case PIECE_KNIGHT: piece = "j"; break;
				}

			}

			p.piece = piece;

			return p as IBoardPiece;
		}

		public function get fontKey() : String {
			return this.piece;
		}

		public function get isWhite() : Boolean {
			return this.white;
		}

	}
}