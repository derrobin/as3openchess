package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.model.GameProxy;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

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

	private function get gameProxy() : GameProxy {
		return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
	}

	private function get appMediator() : ApplicationMediator {
		return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
	}

	// End Getter / Setters
}
}