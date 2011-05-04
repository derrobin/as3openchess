package de.robinz.as3.pcc.chessboard.controller
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;

import de.robinz.as3.pcc.chessboard.model.FontProxy;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * Application initialization
 *
 * @author robin heinel
 */
public class InitCommand extends SimpleCommand
{
	// Start SimpleCommand overrides

	public override function execute( note : INotification ) : void {
		sendNotification( ApplicationFacade.CHANGE_PIECE_SETTINGS, this.fontProxy.getPieceSettings() );
		sendNotification( ApplicationFacade.NEW_GAME );
		sendNotification( ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL );
		sendNotification( ApplicationFacade.APPEAR_GAME_ACTIONS_PANEL );
		sendNotification( ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	// End Innerclass Methods


	// Start Getter / Setters

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}