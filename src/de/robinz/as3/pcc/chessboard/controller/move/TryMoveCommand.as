package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.library.notation.Move;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * TryMoveCommand
	 *
	 * @author Robin Heinel
	 *
	 */
	public class TryMoveCommand extends SimpleCommand
	{
		public override function execute( n : INotification ) : void {
			if ( n.getBody() is Move ) {
				this.tryMove( n as Move );
			}
		}

		private function tryMove( m : Move ) {

		}

	}
}