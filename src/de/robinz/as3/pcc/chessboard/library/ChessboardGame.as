package de.robinz.as3.pcc.chessboard.library
{
	import de.robinz.as3.pcc.chessboard.library.ChessboardMoveCollection;

	/**
	 * ChessboardGame
	 *
	 * @author robin heinel
	 */
	// TODO: move to VO
	public class ChessboardGame
	{
		public var moves : ChessboardMoveCollection;
		public var name : String;
		public var dateStored : Date;
		public var currentMove : int;
		public var isLastMove : Boolean = true;

		private var _dateStart : Date;

		public function ChessboardGame() {
			this.moves = new ChessboardMoveCollection();
			this._dateStart = new Date();
		}

		public function get dateStart() : Date {
			return this._dateStart;
		}

	}
}