package de.robinz.as3.pcc.chessboard.library
{
	import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
	import de.robinz.as3.pcc.chessboard.library.pieces.Rook;

	public class PieceManager
	{
		public function PieceManager()
		{
		}

		public static function createByName( name : String ) : IPiece {
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