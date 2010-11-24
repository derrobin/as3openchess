package de.robinz.as3.pcc.chessboard.library.notation
{
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;

	public class ChessboardMove
	{
		public var piece : IPiece;
		public var fromPosition : Notation;
		public var toPosition : Notation;
		public var beat : Boolean = false;

		public function ChessboardMove()
		{
		}

	}
}