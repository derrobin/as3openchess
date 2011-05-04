package de.robinz.as3.pcc.chessboard.controller.move.history
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.model.GameProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * MoveStartCommand
 *
 * @author robin heinel
 */
public class MoveStartCommand extends SimpleCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
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

	private function get gameProxy() : GameProxy {
		return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
	}

	// End Getter / Setters





}
}