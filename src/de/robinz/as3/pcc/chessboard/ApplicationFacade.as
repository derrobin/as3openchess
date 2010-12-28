package de.robinz.as3.pcc.chessboard
{
	import de.robinz.as3.pcc.chessboard.controller.StartupCommand;
	import de.robinz.as3.pcc.chessboard.controller.game.ErrorCommand;
	import de.robinz.as3.pcc.chessboard.controller.game.GetCurrentGameCommand;
	import de.robinz.as3.pcc.chessboard.controller.game.InfoCommand;
	import de.robinz.as3.pcc.chessboard.controller.game.LoadGameCommand;
	import de.robinz.as3.pcc.chessboard.controller.game.NewGameCommand;
	import de.robinz.as3.pcc.chessboard.controller.game.SaveGameCommand;
	import de.robinz.as3.pcc.chessboard.controller.game.ShowSaveGamesCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.MoveCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.TryToMoveCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.history.MoveBackwardCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.history.MoveEndCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.history.MoveForwardCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.history.MoveStartCommand;
	import de.robinz.as3.pcc.chessboard.controller.piece.RemovePieceCommand;
	import de.robinz.as3.pcc.chessboard.controller.test.ShowAllFontKeysOnChessboardCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.AppearMoveHistoryPanelCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.AppearPieceSettingsCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.AppearTakenPiecesPanelCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.ChangePieceSettingsCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.DisappearMoveHistoryPanelCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.DisappearPieceSettingsCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.DisappearTakenPiecesPanelCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.dialog.AppearMoveHistoryModifierCommand;
	import de.robinz.as3.pcc.chessboard.controller.ui.dialog.DisappearMoveHistoryModifierCommand;

	import org.puremvc.as3.patterns.facade.Facade;

	/**
	 * ApplicationFacade
	 *
	 * @author robin heinel
	 */
	public class ApplicationFacade extends Facade
	{
		public static const STARTUP : String 	= "startup";
		public static const ERROR : String = "error";
		public static const INFO : String = "info";

		// TODO: rename it to set piece settings
		public static const SET_FONT_SETTINGS : String = "setFontSettings";

		public static const TRY_TO_MOVE : String = "toToMove";
		public static const REJECT_MOVE : String = "rejectMove";
		public static const GET_MOVES : String = "getMoves";
		public static const MOVE : String = "move";

		public static const MOVE_START : String = "moveStart";
		public static const MOVE_END : String = "moveEnd";
		public static const MOVE_FORWARD : String = "moveForward";
		public static const MOVE_FORWARD_SUCCEED : String = "moveForwardSucceed";
		public static const MOVE_BACKWARD : String = "moveBackward";
		public static const MOVE_BACKWARD_SUCCEED : String = "moveBackwardSucceed";

		public static const LOOK_BOARD : String = "lookBoard";
		public static const UNLOOK_BOARD : String = "unlookBoard";

		public static const REMOVE_PIECE : String = "removePiece";
		public static const PIECE_REMOVED : String = "pieceRemoved";

		public static const SET_PIECE : String = "setPiece";
		public static const RESTORE_PIECE : String = "restorePiece";
		public static const REMOVE_ALL_PIECES : String = "removeAllPieces";

		public static const NEW_GAME : String = "newGame";
		public static const SAVE_GAME : String = "saveGame";
		public static const SHOW_SAVE_GAMES : String = "showSaveGames";
		public static const LOAD_GAME : String = "loadGame";
		public static const GET_CURRENT_GAME : String = "getCurrentGame";
		public static const SET_CURRENT_GAME : String = "setCurrentGame";

		public static const TOGGLE_MOVE_HISTORY_PANEL : String = "toggleMoveHistoryPanel";
		public static const APPEAR_MOVE_HISTORY_PANEL : String = "appearMoveHistoryPanel";
		public static const DISAPPEAR_MOVE_HISTORY_PANEL : String = "disappearMoveHistoryPanel";
		public static const TOGGLE_TAKEN_PIECES_PANEL : String = "toolgeTakenPiecesPanel";
		public static const APPEAR_TAKEN_PIECES_PANEL : String = "appearTakenPiecesPanel";
		public static const DISAPPEAR_TAKEN_PIECES_PANEL : String = "disappearTakenPiecesPanel";

		public static const APPEAR_PANEL_SAVE_GAME : String = "appearPanelSaveGame";
		public static const DISAPPEAR_PANEL_SAVE_GAME : String = "disappearPanelSaveGame";
		public static const SET_SAVE_GAME : String = "setSaveGame";

		public static const SET_SAVE_GAMES : String = "setSaveGames";
		public static const DISAPPEAR_SAVE_GAMES : String = "disappearSaveGames";
		public static const APPEAR_SAVE_GAMES : String = "appearSaveGames";

		public static const SHOW_ALL_FONT_KEYS_ON_CHESSBOARD : String = "showAllFontKeysOnChessboard";
		public static const ENABLE_BOARD_INSPECT_PIECE_MODE : String = "enableBoardInspectPieceMode";
		public static const DISABLE_BOARD_INSPECT_PIECE_MODE : String = "disableBoardInspectPieceMode";

		public static const APPEAR_PIECE_SETTINGS : String = "appearPieceSettings";
		public static const DISAPPEAR_PIECE_SETTINGS : String = "disappearPieceSettings";
		public static const CHANGE_PIECE_SETTINGS : String = "changePieceSettings";

		public static const APPEAR_MOVE_HISTORY_MODIFIER : String = "appearMoveHistoryModifier";
		public static const DISAPPEAR_MOVE_HISTORY_MODIFIER : String = "disappearMoveHistoryModifier";

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

			registerCommand( APPEAR_MOVE_HISTORY_PANEL, AppearMoveHistoryPanelCommand );
			registerCommand( DISAPPEAR_MOVE_HISTORY_PANEL, DisappearMoveHistoryPanelCommand );
			registerCommand( APPEAR_TAKEN_PIECES_PANEL, AppearTakenPiecesPanelCommand );
			registerCommand( DISAPPEAR_TAKEN_PIECES_PANEL, DisappearTakenPiecesPanelCommand );

			registerCommand( APPEAR_PIECE_SETTINGS, AppearPieceSettingsCommand );
			registerCommand( DISAPPEAR_PIECE_SETTINGS, DisappearPieceSettingsCommand );

			registerCommand( APPEAR_MOVE_HISTORY_MODIFIER, AppearMoveHistoryModifierCommand );
			registerCommand( DISAPPEAR_MOVE_HISTORY_MODIFIER, DisappearMoveHistoryModifierCommand );

			registerCommand( MOVE_START, MoveStartCommand );
			registerCommand( MOVE_END, MoveEndCommand );
			registerCommand( MOVE_FORWARD, MoveForwardCommand );
			registerCommand( MOVE_BACKWARD, MoveBackwardCommand );

			registerCommand( SHOW_ALL_FONT_KEYS_ON_CHESSBOARD, ShowAllFontKeysOnChessboardCommand );

			registerCommand( CHANGE_PIECE_SETTINGS, ChangePieceSettingsCommand );

			registerCommand( ApplicationFacade.REMOVE_PIECE, RemovePieceCommand );
		}

		public function startup( app : mainapp ) : void {
			sendNotification( STARTUP, app );
		}
	}
}