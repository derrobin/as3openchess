package de.robinz.as3.pcc.chessboard.view
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.library.vo.ColorSettingsVO;
import de.robinz.as3.pcc.chessboard.view.views.ChessboardMenubar;

import mx.events.MenuEvent;

import org.puremvc.as3.interfaces.INotification;

/**
 * UI Control for Application Menu Bar
 *
 * @author robin heinel
 */
public class MenuBarMediator extends BaseMediator
{
	public static const NAME : String = "MenubarMediator";

	public function MenuBarMediator( m : ChessboardMenubar ) {
		super( NAME, m );

		this.view.menuBar.addEventListener( MenuEvent.CHANGE, onMenuBarChange );
	}


	// Start Innerclass Methods

	private function menuSelect( value : String ) : void {
		switch( value ) {
			case ChessboardMenubar.MENU_EXPORT_FEN:
				sendNotification( ApplicationFacade.EXPORT_FEN );
			break;
			case ChessboardMenubar.MENU_ENTRY_MEW_GAME:
				sendNotification( ApplicationFacade.NEW_GAME );
			break;
			case ChessboardMenubar.MENU_ENTRY_SAVE_GAME:
				sendNotification( ApplicationFacade.SAVE_GAME );
			break;
			case ChessboardMenubar.MENU_ENTRY_LOAD_GAME:
				sendNotification( ApplicationFacade.SHOW_SAVE_GAMES );
			break;
			case ChessboardMenubar.MENU_ENTRY_PANEL_MOVE_HISTORY:
				sendNotification( ApplicationFacade.TOGGLE_MOVE_HISTORY_PANEL );
			break;
			case ChessboardMenubar.MENU_ENTRY_PANEL_TAKEN_PIECES:
				sendNotification( ApplicationFacade.TOGGLE_TAKEN_PIECES_PANEL );
			break;
			case ChessboardMenubar.MENU_ENTRY_SET_TEST_PIECES:
				sendNotification( ApplicationFacade.SHOW_ALL_FONT_KEYS_ON_CHESSBOARD );
			break;
			case ChessboardMenubar.MENU_ENTRY_PIECE_SETTINGS:
				sendNotification( ApplicationFacade.APPEAR_PIECE_SETTINGS );
			break;
			case ChessboardMenubar.MENU_ENTRY_COLOR_SETTINGS:
				sendNotification( ApplicationFacade.APPEAR_COLOR_SETTINGS );
			break;
			case ChessboardMenubar.MENU_ENTRY_REVERT_MOVES:
				sendNotification( ApplicationFacade.APPEAR_MOVE_HISTORY_MODIFIER );
			break;
			case ChessboardMenubar.MENU_ENTRY_PANEL_GAME_ACTIONS:
				sendNotification( ApplicationFacade.TOGGLE_GAME_ACTIONS_PANEL );
			break;
		}
	}

	// End Innerclass Methods


	// Start Notification Delegates

	public override function listNotificationInterests() : Array {
		return [
			ApplicationFacade.SET_COLOR_SETTINGS
		];
	}

	public override function handleNotification( n : INotification ) : void {
		switch( n.getName() ) {
			case ApplicationFacade.SET_COLOR_SETTINGS:
				this.handleSetColors( n.getBody() as ColorSettingsVO );
			break;
		}
	}

	// End Notification Delegates


	// Start Notification Handlers

	private function handleSetColors( colors : ColorSettingsVO ) : void {
		this.view.setStyle( "backgroundColor", colors.backgroundMain );
	}

	// End Notification Handlers


	// Start Event Handlers

	private function onMenuBarChange( e : MenuEvent ) : void {
		var selectedValue : String = String( e.item.@data );
		this.menuSelect( selectedValue );
	}

	// End Event Handlers


	// Start Getter / Setters

	protected function get view() : ChessboardMenubar {
		return this.viewComponent as ChessboardMenubar;
	}

	// End Getter / Setters
}
}