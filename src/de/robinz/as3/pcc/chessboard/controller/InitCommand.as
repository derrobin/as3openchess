package de.robinz.as3.pcc.chessboard.controller
{
	import de.robinz.as3.pcc.chessboard.library.Notation;
	import de.robinz.as3.pcc.chessboard.library.pieces.Bishop;
	import de.robinz.as3.pcc.chessboard.library.pieces.King;
	import de.robinz.as3.pcc.chessboard.library.pieces.Knight;
	import de.robinz.as3.pcc.chessboard.library.pieces.Pawn;
	import de.robinz.as3.pcc.chessboard.library.pieces.Piece;
	import de.robinz.as3.pcc.chessboard.library.pieces.Queen;
	import de.robinz.as3.pcc.chessboard.library.pieces.Rook;
	import de.robinz.as3.pcc.chessboard.view.ChessboardMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	/**
	 * Application initialization
	 *
	 * @author Robin Heinel
	 *
	 */
	public class InitCommand extends SimpleCommand
	{
		public override function execute( note : INotification ) : void {

			// Create Chess Start Positions
			this.setWhitePiece( Pawn.NAME, "a2" );
			this.setWhitePiece( Pawn.NAME, "b2" );
			this.setWhitePiece( Pawn.NAME, "c2" );
			this.setWhitePiece( Pawn.NAME, "d2" );
			this.setWhitePiece( Pawn.NAME, "e2" );
			this.setWhitePiece( Pawn.NAME, "f2" );
			this.setWhitePiece( Pawn.NAME, "g2" );
			this.setWhitePiece( Pawn.NAME, "h2" );
			this.setWhitePiece( Rook.NAME, "a1" );
			this.setWhitePiece( Rook.NAME, "h1" );
			this.setWhitePiece( Bishop.NAME, "c1" );
			this.setWhitePiece( Bishop.NAME, "f1" );
			this.setWhitePiece( Knight.NAME, "b1" );
			this.setWhitePiece( Knight.NAME, "g1" );
			this.setWhitePiece( Queen.NAME, "d1" );
			this.setWhitePiece( King.NAME, "e1" );


			this.setBlackPiece( Pawn.NAME, "a7" );
			this.setBlackPiece( Pawn.NAME, "b7" );
			this.setBlackPiece( Pawn.NAME, "c7" );
			this.setBlackPiece( Pawn.NAME, "d7" );
			this.setBlackPiece( Pawn.NAME, "e7" );
			this.setBlackPiece( Pawn.NAME, "f7" );
			this.setBlackPiece( Pawn.NAME, "g7" );
			this.setBlackPiece( Pawn.NAME, "h7" );
			this.setBlackPiece( Rook.NAME, "a8" );
			this.setBlackPiece( Rook.NAME, "h8" );
			this.setBlackPiece( Bishop.NAME, "c8" );
			this.setBlackPiece( Bishop.NAME, "f8" );
			this.setBlackPiece( Knight.NAME, "b8" );
			this.setBlackPiece( Knight.NAME, "g8" );
			this.setBlackPiece( Queen.NAME, "e8" );
			this.setBlackPiece( King.NAME, "d8" );
		}

		private function setWhitePiece( piece : String, shortenNotation : String ) : void {
			this.setPiece( piece, shortenNotation, true );
		}

		private function setBlackPiece( piece : String, shortenNotation : String ) : void {
			this.setPiece( piece, shortenNotation, false );
		}

		private function setPiece( piece : String, shortenNotation : String, isWhite : Boolean ) : void {
			bm.setPiece(
				Piece.createByParams( piece, isWhite ),
				Notation.createNotationByString( shortenNotation )
			);
		}

		private function get bm() : ChessboardMediator {
			return this.facade.retrieveMediator( ChessboardMediator.NAME ) as ChessboardMediator;
		}

	}
}