package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.vo.SaveGameDialogVO;
import de.robinz.as3.pcc.chessboard.view.views.game.SaveGameDialog;

import flash.display.DisplayObject;
import flash.events.Event;

import mx.containers.TitleWindow;
import mx.events.CloseEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * SaveGameDialogMediator
 *
 * @author robin heinel
 */
public class SaveGameDialogMediator extends DialogBaseMediator
{
	public static const NAME : String = "SaveGameDialogMediator";

	private var _game : ChessboardGameVO;
	private var _data : SaveGameDialogVO;

	public function SaveGameDialogMediator( viewStage : DisplayObject ) {
		super( NAME, viewStage );
		this._data = new SaveGameDialogVO();
	}


	// Start Innerclass Methods

	private function appear() : void {
		var view : TitleWindow = this.createDialog( "Save Game", 400, 230, SaveGameDialog, this.stage, true );

		view.addEventListener( CloseEvent.CLOSE, onPopupClose );
		view.addEventListener( SaveGameDialog.EVENT_SAVE_GAME, onSaveGame );

		this._dialog = view as SaveGameDialog;
		this.flushData();
	}

	private function flushData() : void {
		if ( this.popup == null ) {
			return;
		}

		this.popup.gameName.text = this._data.name;
		this.popup.gameMoves.text = this._data.moves;
		this.popup.gameStartedAt.text = this._data.dateStart.toUTCString();
		this.popup.gameStoredAt.text = this._data.dateStored.toUTCString();
	}

	private function setGame( game : ChessboardGameVO ) : void {
		this._game = game;

		this._data.name = String( game.name );
		this._data.moves = String( game.moves.length );
		this._data.dateStart = game.dateStart;
		this._data.dateStored = game.dateStored;

		this.flushData();
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.APPEAR_PANEL_SAVE_GAME,
			ApplicationFacade.DISAPPEAR_PANEL_SAVE_GAME,
			ApplicationFacade.SET_SAVE_GAME
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.APPEAR_PANEL_SAVE_GAME:
				this.handleAppearPanelSaveGame();
			break;
			case ApplicationFacade.DISAPPEAR_PANEL_SAVE_GAME:
				this.handleDisappearPanelSaveGame();
			break;
			case ApplicationFacade.SET_SAVE_GAME:
				this.handleSetSaveGame( n.getBody() as ChessboardGameVO );
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleAppearPanelSaveGame() : void {
		this.appear();
	}

	private function handleDisappearPanelSaveGame() : void {
		this.disappear();
		this.facade.removeMediator( NAME );
	}

	private function handleSetSaveGame( game : ChessboardGameVO ) : void {
		this.setGame( game );
	}

	// End Notification Handlers


	// Start Event Handlers

	protected function onPopupClose( e : CloseEvent ) : void {
		sendNotification( ApplicationFacade.DISAPPEAR_PANEL_SAVE_GAME );
		this.disappear();
	}

	private function onSaveGame( e : Event ) : void {
		if ( this._game == null ) {
			sendNotification( ApplicationFacade.ERROR, new Error( "No Game present!" ) );
			return;
		}

		// TODO: optional: gamename validation
		this._game.name = this.popup.gameName.text;
		this._game.dateStored = new Date();

		sendNotification( ApplicationFacade.SAVE_GAME, this._game );
	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get popup() : SaveGameDialog {
		return this._dialog as SaveGameDialog;
	}

	// End Getter / Setters

}
}