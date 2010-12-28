package de.robinz.as3.pcc.chessboard.controller.move
{
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;

	import mx.controls.Alert;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * RejectMoveCommand
	 *
	 * @author robin heinel
	 */
	public class RejectMoveCommand extends SimpleCommand
	{
		// Start SimpleCommand overrides

		public override function execute( n : INotification ) : void {
			if ( n.getBody() is ChessboardMove ) {
				this.rejectMove( n.getBody() as ChessboardMove );
			}
		}

		// End SimpleCommand overrides


		// Start Innerclass Methods

		private function rejectMove( m : ChessboardMove ) : void {
			Alert.show( "Move rejected.", "Impossible Move!" );
			sendNotification();
		}

		// End Innerclass Methods


		// Start Getter / Setters

		// End Getter / Setters
	}
}