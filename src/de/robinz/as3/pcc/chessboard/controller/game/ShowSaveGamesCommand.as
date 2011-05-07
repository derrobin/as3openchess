package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.model.SaveGameProxy;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
import de.robinz.as3.pcc.chessboard.view.ShowSaveGamesDialogMediator;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * ShowSaveGamesCommand
 *
 * @author robin heinel
 */
public class ShowSaveGamesCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		this.showSaveGameDialog();
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function showSaveGameDialog() : void {
		if ( ! this.facade.hasMediator( ShowSaveGamesDialogMediator.NAME ) ) {
			this.facade.registerMediator( new ShowSaveGamesDialogMediator( appMediator.app ) );
		}

		sendNotification( ApplicationFacade.APPEAR_SAVE_GAMES );
		sendNotification( ApplicationFacade.SET_SAVE_GAMES, this.saveGameProxy.getGames() );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get saveGameProxy() : SaveGameProxy {
		return this.facade.retrieveProxy( SaveGameProxy.NAME ) as SaveGameProxy;
	}

	// End Getter / Setters
}
}