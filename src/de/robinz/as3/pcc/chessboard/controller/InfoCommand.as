package de.robinz.as3.pcc.chessboard.controller
{
	import mx.controls.Alert;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * InfoCommand
	 *
	 * @author robin heinel
	 */
	public class InfoCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( n.getBody() is String ) {
				var info : String = n.getBody() as String;
				Alert.show( info, "Info:" );
			}
		}

		// End SimpleCommand overrides
	}
}