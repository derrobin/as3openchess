package de.robinz.as3.pcc.chessboard.view
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.view.views.ChessboardMoveHistory;
	import de.robinz.as3.pcc.chessboard.view.views.moveHistory.ChessboardMoveEntry;

	import flash.display.DisplayObject;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * UI Control for Info Panel - Move History
	 *
	 * @author robin heinel
	 */
	public class MoveHistoryMediator extends Mediator
	{
		public static const NAME : String = "MoveHistoryMediator";

		public function MoveHistoryMediator( m : ChessboardMoveHistory ) {
			super( NAME, m );
		}

		// Start Mediator overrides ( Notification Delegates excluded, see below )

		// End Mediator overrides ( Notification Delegates excluded, see below )


		// Start Innerclass Methods

		private function removeLastEntry() : void {
			if ( this.view.moveList.numChildren == 0 ) {
				return;
			}
			var d : DisplayObject = this.view.moveList.getChildAt( 0 );
			this.view.moveList.removeChild( d );
		}

		private function reset() : void {
			this.view.moveList.removeAllChildren();
		}

		private function add( m : ChessboardMove ) : void {
			var me : ChessboardMoveEntry = new ChessboardMoveEntry();
			me.initialize();

			me.moveNumber.text = m.game.currentMove + ".";
			var divider : String = m.beatenPiece == null ? "-" : "x";
			var notationChar : String = m.piece.getName() == Pawn.NAME ? "" : m.piece.notationChar;
			me.moveDescription.text = notationChar + m.fromPosition.toString() + divider + m.toPosition.toString();

			view.moveList.addChildAt( me, 0 );
		}

		// End Innerclass Methods


		// Start Notification Delegates

		public override function listNotificationInterests() : Array {
			return [
				ApplicationFacade.MOVE_BACKWARD_SUCCEED,
				ApplicationFacade.NEW_GAME,
				ApplicationFacade.MOVE
			];
		}

		public override function handleNotification( n : INotification ) : void {
			switch( n.getName() ) {
				case ApplicationFacade.MOVE_BACKWARD_SUCCEED:
					this.handleMoveBackwardSucceed();
				break;
				case ApplicationFacade.NEW_GAME:
					this.handleNewGame();
				break;
				case ApplicationFacade.MOVE:
					this.handleMove( n.getBody() as ChessboardMove );
				break;
			}
		}

		// End Notification Delegates


		// Start Notification Handlers

		private function handleMoveBackwardSucceed() : void {
			this.removeLastEntry();
		}

		private function handleNewGame() : void {
			this.reset();
		}

		private function handleMove( move : ChessboardMove ) : void {
			if ( move.isMoveBack ) {
				return;
			}

			this.add( move );
		}

		// End Notification Handlers


		// Start Event Handlers

		// End Event Handlers


		// Start Getter / Setters

		protected function get view() : ChessboardMoveHistory {
			return this.viewComponent as ChessboardMoveHistory;
		}

		// End Getter / Setters
	}
}