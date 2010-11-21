package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.view.views.ChessboardMoveHistory;

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

		public function MoveHistoryMediator( m : ChessboardMoveHistory ) {
			super( NAME, m );
		}

		protected function get view() : ChessboardMoveHistory {
			return this.viewComponent as ChessboardMoveHistory;
		}
	}
}