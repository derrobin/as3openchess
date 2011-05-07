package de.robinz.as3.pcc.chessboard.controller.move.history
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.model.GameProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * MoveBackwardCommand
 *
 * @author robin heinel
 */
public class MoveBackwardCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		this.moveBack();
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function moveBack() : void {
		var moveBack : ChessboardMove = this.gameProxy.moveBack();

		if ( moveBack == null ) {
			// clear move history selected entry
			sendNotification( ApplicationFacade.SELECT_MOVE_HISTORY_ENTRY );
			// no move to going back
			return;
		}

		// move piece back
		var m : ChessboardMove = new ChessboardMove();
		m.fromPosition = moveBack.toPosition;
		m.toPosition = moveBack.fromPosition;
		m.piece = moveBack.piece;
		m.game = moveBack.game;
		m.isMoveBack = true;

		sendNotification( ApplicationFacade.MOVE, m );

		// restore beaten piece
		// remove beaten piece from taken pieces panel
		if ( moveBack.beatenPiece != null ) {
			gameProxy.setPiece( moveBack.beatenPiece.getName(), m.fromPosition.toString(), moveBack.beatenPiece.isWhite );
			sendNotification( ApplicationFacade.RESTORE_PIECE, moveBack.beatenPiece );
		}

		//
		sendNotification( ApplicationFacade.MOVE_BACKWARD_SUCCEED );
		sendNotification( ApplicationFacade.SELECT_MOVE_HISTORY_ENTRY, moveBack );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get gameProxy() : GameProxy {
		return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
	}

	// End Getter / Setters





}
}