package de.robinz.as3.pcc.chessboard.controller.piece
{
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.view.ApplicationMediator;
import de.robinz.as3.pcc.chessboard.view.TakenPiecesMediator;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * RemovePieceCommand
 *
 * @author robin heinel
 */
public class RemovePieceCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	// End Innerclass Methods


	// Start Getter / Setters

	private function get appMediator() : ApplicationMediator {
		return this.facade.retrieveMediator( ApplicationMediator.NAME ) as ApplicationMediator;
	}

	// End Getter / Setters
}
}