package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.view.views.ChessboardMoveHistory;
	import de.robinz.as3.pcc.chessboard.view.views.moveHistory.ChessboardMoveEntry;

	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * UI Control for Info Panel - Move History
	 *
	 * @author Robin Heinel
	 *
	 */
	public class MoveHistoryMediator extends Mediator
	{
		public static const NAME : String = "MoveHistoryMediator";
		private var count : int = 0;

		public function MoveHistoryMediator( m : ChessboardMoveHistory ) {
			super( NAME, m );
		}

		public function reset() : void {
			this.count = 0;
			this.view.moveList.removeAllChildren();
		}

		public function add( m : ChessboardMove ) : void {
			var me : ChessboardMoveEntry = new ChessboardMoveEntry();
			me.initialize();

			this.count++;

			me.moveNumber.text = this.count + ".";
			var divider : String = m.beat ? "x" : "-";
			var notationChar : String = m.piece.getName() == Pawn.NAME ? "" : m.piece.notationChar;
			me.moveDescription.text = notationChar + m.fromPosition.toString() + divider + m.toPosition.toString();

			view.moveList.addChildAt( me, 0 );
		}

		protected function get view() : ChessboardMoveHistory {
			return this.viewComponent as ChessboardMoveHistory;
		}
	}
}