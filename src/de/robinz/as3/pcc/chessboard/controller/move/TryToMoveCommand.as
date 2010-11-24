package de.robinz.as3.pcc.chessboard.controller.move
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.view.GameMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * TryToMoveCommand
	 *
	 * @author Robin Heinel
	 *
	 */
	public class TryToMoveCommand extends SimpleCommand
	{
		public override function execute( n : INotification ) : void {
			if ( n.getBody() is ChessboardMove ) {
				this.tryToMove( n.getBody() as ChessboardMove );
			}
		}

		private function tryToMove( m : ChessboardMove ) : void {
			var movePiece : IPiece = m.piece;
			var targetPiece : IPiece = gm.cb.getPieceAt( m.toPosition );

			// ignore
			if ( m.fromPosition.equals( m.toPosition ) ) {
				return;
			}

			// move
			if ( targetPiece == null ) {
				sendNotification( ApplicationFacade.MOVE, m );
				return;
			}

			// rejects
			if ( movePiece.isWhite && targetPiece.isWhite ) {
				sendNotification( ApplicationFacade.REJECT_MOVE, m );
				return;
			}
			if ( targetPiece.getName() == King.NAME ) {
				sendNotification( ApplicationFacade.REJECT_MOVE, m );
				return;
			}

			// beat and move
			if ( movePiece.isWhite != targetPiece.isWhite ) {
				m.beat = true;
				sendNotification( ApplicationFacade.BEAT_PIECE_FROM_NOTATION, m.toPosition );
				sendNotification( ApplicationFacade.MOVE, m );
			}

		}

		private function get gm() : GameMediator {
			return this.facade.retrieveMediator( GameMediator.NAME ) as GameMediator;
		}

	}
}