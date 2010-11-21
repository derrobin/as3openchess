package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.view.views.ChessboardTakenPieces;

	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * UI Control for Info Panel - Taken Pieces
	 *
	 * @author Robin Heinel
	 *
	 */
	public class TakenPiecesMediator extends Mediator
	{
		public static const NAME : String = "TakenPiecesMediator";

		public function TakenPiecesMediator( m : ChessboardTakenPieces ) {
			super( NAME, m );
		}

		protected function get view() : ChessboardTakenPieces {
			return this.viewComponent as ChessboardTakenPieces;
		}
	}
}