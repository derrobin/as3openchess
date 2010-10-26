package de.robinz.as3.pcc.chessboard.library
{
	import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
	import de.robinz.as3.pcc.chessboard.library.pieces.Rook;

	public class FontManager
	{
		public function FontManager()
		{
		}

		public static function getFontKeyByPiece( piece : IPiece ) : String {
			switch( piece.getName() ) {
				case Pawn.NAME:		return piece.isWhite ? "p" : "o";
				case Rook.NAME:		return piece.isWhite ? "r" : "t";
				case Bishop.NAME:	return piece.isWhite ? "b" : "n";
				case King.NAME:		return piece.isWhite ? "k" : "l";
				case Queen.NAME:	return piece.isWhite ? "q" : "w";
				case Knight.NAME:	return piece.isWhite ? "h" : "j";

			}

			throw new Error( "No Font Key Found!" );
		}
	}
}