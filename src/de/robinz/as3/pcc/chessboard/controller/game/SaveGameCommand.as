package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
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
public class SaveGameCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() == null ) {
			if ( this.gameProxy.getCurrentGame().moves.length == 0 ) {
				sendNotification( ApplicationFacade.INFO, "Keine Spielzüge vorhanden." );
				return;
			}
			this.showSaveGameDialog();
		}
		if ( n.getBody() is ChessboardGameVO ) {
			this.saveGame( n.getBody() as ChessboardGameVO );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function saveGame( cg : ChessboardGameVO ) : void {
		saveGameProxy.save( cg );
		sendNotification( ApplicationFacade.DISAPPEAR_PANEL_SAVE_GAME );
	}

	private function showSaveGameDialog() : void {
		if ( ! this.facade.hasMediator( SaveGameDialogMediator.NAME ) ) {
			this.facade.registerMediator( new SaveGameDialogMediator( appMediator.app ) );
		}

		var game : ChessboardGameVO = this.gameProxy.getCurrentGame();

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

	// End Getter / Setters
}
}