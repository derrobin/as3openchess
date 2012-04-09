package de.robinz.as3.pcc.chessboard.controller.move.history
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

import org.puremvc.as3.interfaces.INotification;

/**
 * MoveForwardCommand
 *
 * @author robin heinel
 */
public class MoveForwardCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

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
		var m : ChessboardMove = moveForward.clone();
		m.isMoveForward = true;

		sendNotification( ApplicationFacade.TRY_TO_MOVE, m );

		sendNotification( ApplicationFacade.MOVE_FORWARD_SUCCEED );
		sendNotification( ApplicationFacade.SELECT_MOVE_HISTORY_ENTRY, m );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters





}
}