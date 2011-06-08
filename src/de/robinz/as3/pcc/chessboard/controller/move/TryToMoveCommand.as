package de.robinz.as3.pcc.chessboard.controller.move
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.library.pieces.King;

import org.puremvc.as3.interfaces.INotification;

/**
 * TryToMoveCommand
 *
 * @author robin heinel
 */
public class TryToMoveCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() is ChessboardMove ) {
			this.tryToMove( n.getBody() as ChessboardMove );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function tryToMove( m : ChessboardMove ) : void {
		var movePiece : IPiece = m.piece;

		// ignore
		if ( m.fromField.equals( m.toField ) ) {
			return;
		}

		if ( m.beatenPiece && ( m.beatenPiece.getName() == King.NAME ) ) {
			sendNotification( ApplicationFacade.REJECT_MOVE, m );
			return;
		}

		if( m.validMoves == null || m.validMoves.hasNotationToPosition( m.toField.toString() ) ) {
			if ( m.beatenPiece == null ) {
				sendNotification( ApplicationFacade.MOVE, m );
				return;
			}

			if ( movePiece.isWhite != m.beatenPiece.isWhite ) {
				sendNotification( ApplicationFacade.REMOVE_PIECE, m.toField );
				sendNotification( ApplicationFacade.MOVE, m );
			}

			return;
		}

		sendNotification( ApplicationFacade.REJECT_MOVE, m );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}