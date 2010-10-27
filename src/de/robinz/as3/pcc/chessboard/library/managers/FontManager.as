package de.robinz.as3.pcc.chessboard.library.managers
{
	import de.robinz.as3.pcc.chessboard.library.IPiece;
	import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
	import de.robinz.as3.pcc.chessboard.library.pieces.Rook;

	public class FontManager
	{
		private static var _instance : FontManager;
		private static var _allowInstantiation : Boolean;

		public function FontManager() {
			if ( !_allowInstantiation ) {
				throw new Error( "Error: Instantiation failed: Use static::getInstance() instead of new." );
			}
		}

		public static function getInstance() : FontManager {
			if ( _instance == null ) {
				_allowInstantiation = true;
				_instance = new FontManager();
				_allowInstantiation = false;
			}

			return _instance;
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