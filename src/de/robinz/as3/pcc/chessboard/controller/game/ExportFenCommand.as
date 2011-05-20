package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.controller.*;
import de.robinz.as3.pcc.chessboard.library.FENPosition;

import mx.controls.Alert;

import org.puremvc.as3.interfaces.INotification;

/**
 * ExportFenCommand
 *
 * @author robin heinel
 */
public class ExportFenCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		var fen : FENPosition = new FENPosition();
		fen.setPosition( boardMediator.getPosition() );

		Alert.show( fen.toString(), "FEN Notation" );
	}

	// End SimpleCommand overrides
}
}