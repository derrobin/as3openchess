package de.robinz.as3.pcc.chessboard.controller.move.history
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;

import org.puremvc.as3.interfaces.INotification;

/**
 * MoveStartCommand
 *
 * @author robin heinel
 */
public class MoveStartCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		this.moveStart();
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function moveStart() : void {
		// move backward until no moves left
		var i : int = 0;
		var currentMove : int = this.gameProxy.getCurrentGame().currentMove;
		for( i; i <= currentMove; i++ ) {
			sendNotification( ApplicationFacade.MOVE_BACKWARD );
		}
	}

	// End Innerclass Methods


	// Start Getter / Setters

	// End Getter / Setters





}
}