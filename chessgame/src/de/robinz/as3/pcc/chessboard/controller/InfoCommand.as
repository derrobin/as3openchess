package de.robinz.as3.pcc.chessboard.controller
{
import mx.controls.Alert;

import org.puremvc.as3.interfaces.INotification;

/**
 * InfoCommand
 *
 * @author robin heinel
 */
public class InfoCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() is String ) {
			var info : String = n.getBody() as String;
			Alert.show( info, "Info:" );
		}
	}

	// End SimpleCommand overrides
}
}