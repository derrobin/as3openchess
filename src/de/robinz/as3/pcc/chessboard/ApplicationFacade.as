package de.robinz.as3.pcc.chessboard
{
import de.robinz.as3.pcc.chessboard.controller.ErrorCommand;
import de.robinz.as3.pcc.chessboard.controller.InfoCommand;
import de.robinz.as3.pcc.chessboard.controller.ShowAllFontKeysOnChessboardCommand;
import de.robinz.as3.pcc.chessboard.controller.StartupCommand;
import de.robinz.as3.pcc.chessboard.controller.game.GetCurrentGameCommand;
import de.robinz.as3.pcc.chessboard.controller.game.LoadGameCommand;
import de.robinz.as3.pcc.chessboard.controller.game.NewGameCommand;
import de.robinz.as3.pcc.chessboard.controller.game.SaveGameCommand;
import de.robinz.as3.pcc.chessboard.controller.game.ShowSaveGamesCommand;
import de.robinz.as3.pcc.chessboard.controller.move.MoveCommand;
import de.robinz.as3.pcc.chessboard.controller.move.TryToMoveCommand;
import de.robinz.as3.pcc.chessboard.controller.move.history.MoveBackwardCommand;
import de.robinz.as3.pcc.chessboard.controller.move.history.MoveEndCommand;
import de.robinz.as3.pcc.chessboard.controller.move.history.MoveForwardCommand;
import de.robinz.as3.pcc.chessboard.controller.move.history.MoveJumpCommand;
import de.robinz.as3.pcc.chessboard.controller.move.history.MoveStartCommand;
import de.robinz.as3.pcc.chessboard.controller.piece.RemovePieceCommand;
import de.robinz.as3.pcc.chessboard.controller.ui.ChangePieceSettingsCommand;
import de.robinz.as3.pcc.chessboard.controller.ui.DialogActionCommand;
import de.robinz.as3.pcc.chessboard.controller.ui.PanelActionCommand;

import org.puremvc.as3.patterns.facade.Facade;

/**
 * ApplicationFacade
 *
 * @author robin heinel
 */
public class ApplicationFacade extends Facade
{
	// for global application
	public static const STARTUP : String = "startup";
	public static const ERROR : String = "error";
	public static const INFO : String = "info";

	// TODO: rename it to set piece settings
	public static const SET_FONT_SETTINGS : String = "setFontSettings";

	public static const TRY_TO_MOVE : String = "tryToMove";
	public static const REJECT_MOVE : String = "rejectMove";
	public static const GET_MOVES : String = "getMoves";
	public static const MOVE : String = "move";

	// move history
	public static const MOVE_START : String = "moveStart";
	public static const MOVE_END : String = "moveEnd";
	public static const MOVE_FORWARD : String = "moveForward";
	public static const MOVE_FORWARD_SUCCEED : String = "moveForwardSucceed";
	public static const MOVE_BACKWARD : String = "moveBackward";
	public static const MOVE_BACKWARD_SUCCEED : String = "moveBackwardSucceed";
	public static const MOVE_JUMP : String = "moveJump";

	public static const LOCK_BOARD : String = "lookBoard";
	public static const UNLOCK_BOARD : String = "unlockBoard";

	public static const REMOVE_PIECE : String = "removePiece";
	public static const PIECE_REMOVED : String = "pieceRemoved";

	public static const SET_PIECE : String = "setPiece";
	public static const RESTORE_PIECE : String = "restorePiece";
	public static const REMOVE_ALL_PIECES : String = "removeAllPieces";

	public static const GAME_STARTED : String = "gameStarted";
	public static const NEW_GAME : String = "newGame";
	public static const SAVE_GAME : String = "saveGame";
	public static const SHOW_SAVE_GAMES : String = "showSaveGames";
	public static const LOAD_GAME : String = "loadGame";
	public static const GET_CURRENT_GAME : String = "getCurrentGame";
	public static const SET_CURRENT_GAME : String = "setCurrentGame";

	public static const SELECT_MOVE_HISTORY_ENTRY : String = "selectMoveHistoryEntry";

	// panel and dialog actions
	public static const APPEAR_MOVE_HISTORY_PANEL : String = "appearMoveHistoryPanel";
	public static const APPEAR_TAKEN_PIECES_PANEL : String = "appearTakenPiecesPanel";
	public static const APPEAR_PIECE_SETTINGS : String = "appearPieceSettings";
	public static const APPEAR_MOVE_HISTORY_MODIFIER : String = "appearMoveHistoryModifier";
	public static const APPEAR_GAME_ACTIONS_PANEL : String = "appearGameActionsPanel";

	public static const DISAPPEAR_MOVE_HISTORY_PANEL : String = "disappearMoveHistoryPanel";
	public static const DISAPPEAR_TAKEN_PIECES_PANEL : String = "disappearTakenPiecesPanel";
	public static const DISAPPEAR_PIECE_SETTINGS : String = "disappearPieceSettings";
	public static const DISAPPEAR_MOVE_HISTORY_MODIFIER : String = "disappearMoveHistoryModifier";
	public static const DISAPPEAR_GAME_ACTIONS_PANEL : String = "disappearGameActionsPanel";

	public static const TOGGLE_GAME_ACTIONS_PANEL : String = "toggleGameActionsPanel";
	public static const TOGGLE_TAKEN_PIECES_PANEL : String = "toolgeTakenPiecesPanel";
	public static const TOGGLE_MOVE_HISTORY_PANEL : String = "toggleMoveHistoryPanel";

	// Save game dialog ( this is not handled by dialog action command )
	public static const APPEAR_PANEL_SAVE_GAME : String = "appearPanelSaveGame";
	public static const DISAPPEAR_PANEL_SAVE_GAME : String = "disappearPanelSaveGame";
	public static const SET_SAVE_GAME : String = "setSaveGame";
	public static const SET_SAVE_GAMES : String = "setSaveGames";
	public static const DISAPPEAR_SAVE_GAMES : String = "disappearSaveGames";
	public static const APPEAR_SAVE_GAMES : String = "appearSaveGames";

	public static const SHOW_ALL_FONT_KEYS_ON_CHESSBOARD : String = "showAllFontKeysOnChessboard";

	public static const ENABLE_BOARD_INSPECT_PIECE_MODE : String = "enableBoardInspectPieceMode";
	public static const DISABLE_BOARD_INSPECT_PIECE_MODE : String = "disableBoardInspectPieceMode";
	public static const CHANGE_PIECE_SETTINGS : String = "changePieceSettings";

	public static const FIELD_HINT : String = "fieldHint";
	public static const REMOVE_ALL_FIELD_HINTS : String = "removeAllFieldHints";

	public static const SHOW_PIECE_MOVE_HINTS : String = "showPieceMoveHints";

	public static function getInstance() : ApplicationFacade {
		if ( ! instance ) {
			instance = new ApplicationFacade();
		}
		return instance as ApplicationFacade;
	}

	protected override function initializeController() : void {
		super.initializeController();

		registerCommand( STARTUP, StartupCommand );
		registerCommand( ERROR, ErrorCommand );
		registerCommand( INFO, InfoCommand );

		registerCommand( TRY_TO_MOVE, TryToMoveCommand );
		registerCommand( MOVE, MoveCommand );

		registerCommand( NEW_GAME, NewGameCommand );
		registerCommand( SHOW_SAVE_GAMES, ShowSaveGamesCommand );
		registerCommand( SAVE_GAME, SaveGameCommand );
		registerCommand( LOAD_GAME, LoadGameCommand );
		registerCommand( GET_CURRENT_GAME, GetCurrentGameCommand );

		registerCommand( APPEAR_MOVE_HISTORY_PANEL, PanelActionCommand );
		registerCommand( APPEAR_TAKEN_PIECES_PANEL, PanelActionCommand );
		registerCommand( APPEAR_GAME_ACTIONS_PANEL, PanelActionCommand );
		registerCommand( APPEAR_PIECE_SETTINGS, DialogActionCommand );
		registerCommand( APPEAR_MOVE_HISTORY_MODIFIER, DialogActionCommand );

		registerCommand( DISAPPEAR_MOVE_HISTORY_PANEL, PanelActionCommand );
		registerCommand( DISAPPEAR_TAKEN_PIECES_PANEL, PanelActionCommand );
		registerCommand( DISAPPEAR_GAME_ACTIONS_PANEL, PanelActionCommand );
		registerCommand( DISAPPEAR_PIECE_SETTINGS, DialogActionCommand );
		registerCommand( DISAPPEAR_MOVE_HISTORY_MODIFIER, DialogActionCommand );

		registerCommand( TOGGLE_MOVE_HISTORY_PANEL, PanelActionCommand );
		registerCommand( TOGGLE_TAKEN_PIECES_PANEL, PanelActionCommand );
		registerCommand( TOGGLE_GAME_ACTIONS_PANEL, PanelActionCommand );

		registerCommand( MOVE_START, MoveStartCommand );
		registerCommand( MOVE_END, MoveEndCommand );
		registerCommand( MOVE_FORWARD, MoveForwardCommand );
		registerCommand( MOVE_BACKWARD, MoveBackwardCommand );
		registerCommand( MOVE_JUMP, MoveJumpCommand );

		registerCommand( SHOW_ALL_FONT_KEYS_ON_CHESSBOARD, ShowAllFontKeysOnChessboardCommand );

		registerCommand( CHANGE_PIECE_SETTINGS, ChangePieceSettingsCommand );

		registerCommand( REMOVE_PIECE, RemovePieceCommand );
	}

	public function startup( app : mainapp ) : void {
		sendNotification( STARTUP, app );
	}
}
}