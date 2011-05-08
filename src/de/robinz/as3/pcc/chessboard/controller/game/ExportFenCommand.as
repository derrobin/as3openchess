package de.robinz.as3.pcc.chessboard.controller.game
{
import de.robinz.as3.pcc.chessboard.controller.*;
import de.robinz.as3.pcc.chessboard.library.ChessPosition;
import de.robinz.as3.pcc.chessboard.library.FENPosition;
import de.robinz.as3.pcc.chessboard.library.FENPosition;

import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardField;
import de.robinz.as3.pcc.chessboard.view.views.chessboard.ChessboardFieldCollection;

import mx.controls.Alert;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

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