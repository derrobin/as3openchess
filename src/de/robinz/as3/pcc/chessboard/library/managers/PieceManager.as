package de.robinz.as3.pcc.chessboard.library.managers
{
	import de.robinz.as3.pcc.chessboard.library.IPiece;
	import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
	import de.robinz.as3.pcc.chessboard.library.pieces.Rook;

	public class PieceManager
	{
		private static var _instance : PieceManager;
		private static var _allowInstantiation : Boolean;

		public function PieceManager() {
			if ( !_allowInstantiation ) {
				throw new Error( "Error: Instantiation failed: Use static::getInstance() instead of new." );
			}
		}

		public static function getInstance() : PieceManager {
			if ( _instance == null ) {
				_allowInstantiation = true;
				_instance = new PieceManager();
				_allowInstantiation = false;
			}

			return _instance;
		}

		public function createByName( name : String ) : IPiece {
			switch( name ) {
				case Pawn.NAME:		return new Pawn();
				case Rook.NAME:		return new Rook();
				case Bishop.NAME:	return new Bishop();
				case Knight.NAME:	return new Knight();
				case Queen.NAME:	return new Queen();
				case King.NAME:		return new King();
			};

			throw new Error( "No Piece not Found!" );
		}

	}
}