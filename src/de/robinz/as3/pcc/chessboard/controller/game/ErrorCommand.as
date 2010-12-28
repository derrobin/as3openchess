package de.robinz.as3.pcc.chessboard.controller.game
{
	import mx.controls.Alert;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * ErrorCommand
	 *
	 * @author robin heinel
	 */
	public class ErrorCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
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