package de.robinz.as3.pcc.chessboard.controller.game
{
	import de.robinz.as3.pcc.chessboard.ApplicationFacade;
	import de.robinz.as3.pcc.chessboard.library.ChessboardGame;
	import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * LoadGameCommand
	 *
	 * @author robin heinel
	 */
	public class LoadGameCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( n.getBody() is ChessboardGame ) {
				this.loadGame( n.getBody() as ChessboardGame );
			}
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		private function loadGame( game : ChessboardGame ) : void {
			sendNotification( ApplicationFacade.NEW_GAME );

			var move : ChessboardMove;
			for each( move in game.moves.list ) {
				sendNotification( ApplicationFacade.TRY_TO_MOVE, move );
			}
		}

		// End Innerclass Methods


		// Start Getter / Setters

		// End Getter / Setters
	}
}