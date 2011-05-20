package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;

import org.puremvc.as3.interfaces.INotification;

/**
 * GetCurrentGameCommand
 *
 * @author robin heinel
 */
public class GetCurrentGameCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		sendNotification( ApplicationFacade.SET_CURRENT_GAME, this.gameProxy.getCurrentGame() );
	}

	// End SimpleCommand overrides


	// Start Getter / Setters

	// End Getter / Setters
}
}