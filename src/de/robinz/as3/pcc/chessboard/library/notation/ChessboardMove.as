package de.robinz.as3.pcc.chessboard.library.notation
{
	import de.robinz.as3.pcc.chessboard.library.ChessboardGame;
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;

	/**
	 * represents a move of a piece on chessboard
	 *
	 * @author robin heinel
	 */
	// TODO: move to VO
	public class ChessboardMove
	{
		public var piece : IPiece;
		public var fromPosition : Notation;
		public var toPosition : Notation;

		public var beatenPiece : IPiece;
		public var game : ChessboardGame;

		public var isMoveBack : Boolean = false;
		public var isMoveForward : Boolean = false;

		public function ChessboardMove()
		{
		}

	}
}