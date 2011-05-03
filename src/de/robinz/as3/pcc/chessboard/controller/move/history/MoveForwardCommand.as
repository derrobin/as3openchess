package de.robinz.as3.pcc.chessboard.controller.move.history
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.model.GameProxy;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * MoveForwardCommand
	 *
	 * @author robin heinel
	 */
	public class MoveForwardCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			this.forward();
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		private function forward() : void {
			var moveForward : ChessboardMove = this.gameProxy.moveForward();

			if ( moveForward == null ) {
				// no move to going forward
				return;
			}

			// move piece forward
			var m : ChessboardMove = new ChessboardMove();
			m.beatenPiece = moveForward.beatenPiece;
			m.fromPosition = moveForward.fromPosition;
			m.toPosition = moveForward.toPosition;
			m.piece = moveForward.piece;
			m.game = moveForward.game;
			m.isMoveForward = true;

			sendNotification( ApplicationFacade.TRY_TO_MOVE, m );

			sendNotification( ApplicationFacade.MOVE_FORWARD_SUCCEED );
			sendNotification( ApplicationFacade.SELECT_MOVE_HISTORY_ENTRY, m );
		}

		// End Innerclass Methods


		// Start Getter / Setters

		private function get gameProxy() : GameProxy {
			return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}

		// End Getter / Setters





	}
}