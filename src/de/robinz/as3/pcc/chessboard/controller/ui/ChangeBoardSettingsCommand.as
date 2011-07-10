package de.robinz.as3.pcc.chessboard.controller.ui
{
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.controller.BaseCommand;
import de.robinz.as3.pcc.chessboard.library.vo.BoardSettingsVO;
import de.robinz.as3.pcc.chessboard.library.vo.PieceSettingsVO;
import de.robinz.as3.pcc.chessboard.model.FontProxy;

import org.puremvc.as3.interfaces.INotification;

/**
 * ChangeBoardSettingsCommand
 *
 * @author robin heinel
 */
public class ChangeBoardSettingsCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );
		this.changeBoardSettings( n.getBody() as BoardSettingsVO );
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function changeBoardSettings( sets : BoardSettingsVO ) : void {
		appProxy.board = sets;
		sendNotification( ApplicationFacade.BOARD_SETTINGS_CHANGED, sets );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get fontProxy() : FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}