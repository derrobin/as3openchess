package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.vo.ChessboardGameVO;
import de.robinz.as3.pcc.chessboard.library.ChessboardMove;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * LoadGameCommand
 *
 * @author robin heinel
 */
public class LoadGameCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() is ChessboardGameVO ) {
			this.loadGame( n.getBody() as ChessboardGameVO );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function loadGame( game : ChessboardGameVO ) : void {
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