package de.robinz.as3.pcc.chessboard.controller.move
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;
import de.robinz.as3.pcc.chessboard.model.GameProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * MoveCommand
 *
 * @author robin heinel
 */
public class MoveCommand extends SimpleCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		if ( n.getBody() is ChessboardMove ) {
			this.move( n.getBody() as ChessboardMove );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function move( m : ChessboardMove ) : void {
		if ( m.isMoveForward == false ) {
			this.gameProxy.move( m );
		}

		// give a reference to the corresponding game
		// now currentMove is right
		m.game = gameProxy.getCurrentGame();

		if ( m.game.isLastMove ) {
			sendNotification( ApplicationFacade.UNLOCK_BOARD );
		} else {
			sendNotification( ApplicationFacade.LOCK_BOARD );
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