package de.robinz.as3.pcc.chessboard.controller.move
{
	import de.robinz.as3.pcc.chessboard.library.notation.ChessboardMove;
	import de.robinz.as3.pcc.chessboard.view.GameMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * MoveCommand
	 *
	 * @author Robin Heinel
	 *
	 */
	public class MoveCommand extends SimpleCommand
	{
		public override function execute( n : INotification ) : void {
			if ( n.getBody() is ChessboardMove ) {
				this.move( n.getBody() as ChessboardMove );
			}
		}

		private function move( m : ChessboardMove ) : void {
			this.gm.mh.add( m );
		}

		private function get gm() : GameMediator {
			return this.facade.retrieveMediator( GameMediator.NAME ) as GameMediator;
		}

	}
}