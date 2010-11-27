package de.robinz.as3.pcc.chessboard.controller.game
{
	import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
	import de.robinz.as3.pcc.chessboard.library.pieces.Rook;
	import de.robinz.as3.pcc.chessboard.view.GameMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * NewGameCommand
	 *
	 * @author Robin Heinel
	 *
	 */
	public class NewGameCommand extends SimpleCommand
	{
		public override function execute( n : INotification ) : void {
			this.gm.mh.reset();
			this.gm.cb.removeAllPieces();
			this.gm.tp.reset();
			this.setDefaultPieces();
		}

		/**
		 * Create Chess Start Positions
		 *
		 */
		private function setDefaultPieces() : void {
			this.gm.setWhitePiece( Pawn.NAME, "a2" );
			this.gm.setWhitePiece( Pawn.NAME, "b2" );
			this.gm.setWhitePiece( Pawn.NAME, "c2" );
			this.gm.setWhitePiece( Pawn.NAME, "d2" );
			this.gm.setWhitePiece( Pawn.NAME, "e2" );
			this.gm.setWhitePiece( Pawn.NAME, "f2" );
			this.gm.setWhitePiece( Pawn.NAME, "g2" );
			this.gm.setWhitePiece( Pawn.NAME, "h2" );
			this.gm.setWhitePiece( Rook.NAME, "a1" );
			this.gm.setWhitePiece( Rook.NAME, "h1" );
			this.gm.setWhitePiece( Bishop.NAME, "c1" );
			this.gm.setWhitePiece( Bishop.NAME, "f1" );
			this.gm.setWhitePiece( Knight.NAME, "b1" );
			this.gm.setWhitePiece( Knight.NAME, "g1" );
			this.gm.setWhitePiece( Queen.NAME, "d1" );
			this.gm.setWhitePiece( King.NAME, "e1" );

			this.gm.setBlackPiece( Pawn.NAME, "a7" );
			this.gm.setBlackPiece( Pawn.NAME, "b7" );
			this.gm.setBlackPiece( Pawn.NAME, "c7" );
			this.gm.setBlackPiece( Pawn.NAME, "d7" );
			this.gm.setBlackPiece( Pawn.NAME, "e7" );
			this.gm.setBlackPiece( Pawn.NAME, "f7" );
			this.gm.setBlackPiece( Pawn.NAME, "g7" );
			this.gm.setBlackPiece( Pawn.NAME, "h7" );
			this.gm.setBlackPiece( Rook.NAME, "a8" );
			this.gm.setBlackPiece( Rook.NAME, "h8" );
			this.gm.setBlackPiece( Bishop.NAME, "c8" );
			this.gm.setBlackPiece( Bishop.NAME, "f8" );
			this.gm.setBlackPiece( Knight.NAME, "b8" );
			this.gm.setBlackPiece( Knight.NAME, "g8" );
			this.gm.setBlackPiece( Queen.NAME, "e8" );
			this.gm.setBlackPiece( King.NAME, "d8" );
		}

		private function get gm() : GameMediator {
			return this.facade.retrieveMediator( GameMediator.NAME ) as GameMediator;
		}

	}
}