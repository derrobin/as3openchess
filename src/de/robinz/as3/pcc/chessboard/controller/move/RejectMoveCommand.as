package de.robinz.as3.pcc.chessboard.controller.move
{
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.view.GameMediator;

	import mx.controls.Alert;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * RejectMoveCommand
	 *
	 * @author Robin Heinel
	 *
	 */
	public class RejectMoveCommand extends SimpleCommand
	{
		public override function execute( n : INotification ) : void {
			if ( n.getBody() is ChessboardMove ) {
				this.rejectMove( n.getBody() as ChessboardMove );
			}
		}

		private function rejectMove( m : ChessboardMove ) : void {
			Alert.show( "Move rejected.", "Impossible Move!" );
			sendNotification();
		}

		private function get gm() : GameMediator {
			return this.facade.retrieveMediator( GameMediator.NAME ) as GameMediator;
		}

	}
}