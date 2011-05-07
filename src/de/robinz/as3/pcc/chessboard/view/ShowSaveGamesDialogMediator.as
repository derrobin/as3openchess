package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.ChessboardGameCollection;
import de.robinz.as3.pcc.chessboard.view.views.game.ShowSaveGamesDialog;

import flash.display.DisplayObject;
import flash.events.Event;

import mx.containers.TitleWindow;
import mx.controls.List;
import mx.events.CloseEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * ShowSaveGamesDialogMediator
 *
 * @author robin heinel
 */
public class ShowSaveGamesDialogMediator extends DialogBaseMediator
{
	public static const NAME : String = "ShowSaveGamesDialogMediator";

	private var _view : ShowSaveGamesDialog;

	public function ShowSaveGamesDialogMediator( viewStage : DisplayObject ) {
		super( NAME, viewStage );
	}


	// Start Innerclass Methods

	private function appear() : ShowSaveGamesDialog {
		var view : TitleWindow = this.createDialog( "Load Game", 300, 300, ShowSaveGamesDialog, this.stage, true );

		view.addEventListener( CloseEvent.CLOSE, onPopupClose );
		view.addEventListener( ShowSaveGamesDialog.EVENT_LOAD_GAME, onLoadGame );

		this._view = view as ShowSaveGamesDialog;
		return this._view;
	}

	private function setGames( c : ChessboardGameCollection ) : void {
		var games : List = this._view.games;
		games.dataProvider = c.list();
		games.labelField = "name";
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.APPEAR_SAVE_GAMES,
			ApplicationFacade.DISAPPEAR_SAVE_GAMES,
			ApplicationFacade.SET_SAVE_GAMES
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.APPEAR_SAVE_GAMES:
				this.handleAppearSaveGames();
			break;
			case ApplicationFacade.DISAPPEAR_SAVE_GAMES:
				this.handleDisappearSaveGames();
			break;
			case ApplicationFacade.SET_SAVE_GAMES:
				this.handleSetSaveGames( n.getBody() as ChessboardGameCollection );
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearSaveGames() : void {
		this.appear();
	}

	private function handleDisappearSaveGames() : void {
		this.disappear();
	}

	private function handleSetSaveGames( games : ChessboardGameCollection ) : void {
		this.setGames( games );
	}

	// End Notification Handlers


	// Start Event Handlers

	protected function onPopupClose( e : CloseEvent ) : void {
		sendNotification( ApplicationFacade.DISAPPEAR_SAVE_GAMES );
		this.disappear();
	}

	private function onLoadGame( e : Event ) : void {
		var game : ChessboardGameVO = this.view.games.selectedItem as ChessboardGameVO;
		sendNotification( ApplicationFacade.LOAD_GAME, game );
	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get view() : ShowSaveGamesDialog {
		return this._view as ShowSaveGamesDialog;
	}

	// End Getter / Setters
}
}