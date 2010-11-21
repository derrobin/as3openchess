package de.robinz.as3.pcc.chessboard
{
	import de.robinz.as3.pcc.chessboard.controller.StartupCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.MoveCommand;
	import de.robinz.as3.pcc.chessboard.controller.move.TryToMoveCommand;
	import de.robinz.as3.pcc.chessboard.controller.piece.BeatPieceCommand;

	import org.puremvc.as3.patterns.facade.Facade;

	/**
	 * Application startup
	 *
	 * @author Robin Heinel
	 *
	 */
	public class ApplicationFacade extends Facade
	{
		public static const STARTUP : String 	= "STARTUP";

		public static const TRY_TO_MOVE : String = "TRY_TO_MOVE";
		public static const REJECT_MOVE : String = "REJECT_MOVE";
		public static const GET_MOVES : String = "GET_MOVES";
		public static const MOVE : String = "MOVE";

		public static const BEAT_PIECE_FROM_NOTATION : String = "BEAT_PIECE_FROM_NOTATION";

		public static const GAME_END : String = "gameEnd";
		public static const GAME_START : String = "gameStart";

		public static function getInstance() : ApplicationFacade {
			if ( ! instance ) {
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}

		protected override function initializeController() : void {
			super.initializeController();

			registerCommand( STARTUP, StartupCommand );

			registerCommand( TRY_TO_MOVE, TryToMoveCommand );
			registerCommand( MOVE, MoveCommand );

			registerCommand( BEAT_PIECE_FROM_NOTATION, BeatPieceCommand );
		}

		public function startup( app : mainapp ) : void {
			sendNotification( STARTUP, app );
		}
	}
}