package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.ChessboardGame;
import de.robinz.as3.pcc.chessboard.model.GameProxy;
import de.robinz.as3.pcc.chessboard.model.SaveGameProxy;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
import de.robinz.as3.pcc.chessboard.view.SaveGameDialogMediator;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * SaveGameCommand
 *
 * @author robin heinel
 */
public class SaveGameCommand extends SimpleCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		if ( n.getBody() == null ) {
			if ( this.gameProxy.getCurrentGame().moves.length == 0 ) {
				sendNotification( ApplicationFacade.INFO, "Keine Spielzüge vorhanden." );
				return;
			}
			this.showSaveGameDialog();
		}
		if ( n.getBody() is ChessboardGame ) {
			this.saveGame( n.getBody() as ChessboardGame );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function saveGame( cg : ChessboardGame ) : void {
		saveGameProxy.save( cg );
		sendNotification( ApplicationFacade.DISAPPEAR_PANEL_SAVE_GAME );
	}

	private function showSaveGameDialog() : void {
		if ( ! this.facade.hasMediator( SaveGameDialogMediator.NAME ) ) {
			this.facade.registerMediator( new SaveGameDialogMediator( appMediator.app ) );
		}

		var game : ChessboardGame = this.gameProxy.getCurrentGame();

		if ( game.name == null ) {
			game.name = this.saveGameProxy.getDefaultName();
		}
		game.dateStored = new Date();

		sendNotification( ApplicationFacade.SET_SAVE_GAME, game );
		sendNotification( ApplicationFacade.APPEAR_PANEL_SAVE_GAME );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get saveGameProxy() : SaveGameProxy {
		return this.facade.retrieveProxy( SaveGameProxy.NAME ) as SaveGameProxy;
	}

	private function get gameProxy() : GameProxy {
		return this.facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
	}

	private function get appMediator() : ApplicationMediator {
		return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
	}

	// End Getter / Setters
}
}