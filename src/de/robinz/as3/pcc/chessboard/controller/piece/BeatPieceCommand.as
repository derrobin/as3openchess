package de.robinz.as3.pcc.chessboard.controller.piece
{
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.pieces.IPiece;
	import de.robinz.as3.pcc.chessboard.view.GameMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * MoveCommand
	 *
	 * @author Robin Heinel
	 *
	 */
	public class BeatPieceCommand extends SimpleCommand
	{
		public override function execute( n : INotification ) : void {
			if ( n.getBody() is Notation ) {
				this.beatPieceByNotation( n.getBody() as Notation );
			}
		}

		private function beatPieceByNotation( n : Notation ) : void {
			// store piece before it is unfetchable
			var p : IPiece = this.gm.cb.getPieceAt( n );

			// remove piece from board
			if ( this.gm.cb.removePieceFromNotation( n ) ) {
				// add piece to taken pieces
				this.gm.tp.addPiece( p );
			}
		}

		private function get gm() : GameMediator {
			return this.facade.retrieveMediator( GameMediator.NAME ) as GameMediator;
		}

	}
}