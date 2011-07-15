package de.robinz.as3.pcc.chessboard.controller {
import de.robinz.as3.pcc.chessboard.ApplicationFacade;
import de.robinz.as3.pcc.chessboard.model.FontProxy;

import mx.logging.Log;
import mx.logging.LogEventLevel;
import mx.logging.targets.LineFormattedTarget;
import mx.logging.targets.TraceTarget;

import org.puremvc.as3.interfaces.INotification;

/**
 * Application initialization
 *
 * @author robin heinel
 */
public class InitCommand extends BaseCommand {
	// Start SimpleCommand overrides

	public override function execute( n : INotification ):void {
		sendNotification( ApplicationFacade.CHANGE_PIECE_SETTINGS, this.fontProxy.getPieceSettings() );
		sendNotification( ApplicationFacade.CHANGE_COLOR_SETTINGS, appProxy.colors );
		sendNotification( ApplicationFacade.BOARD_SETTINGS_CHANGED, appProxy.board );

		sendNotification( ApplicationFacade.NEW_GAME );
		sendNotification( ApplicationFacade.APPEAR_MOVE_HISTORY_PANEL );
		sendNotification( ApplicationFacade.APPEAR_GAME_ACTIONS_PANEL );
		sendNotification( ApplicationFacade.APPEAR_TAKEN_PIECES_PANEL );


		this.prepareLogging();
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function prepareLogging():void {
		this.prepareLoggingTarget( new TraceTarget() );
	}

	private function prepareLoggingTarget( target : LineFormattedTarget ) : void {
		// Log only messages for the classes in the mx.rpc.* and
		// mx.messaging packages.
		target.filters = [ "*" ];

		// Log all log levels.
		target.level = LogEventLevel.ALL;

		// Add date, time, category, and log level to the output.
		target.includeDate = true;
		target.includeTime = true;
		target.includeCategory = true;
		target.includeLevel = true;

		// Start logging.
		Log.addTarget( target );
	}

	// End Innerclass Methods


	// Start Getter / Setters

	private function get fontProxy():FontProxy {
		return this.facade.retrieveProxy( FontProxy.NAME ) as FontProxy;
	}

	// End Getter / Setters
}
}