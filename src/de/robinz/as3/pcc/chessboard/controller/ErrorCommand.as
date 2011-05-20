package de.robinz.as3.pcc.chessboard.controller
{
import mx.controls.Alert;

import org.puremvc.as3.interfaces.INotification;

/**
 * ErrorCommand
 *
 * @author robin heinel
 */
public class ErrorCommand extends BaseCommand
{
	// Start SimpleCommand overrides

	public override function execute( n : INotification ) : void {
		super.execute( n );

		if ( n.getBody() is Error ) {
			this.showError( n.getBody() as Error );
		}
	}

	// End SimpleCommand overrides


	// Start Innerclass Methods

	private function showError( e : Error ) : void {
		throw e;
		var title : String = e.name + ":" + e.errorID;
		Alert.show( e.message, title );
		trace( e.getStackTrace() );
	}

	// End Innerclass Methods

	// Start Getter / Setters

	// End Getter / Setters
}
}