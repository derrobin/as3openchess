package de.robinz.as3.pcc.chessboard.controller.move.history
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

import org.puremvc.as3.interfaces.INotification;

/**
 * jumps directly to a move by move number
 *
 * @author robin heinel
 */
public class MoveJumpCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		this.jump( n.getBody() as ChessboardMove );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function jump( move : ChessboardMove ) : void {
		// move backward until no moves left
		var i : int = 0;

		var moveIndex : int = this.gameProxy.moveIndex( move ) + 1;
		var currentMove : int = this.gameProxy.getCurrentGame().currentMove;

		var jumps : int = currentMove - moveIndex;

		if ( jumps == 0 ) {
			return;
		}

		if ( jumps > 0 ) {
			this.resendNotification( ApplicationFacade.MOVE_BACKWARD, jumps );
		} else {
			this.resendNotification( ApplicationFacade.MOVE_FORWARD, -jumps );
		}

		sendNotification( ApplicationFacade.SELECT_MOVE_HISTORY_ENTRY, move );
	}

	private function resendNotification( notification : String, amount : int ) : void {
		while( amount > 0 ) {
			sendNotification( notification );
			amount--;
		}
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters
}
}