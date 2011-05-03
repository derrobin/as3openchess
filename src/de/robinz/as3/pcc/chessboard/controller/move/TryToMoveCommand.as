package de.robinz.as3.pcc.chessboard.controller.move
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.model.GameProxy;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * TryToMoveCommand
	 *
	 * @author robin heinel
	 */
	public class TryToMoveCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( n.getBody() is ChessboardMove ) {
				this.tryToMove( n.getBody() as ChessboardMove );
			}
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		private function tryToMove( m : ChessboardMove ) : void {
			var movePiece : IPiece = m.piece;

			// ignore
			if ( m.fromPosition.equals( m.toPosition ) ) {
				return;
			}

			if ( m.beatenPiece && ( m.beatenPiece.getName() == King.NAME ) ) {
				sendNotification( ApplicationFacade.REJECT_MOVE, m );
				return;
			}

			if( movePiece.isMoveValide( m ) ) {
				if ( m.beatenPiece == null ) {
					sendNotification( ApplicationFacade.MOVE, m );
					return;
				}

				if ( movePiece.isWhite != m.beatenPiece.isWhite ) {
					sendNotification( ApplicationFacade.REMOVE_PIECE, m );
					sendNotification( ApplicationFacade.MOVE, m );
				}

				return;
			}

			sendNotification( ApplicationFacade.REJECT_MOVE, m );
		}

		// End Innerclass Methods


		// Start Getter / Setters

		private function get gameProxy() : GameProxy {
			return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}

		// End Getter / Setters
	}
}